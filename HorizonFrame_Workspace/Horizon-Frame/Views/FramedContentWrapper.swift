import SwiftUI

// This view wraps content and draws a frame (four corners) around it.
// It uses GeometryReader to accurately place corners around the content's actual size.

struct FramedContentWrapper<Content: View>: View {
    let content: Content
    let cornerSize: CGFloat
    let lineWidth: CGFloat
    let frameColor: Color

    init(cornerSize: CGFloat = 15, lineWidth: CGFloat = 2, frameColor: Color = .white, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.cornerSize = cornerSize
        self.lineWidth = lineWidth
        self.frameColor = frameColor
    }

    var body: some View {
        content
            .padding(cornerSize / 2 + lineWidth / 2) // Adjust padding to ensure frame is outside content bounds
            .overlay(
                GeometryReader { geometry in
                    let w = geometry.size.width
                    let h = geometry.size.height

                    // Top-Left
                    FrameCornerView(size: cornerSize, lineWidth: lineWidth, color: frameColor)
                        .position(x: cornerSize / 2, y: cornerSize / 2)
                    
                    // Top-Right
                    FrameCornerView(size: cornerSize, lineWidth: lineWidth, color: frameColor)
                        .rotationEffect(.degrees(90))
                        .position(x: w - cornerSize / 2, y: cornerSize / 2)
                    
                    // Bottom-Left
                    FrameCornerView(size: cornerSize, lineWidth: lineWidth, color: frameColor)
                        .rotationEffect(.degrees(-90))
                        .position(x: cornerSize / 2, y: h - cornerSize / 2)
                    
                    // Bottom-Right
                    FrameCornerView(size: cornerSize, lineWidth: lineWidth, color: frameColor)
                        .rotationEffect(.degrees(180))
                        .position(x: w - cornerSize / 2, y: h - cornerSize / 2)
                }
            )
    }
}

#if DEBUG
struct FramedContentWrapper_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            AnimatedGradientBackground().ignoresSafeArea() // Use the new gradient for preview
            VStack {
                FramedContentWrapper(cornerSize: 20, lineWidth: 3, frameColor: .cyan) {
                    Text("Align")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                }
                .padding()

                FramedContentWrapper(cornerSize: 15, lineWidth: 2, frameColor: .yellow) {
                    Image(systemName: "folder.fill")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(15)
                }
            }
        }
    }
}
#endif
