import SwiftUI
import AVFoundation
import Photos

// Helper for UIActivityViewController (Share Sheet)
struct ActivityView: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

struct AlignPassageView: View {
    let passage: Passage
    let videoName: String

    @State private var currentLineIndex: Int = 0
    @Environment(\.dismiss) var dismiss

    private var passageLines: [String] {
        guard !passage.content.isEmpty else { return [] }
        return passage.content.split(whereSeparator: \.isNewline).map(String.init)
    }

    private let videoGenerator = PassageVideoGenerator()
    private let videoOutputSize = CGSize(width: 1080, height: 1920)
    private let videoLineDuration: Double = 3.0
    private let videoFramesPerSecond: CMTimeScale = 30

    @State private var isGeneratingVideo = false
    @State private var videoGenerationProgress: Double = 0.0
    @State private var generatedVideoURL: URL?
    @State private var showShareSheet = false
    @State private var showErrorAlert = false
    @State private var alertMessage: String = ""

    var body: some View {
        ZStack {
            VideoPlayerView(videoName: self.videoName)
                .ignoresSafeArea()
                .overlay(
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                )
            
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    Text(passage.title)
                        .font(.title2).bold()
                        .foregroundColor(.white.opacity(0.9))
                        .padding(.bottom, 5)

                    ForEach(Array(passageLines.enumerated()), id: \.offset) { index, line in
                        Text(line)
                            .font(index == currentLineIndex ? .title3.weight(.heavy) : .title3.weight(.regular))
                            .foregroundColor(index == currentLineIndex ? .white : .gray.opacity(0.8))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 2)
                    }
                    Spacer()
                }
                .padding()
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            if !passageLines.isEmpty {
                 currentLineIndex = (currentLineIndex + 1) % passageLines.count
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .font(.title2.weight(.semibold))
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                if isGeneratingVideo {
                    FillingCircleProgressView(progress: videoGenerationProgress)
                        .frame(width: 30, height: 30)
                } else {
                    Button(action: startVideoGeneration) {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(.white)
                            .font(.title2.weight(.semibold))
                    }
                    .disabled(passageLines.isEmpty)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(passage.title)
        .sheet(isPresented: $showShareSheet, onDismiss: {
            if let url = generatedVideoURL {
                try? FileManager.default.removeItem(at: url)
                generatedVideoURL = nil
            }
        }) {
            if let url = generatedVideoURL {
                ActivityView(activityItems: [url])
            }
        }
        .alert("Video Export", isPresented: $showErrorAlert, actions: {
            Button("OK", role: .cancel) { }
        }, message: {
            Text(alertMessage)
        })
    }

    func startVideoGeneration() {
        guard !passageLines.isEmpty else {
            alertMessage = "There is no passage text to export."
            showErrorAlert = true
            return
        }

        isGeneratingVideo = true
        videoGenerationProgress = 0.0

        Task {
            videoGenerator.generateVideo(
                passage: self.passage,
                videoFileName: (self.videoName as NSString).deletingPathExtension,
                passageLines: self.passageLines,
                outputSize: self.videoOutputSize,
                framesPerSecond: self.videoFramesPerSecond,
                lineDuration: self.videoLineDuration,
                progressHandler: { progress in
                    DispatchQueue.main.async {
                        self.videoGenerationProgress = progress
                    }
                },
                completionHandler: { result in
                    DispatchQueue.main.async {
                        self.isGeneratingVideo = false
                        switch result {
                        case .success(let url):
                            self.generatedVideoURL = url
                            PHPhotoLibrary.requestAuthorization { status in
                                if status == .authorized {
                                    PHPhotoLibrary.shared().performChanges({
                                        PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: url)
                                    }) { saved, error in
                                        if saved {
                                            DispatchQueue.main.async {
                                                self.alertMessage = "Video saved to Photos successfully."
                                                self.showErrorAlert = true
                                            }
                                        } else if error != nil {
                                            DispatchQueue.main.async {
                                                self.alertMessage = "An error occurred while saving the video to your Photos. Please try again."
                                                self.showErrorAlert = true
                                            }
                                        }
                                    }
                                } else {
                                    DispatchQueue.main.async {
                                        self.alertMessage = "Permission to access Photos is required to save the video."
                                        self.showErrorAlert = true
                                    }
                                }
                            }
                            self.showShareSheet = true
                        case .failure:
                            self.alertMessage = "An unexpected error occurred while creating your video. Please try again."
                            self.showErrorAlert = true
                        }
                    }
                }
            )
        }
    }
}

#if DEBUG
struct AlignPassageView_Previews: PreviewProvider {
    static var previews: some View {
        let samplePassage = Passage(
            title: "Preview Title",
            content: "This is the first line.\nThis is the second line.\nAnd a third line for this preview.",
            author: "Preview Author",
            category: "Preview Category",
            tags: ["preview", "align"],
            videoName: "HF_Vid_Waves_01"
        )
        NavigationView {
            AlignPassageView(passage: samplePassage, videoName: samplePassage.videoName!)
        }
    }
}
#endif
