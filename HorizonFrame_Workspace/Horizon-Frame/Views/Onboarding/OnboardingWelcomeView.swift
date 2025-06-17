import SwiftUI

struct OnboardingWelcomeView: View {
    @ObservedObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            // Placeholder for App Logo
            Image(systemName: "sparkles")
                .font(.system(size: 80))
                .foregroundColor(.accentColor)
            
            Text("Welcome to HorizonFrame")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text("Begin your journey to a more aligned and intentional life.")
                .font(.headline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()
            
            Button(action: {
                viewModel.advance()
            }) {
                Text("Get Started")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .cornerRadius(16)
            }
            .padding(.horizontal)
            
            Button(action: {
                // Placeholder for existing account login
                print("Login with existing account tapped")
            }) {
                Text("Use existing account")
                    .font(.headline)
                    .foregroundColor(.accentColor)
            }
            .padding(.bottom)
        }
        .padding()
    }
}
