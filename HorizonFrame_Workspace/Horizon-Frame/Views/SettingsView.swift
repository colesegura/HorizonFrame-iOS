import SwiftUI

struct SettingsView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @EnvironmentObject var storeManager: StoreManager
    @EnvironmentObject var appState: AppStateManager
    // Assuming ReferralViewModel might not be available, using a placeholder for referral code
    // @EnvironmentObject var referralViewModel: ReferralViewModel 
    @State private var userReferralCode: String = ReferralCodeManager.shared.getReferralCode()

    @State private var showSubscriptionSheet = false
    @State private var showReferralSheet = false
    @State private var showPremiumFeatureLockedAlert = false
    @State private var showPremiumStatusSheet = false
    @State private var lockedFeatureName: String = ""
    
    // Example state for a toggle (can be adapted or removed)
    @State private var appearanceSelection: Int = 0 // 0: System, 1: Light, 2: Dark

    var body: some View {
        NavigationView {
            Form {
                // MARK: - Account Section
                Section(header: Text("Account")) {
                    HStack {
                        Text("Your Referral Code")
                        Spacer()
                        Text(userReferralCode)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .contentShape(Rectangle()) // Make entire row tappable
                    .onTapGesture {
                        showReferralSheet = true
                    }

                    if storeManager.isPremium {
                        Button("Manage Subscription") {
                            showPremiumStatusSheet = true
                        }
                    } else {
                        Button("Unlock All Features") {
                            showSubscriptionSheet = true
                        }
                        .foregroundColor(.accentColor) // Make it stand out
                    }
                }

                // MARK: - Features Section
                Section(header: Text("Features")) {
                    featureRow(title: "Customize Insight Notifications", isPremiumFeature: true, action: {
                        // Navigate to notification settings or show coming soon
                        print("Customize Insight Notifications tapped")
                    })
                    
                    featureRow(title: "Exclusive App Icons", isPremiumFeature: true, action: {
                        // Navigate to app icon selection or show coming soon
                        print("Exclusive App Icons tapped")
                    })

                    featureRow(title: "Advanced Data Export (JSON, CSV)", isPremiumFeature: true, action: {
                        // Navigate to data export or show coming soon
                        print("Advanced Data Export tapped")
                    })
                }
                
                // MARK: - General Section
                Section(header: Text("General")) {
                    Picker("Appearance", selection: $appearanceSelection) {
                        Text("System").tag(0)
                        Text("Light").tag(1)
                        Text("Dark").tag(2)
                    }
                    .onChange(of: appearanceSelection) { newValue in
                        // Apply theme change logic here
                        print("Appearance changed to: \(newValue)")
                    }

                    Link("Help Center", destination: URL(string: "https://www.example.com/help")!)
                    Button("Send Feedback") {
                        // Open mail composer
                        // guard let url = URL(string: "mailto:support@example.com?subject=HorizonFrame%20Feedback") else { return }
                        // UIApplication.shared.open(url)
                        print("Send Feedback tapped")
                    }
                    Link("Rate HorizonFrame", destination: URL(string: "itms-apps://itunes.apple.com/app/YOUR_APP_ID")!) // Replace YOUR_APP_ID
                }
                
                // MARK: - Legal Section
                Section(header: Text("Legal")) {
                    Link("Privacy Policy", destination: URL(string: "https://www.example.com/privacy")!)
                    Link("Terms of Service", destination: URL(string: "https://www.example.com/terms")!)
                }
                
                // MARK: - Developer Section
                Section(header: Text("Developer")) {
                    Button("Rerun Onboarding") {
                        hasCompletedOnboarding = false
                        appState.showOnboarding = true
                    }
                }
                
                // MARK: - App Info Section
                Section {
                    HStack {
                        Text("App Version")
                        Spacer()
                        Text(appVersion())
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        if storeManager.isPremium {
                            showPremiumStatusSheet = true
                        } else {
                            showSubscriptionSheet = true
                        }
                    } label: {
                        Image(systemName: storeManager.isPremium ? "crown.fill" : "crown")
                            .foregroundColor(storeManager.isPremium ? .yellow : .white)
                    }
                }
            }
            .sheet(isPresented: $showSubscriptionSheet) {
                SubscriptionOptionsView()
            }
            .sheet(isPresented: $showReferralSheet) {
                ReferralView() // Assuming ReferralView handles its own code logic
            }
            .alert("Premium Feature", isPresented: $showPremiumFeatureLockedAlert, actions: {
                Button("Upgrade Now") { showSubscriptionSheet = true }
                Button("Maybe Later", role: .cancel) { }
            }, message: {
                Text("\(lockedFeatureName) is a premium feature. Upgrade to unlock its full potential!")
            })
            .sheet(isPresented: $showPremiumStatusSheet) {
                PremiumStatusView()
            }
        }
        .accentColor(.blue) // Or your app's primary color
        // .preferredColorScheme(.dark) // Removed to allow system/picker preference
    }

    // Helper function to create rows for features, handling premium logic
    @ViewBuilder
    private func featureRow(title: String, isPremiumFeature: Bool, action: @escaping () -> Void) -> some View {
        Button(action: {
            if isPremiumFeature && !storeManager.isPremium {
                lockedFeatureName = title
                showPremiumFeatureLockedAlert = true
            } else {
                action()
            }
        }) {
            HStack {
                Text(title)
                Spacer()
                if isPremiumFeature {
                    Image(systemName: storeManager.isPremium ? "lock.open.fill" : "lock.fill")
                        .foregroundColor(storeManager.isPremium ? .green : .orange)
                }
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .foregroundColor(.primary) // Ensure text color is appropriate for light/dark mode
    }
    
    // Helper to get app version
    private func appVersion() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "N/A"
    }
}

// Preview (optional, ensure StoreManager is provided if used)
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(StoreManager()) // Example StoreManager
            // .environmentObject(ReferralViewModel()) // If you create one for actual referral code
            .preferredColorScheme(.dark)
    }
}
