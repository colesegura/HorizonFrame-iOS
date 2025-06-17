import SwiftUI

struct OnboardingGeneratingReportView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    // Animation state
    @State private var messages = [
        "Analyzing your answers...",
        "Identifying key patterns...",
        "Aligning with your goals...",
        "Building your personalized plan..."
    ]
    @State private var currentMessageIndex = 0
    @State private var progress: Double = 0.0

    let timer = Timer.publish(every: 1.5, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Image(systemName: "gear.shape.2.fill")
                .font(.system(size: 80))
                .foregroundColor(.accentColor)
                .rotationEffect(.degrees(progress * 360))
            
            Text(messages[currentMessageIndex])
                .font(.title2)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .transition(.opacity.combined(with: .move(edge: .top)))
                .id("message_\(currentMessageIndex)")
            
            ProgressView(value: progress)
                .progressViewStyle(LinearProgressViewStyle(tint: .accentColor))
                .padding(.horizontal, 40)
                .animation(.easeInOut(duration: 1.5), value: progress)

            Spacer()
            Spacer()
        }
        .padding()
        .onAppear {
            updateProgressAndMessage()
        }
        .onReceive(timer) { _ in
            updateProgressAndMessage()
        }
    }
    
    private func updateProgressAndMessage() {
        guard currentMessageIndex < messages.count - 1 else {
            progress = 1.0
            timer.upstream.connect().cancel()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                viewModel.advanceToPaywall()
            }
            return
        }
        
        withAnimation(.easeInOut(duration: 0.5)) {
            currentMessageIndex += 1
        }
        progress = Double(currentMessageIndex) / Double(messages.count - 1)
    }
}
