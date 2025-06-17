import SwiftUI

struct OnboardingPaywallView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @Binding var isPresented: Bool
    @EnvironmentObject var storeManager: StoreManager

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            Text("Unlock Your Full Potential")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)

            Text("Choose a plan to continue your journey with full access to all features.")
                .font(.headline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            // This reuses the existing subscription view
            SubscriptionOptionsView()

            Spacer()

            Button(action: {
                // This completes the onboarding and dismisses the sheet
                viewModel.completeOnboarding(isPresented: $isPresented)
            }) {
                Text("Continue without Premium")
                    .font(.headline)
                    .foregroundColor(.accentColor)
            }
            .padding(.bottom)
        }
        .padding()
    }
}
