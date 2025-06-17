import SwiftUI
import StoreKit

/// A simple placeholder sheet that lists premium subscription options.
/// Replace the static values with StoreKit configuration when ready.
struct SubscriptionOptionsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var storeManager: StoreManager
    @State private var isLoading = false
    @State private var error: Error? = nil
    @State private var testCode: String = ""

    var body: some View {
        ZStack(alignment: .topTrailing) {
            // Background Gradient
            AnimatedGradientBackground().edgesIgnoringSafeArea(.all)

            VStack(spacing: 0) {
                // Header
                VStack(spacing: 16) {
                    Text("Unlock HorizonFrame")
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Text("Join Premium to access all features and accelerate your personal growth.")
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                }
                .padding(.top, 60)
                .padding(.bottom, 30)

                // Feature List
                VStack(alignment: .leading, spacing: 20) {
                    BenefitView(icon: "sparkles", title: "Unlimited Alignments", description: "Create and follow an infinite number of personal codes.")
                    BenefitView(icon: "icloud.and.arrow.up.fill", title: "Cloud Sync & Backup", description: "Securely save your progress across all your devices.")
                    BenefitView(icon: "chart.pie.fill", title: "Advanced Analytics", description: "Get deeper insights into your journey with detailed stats.")
                    BenefitView(icon: "paintbrush.fill", title: "Exclusive Themes", description: "Customize the look and feel of your app.")
                }
                .padding(.horizontal, 30)

                Spacer()

                // Plan Selection & CTA
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.5)
                        .padding(.vertical, 50)
                } else if let error = error {
                    Text("Failed to load products: \(error.localizedDescription)")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    VStack(spacing: 16) {
                        if let annualProduct = storeManager.products.first(where: { $0.id == ProductIdentifiers.yearly }) {
                            PlanButton(title: annualProduct.displayName, price: annualProduct.displayPrice, subtitle: "Best Value - Save 50%", isRecommended: true) { 
                                purchase(product: annualProduct)
                            }
                        }
                        if let monthlyProduct = storeManager.products.first(where: { $0.id == ProductIdentifiers.monthly }) {
                            PlanButton(title: monthlyProduct.displayName, price: monthlyProduct.displayPrice, subtitle: nil, isRecommended: false) { 
                                purchase(product: monthlyProduct)
                            }
                        }
                        
                        Button(action: {
                            Task {
                                try? await storeManager.updatePurchasedProducts()
                            }
                        }) {
                            Text("Restore Purchases")
                                .font(.system(size: 15, weight: .medium, design: .rounded))
                                .foregroundColor(.white.opacity(0.7))
                        }
                        .padding(.top, 8)

                        // Test Code Section
                        VStack(spacing: 8) {
                            TextField("Enter Test Code", text: $testCode)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal, 40) // Align with buttons
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                            
                            Button(action: {
                                if !testCode.isEmpty {
                                    storeManager.unlockPremiumWithTestCode()
                                    testCode = "" // Clear after use
                                    dismiss() // Optionally dismiss after unlocking
                                }
                            }) {
                                Text("Unlock with Test Code")
                                    .font(.system(size: 15, weight: .medium, design: .rounded))
                                    .foregroundColor(.white.opacity(0.85))
                                    .padding(.vertical, 8)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.white.opacity(0.15))
                                    .cornerRadius(10)
                            }
                            .padding(.horizontal, 40) // Align with buttons
                        }
                        .padding(.top, 15)

                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 30)
                }
            }

            // Close Button
            Button(action: { dismiss() }) {
                Image(systemName: "xmark")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white.opacity(0.7))
                    .padding(12)
                    .background(Color.white.opacity(0.1))
                    .clipShape(Circle())
            }
            .padding()
        }
        .task {
            await loadProducts()
        }
    }

    private func loadProducts() async {
        isLoading = true
        do {
            try await storeManager.loadProducts()
        } catch {
            self.error = error
        }
        isLoading = false
    }

    private func purchase(product: Product) {
        Task {
            do {
                try await storeManager.purchase(product)
                dismiss()
            } catch {
                self.error = error
            }
        }
    }
}

// MARK: - Subviews

private struct BenefitView: View {
    let icon: String
    let title: String
    let description: String

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 35)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 17, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                Text(description)
                    .font(.system(size: 15, weight: .regular, design: .rounded))
                    .foregroundColor(.white.opacity(0.7))
            }
        }
    }
}

private struct PlanButton: View {
    let title: String
    let price: String
    let subtitle: String?
    let isRecommended: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.system(size: 17, weight: .bold, design: .rounded))
                    if let subtitle = subtitle {
                        Text(subtitle)
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                    }
                }
                Spacer()
                Text(price)
                    .font(.system(size: 17, weight: .semibold, design: .rounded))
            }
            .foregroundColor(isRecommended ? .black : .white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                Group {
                    if isRecommended {
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(Color.white)
                    } else {
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(Color.white.opacity(0.5), lineWidth: 2)
                    }
                }
            )
        }
    }
}

struct SubscriptionOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionOptionsView()
            .preferredColorScheme(.dark)
    }
}
