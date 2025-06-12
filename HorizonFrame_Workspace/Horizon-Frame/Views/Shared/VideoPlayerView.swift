import SwiftUI
import AVFoundation

// A UIViewRepresentable to wrap AVPlayerLayer for seamless, looping video playback.
struct VideoPlayerView: UIViewRepresentable {
    let videoName: String

    func makeUIView(context: Context) -> UIView {
        print("VideoPlayerView: Creating view for video: \(videoName)")
        return LoopingPlayerUIView(videoName: videoName)
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // No updates needed for this simple player.
    }
}

// A custom UIView that sets up and manages the AVPlayer and its layer.
private class LoopingPlayerUIView: UIView {
    private var playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?
    private var player: AVQueuePlayer?

    init(videoName: String) {
        super.init(frame: .zero)

        print("LoopingPlayerUIView: Initializing with video: \(videoName)")
        
        // Find the video file in the app's bundle using the full path.
        let fileName = (videoName as NSString).deletingPathExtension
        let fileExtension = (videoName as NSString).pathExtension.isEmpty ? "mp4" : (videoName as NSString).pathExtension
        
        // Try multiple possible locations for the video file
        let possibleLocations = [
            (nil, nil),                    // Root of bundle
            (nil, "Media/Videos"),          // As subdirectory
            ("Media/Videos", nil),          // As part of name
            ("Videos", nil),                // Just Videos folder
        ]
        
        var fileUrl: URL? = nil
        for (prefix, subdir) in possibleLocations {
            let searchName = prefix.map { "\($0)/\(fileName)" } ?? fileName
            print("Trying to find video: \(searchName).\(fileExtension) in subdirectory: \(subdir ?? "<none>")")
            
            if let url = Bundle.main.url(forResource: searchName, withExtension: fileExtension, subdirectory: subdir) {
                fileUrl = url
                print("Found video at: \(url)")
                break
            }
        }
        
        guard let fileUrl = fileUrl else {
            print("Error: Video file not found in any location: \(videoName)")
            print("Available .mp4 files in bundle: \(Bundle.main.paths(forResourcesOfType: "mp4", inDirectory: nil))")
            backgroundColor = .black
            return
        }


        // Set up the player
        let asset = AVURLAsset(url: fileUrl)
        let item = AVPlayerItem(asset: asset)
        player = AVQueuePlayer(playerItem: item)

        // Set up the layer
        if let player = player {
            playerLayer.player = player
        }
        playerLayer.videoGravity = .resizeAspectFill // Cover the whole area
        layer.addSublayer(playerLayer)

        // Set up the looper
        if let player = player {
            playerLooper = AVPlayerLooper(player: player, templateItem: item)
        }

        // Start playback
        player?.play()
    }

    // Ensure the player layer always fills the view's bounds.
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
