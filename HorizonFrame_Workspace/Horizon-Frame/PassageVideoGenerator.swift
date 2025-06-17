import AVFoundation
import SwiftUI // For PassageFrameView and rendering
import UIKit

class PassageVideoGenerator: @unchecked Sendable {
    private let pixelFormat = kCVPixelFormatType_32BGRA

    enum VideoGeneratorError: Error {
        case invalidVideoPath
        case assetInitializationFailed
        case assetWriterInitializationFailed
        case assetWriterInputInitializationFailed
        case pixelBufferCreationFailed
        case frameAppendFailed
        case videoCreationFailed
        case pixelBufferPoolCreationFailed
    }

    init() {}

    public func generateVideo(
        passage: Passage,
        videoFileName: String,
        passageLines: [String],
        outputSize: CGSize = CGSize(width: 1080, height: 1920),
        framesPerSecond: Int32 = 30,
        lineDuration: TimeInterval = 2.0,
        progressHandler: @escaping (Double) -> Void,
        completionHandler: @escaping (Result<URL, VideoGeneratorError>) -> Void
    ) {
        Task.detached {
            let outputFileName = "AlignPassageExport_\(UUID().uuidString).mp4"
            let outputURL = FileManager.default.temporaryDirectory.appendingPathComponent(outputFileName)

            let resourceName = (videoFileName as NSString).deletingPathExtension
            guard let videoFileUrl = Bundle.main.url(forResource: resourceName, withExtension: "mp4") else {
                print("Error: Video file \(resourceName).mp4 not found in bundle.")
                completionHandler(.failure(.invalidVideoPath))
                return
            }
            let asset = AVURLAsset(url: videoFileUrl)
            let imageGenerator = AVAssetImageGenerator(asset: asset)
            imageGenerator.appliesPreferredTrackTransform = true
            imageGenerator.maximumSize = outputSize
            // Ensure we fetch the *exact* frame for each timestamp instead of the nearest keyframe.
            // Without these, AVAssetImageGenerator often snaps to keyframes (commonly spaced ~0.5 s apart),
            // which causes the "slideshow" effect you observed.
            imageGenerator.requestedTimeToleranceBefore = .zero
            imageGenerator.requestedTimeToleranceAfter = .zero

            do {
                let assetWriter = try AVAssetWriter(outputURL: outputURL, fileType: .mp4)

                let videoSettings: [String: Any] = [
                    AVVideoCodecKey: AVVideoCodecType.h264,
                    AVVideoWidthKey: Int(outputSize.width),
                    AVVideoHeightKey: Int(outputSize.height)
                ]

                let assetWriterInput = AVAssetWriterInput(mediaType: .video, outputSettings: videoSettings)
                assetWriterInput.expectsMediaDataInRealTime = false

                let pixelBufferAdaptor = AVAssetWriterInputPixelBufferAdaptor(
                    assetWriterInput: assetWriterInput,
                    sourcePixelBufferAttributes: [
                        kCVPixelBufferPixelFormatTypeKey as String: self.pixelFormat,
                        kCVPixelBufferWidthKey as String: Int(outputSize.width),
                        kCVPixelBufferHeightKey as String: Int(outputSize.height)
                    ]
                )

                guard assetWriter.canAdd(assetWriterInput) else {
                    completionHandler(.failure(.assetWriterInputInitializationFailed))
                    return
                }
                assetWriter.add(assetWriterInput)

                guard assetWriter.startWriting() else {
                    completionHandler(.failure(.assetWriterInitializationFailed))
                    return
                }
                assetWriter.startSession(atSourceTime: .zero)

                let totalDuration = Double(passageLines.count) * lineDuration
                let totalFrames = Int(totalDuration * Double(framesPerSecond))
                var currentFrameValueForCMTime: Int64 = 0

                for lineIndex in 0..<passageLines.count {
                    for _ in 0..<Int(lineDuration * Double(framesPerSecond)) {
                        let cmTime = CMTime(value: currentFrameValueForCMTime, timescale: framesPerSecond)

                        if !assetWriterInput.isReadyForMoreMediaData {
                            var waitCount = 0
                            while !assetWriterInput.isReadyForMoreMediaData && waitCount < 30 {
                                if assetWriter.status != .writing {
                                    completionHandler(.failure(.frameAppendFailed))
                                    return
                                }
                                try? await Task.sleep(nanoseconds: 100_000_000)
                                waitCount += 1
                            }
                        }

                        guard assetWriterInput.isReadyForMoreMediaData else {
                            completionHandler(.failure(.frameAppendFailed))
                            return
                        }

                        var optionalPixelBuffer: CVPixelBuffer?
                        guard let pool = pixelBufferAdaptor.pixelBufferPool else {
                            completionHandler(.failure(.pixelBufferPoolCreationFailed))
                            return
                        }
                        CVPixelBufferPoolCreatePixelBuffer(nil, pool, &optionalPixelBuffer)
                        guard let pixelBuffer = optionalPixelBuffer else {
                            completionHandler(.failure(.pixelBufferCreationFailed))
                            return
                        }

                        CVPixelBufferLockBaseAddress(pixelBuffer, [])
                        if let context = self.createContext(for: pixelBuffer, size: outputSize) {
                            // 1. Draw background video frame
                            if let videoFrameImage = try? imageGenerator.copyCGImage(at: cmTime, actualTime: nil) {
                                context.draw(videoFrameImage, in: CGRect(origin: .zero, size: outputSize))
                            }

                            // 2. Render and draw SwiftUI overlay
                            let frameView = VideoFrameView(passageLines: passageLines, highlightedLineIndex: lineIndex)
                                .frame(width: outputSize.width, height: outputSize.height)
                                .background(Color.clear)

                            if let overlayImage = await self.renderViewToImage(frameView, size: outputSize) {
                                // The context origin is bottom-left. UIImage's is top-left. We need to flip the context for UIImage drawing.
                                context.saveGState()
                                context.translateBy(x: 0, y: outputSize.height)
                                context.scaleBy(x: 1.0, y: -1.0)
                                
                                UIGraphicsPushContext(context)
                                overlayImage.draw(in: CGRect(origin: .zero, size: outputSize))
                                UIGraphicsPopContext()
                                
                                context.restoreGState() // Restore the context
                            }
                        }
                        CVPixelBufferUnlockBaseAddress(pixelBuffer, [])

                        if !pixelBufferAdaptor.append(pixelBuffer, withPresentationTime: cmTime) {
                            completionHandler(.failure(.frameAppendFailed))
                            return
                        }

                        currentFrameValueForCMTime += 1
                        let progress = Double(currentFrameValueForCMTime) / Double(totalFrames)
                        progressHandler(min(progress, 1.0))
                    }
                }

                assetWriterInput.markAsFinished()
                await assetWriter.finishWriting()
                completionHandler(.success(outputURL))

            } catch {
                completionHandler(.failure(.assetWriterInitializationFailed))
            }
        }
    }

    private func createContext(for pixelBuffer: CVPixelBuffer, size: CGSize) -> CGContext? {
        guard let baseAddress = CVPixelBufferGetBaseAddress(pixelBuffer) else { return nil }
        let bytesPerRow = CVPixelBufferGetBytesPerRow(pixelBuffer)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        return CGContext(
            data: baseAddress,
            width: Int(size.width),
            height: Int(size.height),
            bitsPerComponent: 8,
            bytesPerRow: bytesPerRow,
            space: colorSpace,
            bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue | CGBitmapInfo.byteOrder32Little.rawValue
        )
    }

    @MainActor
    private func renderViewToImage<V: View>(_ view: V, size: CGSize) -> UIImage? {
        let renderer = ImageRenderer(content: view)
        renderer.proposedSize = ProposedViewSize(size)
        // Ensure the scale is appropriate for the device's screen
        renderer.scale = UIScreen.main.scale
        
        // Using .uiImage property renders the view to a UIImage
        return renderer.uiImage
    }
}
