import SwiftUI

struct FrameConfig: Identifiable {
    let id = UUID()
    var initialOffset: CGSize
    var finalSize: CGFloat
    var cornerSize: CGFloat
    var lineWidth: CGFloat
    var delay: Double
    var initialScale: CGFloat = 0.3
    var initialOpacity: Double = 0.0
}

struct KineticFramesLaunchView: View {
    let frameConfigs: [FrameConfig] = [
        FrameConfig(initialOffset: CGSize(width: -UIScreen.main.bounds.width / 1.5, height: 0), finalSize: 320, cornerSize: 80, lineWidth: 9, delay: 0.0, initialScale: 0.2, initialOpacity: 0),
        FrameConfig(initialOffset: CGSize(width: UIScreen.main.bounds.width / 1.5, height: 0), finalSize: 240, cornerSize: 60, lineWidth: 8, delay: 0.1, initialScale: 0.2, initialOpacity: 0),
        FrameConfig(initialOffset: CGSize(width: 0, height: -UIScreen.main.bounds.height / 1.5), finalSize: 170, cornerSize: 42, lineWidth: 7, delay: 0.2, initialScale: 0.2, initialOpacity: 0),
        FrameConfig(initialOffset: CGSize(width: 0, height: UIScreen.main.bounds.height / 1.5), finalSize: 110, cornerSize: 27, lineWidth: 6, delay: 0.3, initialScale: 0.2, initialOpacity: 0),
        FrameConfig(initialOffset: .zero, finalSize: 60, cornerSize: 15, lineWidth: 5, delay: 0.4, initialScale: 0.1, initialOpacity: 0)
    ]

    @State private var framesHaveAnimatedIn = false
    @State private var overallZoomScale: CGFloat = 1.0
    @State private var framesGroupOpacity: Double = 1.0
    @State private var showMainContent = false

    // Durations and timing
    let individualFrameAnimationDuration: Double = 0.8 // Spring response for each frame
    let timeUntilLastFrameSettles: Double
    let zoomAnimationDuration: Double = 0.7
    let finalTransitionDuration: Double = 0.5

    init() {
        let maxDelay = frameConfigs.max(by: { $0.delay < $1.delay })?.delay ?? 0.0
        self.timeUntilLastFrameSettles = maxDelay + individualFrameAnimationDuration
    }

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            // Group for all kinetic frames, this group will be scaled and faded
            ZStack {
                ForEach(frameConfigs) { config in
                    AnimatedFrameView(config: config, 
                                      triggerAnimation: $framesHaveAnimatedIn, 
                                      animationDuration: individualFrameAnimationDuration)
                }
            }
            .scaleEffect(overallZoomScale)
            .opacity(framesGroupOpacity)

            if showMainContent {
                ContentView() // Transition to the main app content
                    .transition(.opacity.animation(.easeInOut(duration: finalTransitionDuration)))
            }
        }
        .onAppear {
            if !framesHaveAnimatedIn {
                // 1. Trigger individual frame animations
                framesHaveAnimatedIn = true

                // 2. Schedule the zoom animation after frames are in place
                DispatchQueue.main.asyncAfter(deadline: .now() + timeUntilLastFrameSettles) {
                    withAnimation(.easeInOut(duration: zoomAnimationDuration)) {
                        overallZoomScale = 15.0 // Zoom in significantly
                        framesGroupOpacity = 0.0  // Fade out frames as we zoom past
                    }

                    // 3. Schedule showing main content after zoom completes
                    DispatchQueue.main.asyncAfter(deadline: .now() + zoomAnimationDuration - (finalTransitionDuration * 0.7) ) { // Start transition slightly before zoom fully ends
                        showMainContent = true
                    }
                }
            }
        }
    }
}

struct AnimatedFrameView: View {
    let config: FrameConfig
    @Binding var triggerAnimation: Bool
    let animationDuration: Double

    @State private var currentOffset: CGSize
    @State private var currentScale: CGFloat
    @State private var currentOpacity: Double

    init(config: FrameConfig, triggerAnimation: Binding<Bool>, animationDuration: Double) {
        self.config = config
        self._triggerAnimation = triggerAnimation
        self.animationDuration = animationDuration
        _currentOffset = State(initialValue: config.initialOffset)
        _currentScale = State(initialValue: config.initialScale)
        _currentOpacity = State(initialValue: config.initialOpacity)
    }

    var body: some View {
        KineticFrameView(
            frameSize: config.finalSize,
            cornerSize: config.cornerSize,
            lineWidth: config.lineWidth,
            color: .white
        )
        .scaleEffect(currentScale)
        .offset(currentOffset)
        .opacity(currentOpacity)
        .onChange(of: triggerAnimation) { newValue in
            if newValue {
                withAnimation(.spring(response: animationDuration, dampingFraction: 0.7).delay(config.delay)) {
                    currentOffset = .zero
                    currentScale = 1.0
                    currentOpacity = 1.0
                }
            }
        }
    }
}

#Preview {
    KineticFramesLaunchView()
}
