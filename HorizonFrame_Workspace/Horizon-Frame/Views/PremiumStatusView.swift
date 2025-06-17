import SwiftUI

struct PremiumStatusView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var storeManager: StoreManager // To potentially show more details or refresh

    var body: some View {
        NavigationView { // Wrap in NavigationView for a title and dismiss button if presented as a full sheet
            ZStack {
                AnimatedGradientBackground().edgesIgnoringSafeArea(.all)

                VStack(spacing: 30) {
                    Image(systemName: "crown.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.yellow)

                    Text("You are a HorizonFrame Premium Member!")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    Text("Thank you for your support. You have access to all exclusive features.")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    Button(action: {
                        // Attempt to open App Store subscription management page
                        if let url = URL(string: "itms-apps://apps.apple.com/account/subscriptions") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        Text("Manage Subscription")
                            .font(.system(size: 17, weight: .bold, design: .rounded))
                            .foregroundColor(.black)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(16)
                    }
                    .padding(.horizontal, 40)
                    
                    Button(action: { dismiss() }) {
                        Text("Dismiss")
                            .font(.system(size: 17, weight: .medium, design: .rounded))
                            .foregroundColor(.white.opacity(0.7))
                    }
                    .padding(.top, 10)
                }
                .padding()
            }
            .navigationTitle("Premium Status")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.white.opacity(0.7))
                    }
                }
            }
        }
        .accentColor(.white) // For NavigationView elements
    }
}

struct PremiumStatusView_Previews: PreviewProvider {
    static var previews: some View {
        PremiumStatusView()
            .environmentObject(StoreManager()) // Ensure StoreManager is available for preview
            .preferredColorScheme(.dark)
    }
}
