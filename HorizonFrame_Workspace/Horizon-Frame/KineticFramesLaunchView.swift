import SwiftUI

struct FrameConfig: Identifiable {
    let id = UUID()
    var initialOffset: CGSize
    var finalSize: CGFloat
    var cornerSize: CGFloat
    var lineWidth: CGFloat
    var delay: Double
    var initialScale: CGFloat = 0.3 // Start smaller
    var initialOpacity: Double = 0.0 // Start invisible
}

struct KineticFramesLaunchView: View {
    // Define configurations for each frame
    // These are examples, adjust as needed for your design
    let frameConfigs: [FrameConfig] = [
        FrameConfig(initialOffset: CGSize(width: -UIScreen.main.bounds.width / 2, height: 0), finalSize: 300, cornerSize: 75, lineWidth: 8, delay: 0.1),
        FrameConfig(initialOffset: CGSize(width: UIScreen.main.bounds.width / 2, height: 0), finalSize: 220, cornerSize: 55, lineWidth: 7, delay: 0.2),
        FrameConfig(initialOffset: CGSize(width: 0, height: -UIScreen.main.bounds.height / 2), finalSize: 150, cornerSize: 37, lineWidth: 6, delay: 0.3),
        FrameConfig(initialOffset: CGSize(width: 0, height: UIScreen.main.bounds.height / 2), finalSize: 90, cornerSize: 22, lineWidth: 5, delay: 0.4),
        FrameConfig(initialOffset: .zero, finalSize: 50, cornerSize: 12, lineWidth: 4, delay: 0.5, initialScale: 0.1) // Innermost starts very small
    ]

    @State private var hasAnimated = false
    @State private var showMainContent = false // To transition after animation

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            ZStack {
                ForEach(frameConfigs) { config in
                    AnimatedFrameView(config: config, hasAnimated: $hasAnimated)
                }
            }
            .onAppear {
                if !hasAnimated {
                    // Stagger the overall animation start slightly if needed, then trigger individual frames
                    // For this setup, individual delays handle staggering.
                    hasAnimated = true
                    
                    // After animation, transition to main content
                    // Adjust timing based on longest animation + delay
                    DispatchQueue.main.asyncAfter(deadline: .now() + (frameConfigs.last?.delay ?? 0.5) + 1.0) { // 1.0s is animation duration
                        withAnimation {
                            // This is where you'd transition to your main app view
                            // For now, we'll just toggle a flag for demonstration
                            showMainContent = true 
                        }
                    }
                }
            }
            
            // Placeholder for main content after animation
            if showMainContent {
                Text("Main App Content")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .transition(.opacity.animation(.easeInOut(duration: 0.5)))
            }
        }
    }
}

struct AnimatedFrameView: View {
    let config: FrameConfig
    @Binding var hasAnimated: Bool

    @State private var currentOffset: CGSize
    @State private var currentScale: CGFloat
    @State private var currentOpacity: Double

    init(config: FrameConfig, hasAnimated: Binding<Bool>) {
        self.config = config
        self._hasAnimated = hasAnimated
        // Initialize state based on whether animation has run or initial values
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
        .onChange(of: hasAnimated) { newValue in
            if newValue {
                withAnimation(.spring(response: 0.8, dampingFraction: 0.7).delay(config.delay)) {
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
