import SwiftUI

struct ReferralView: View {
    @Environment(\.dismiss) var dismiss
    @State private var referralCode: String = ReferralCodeManager.shared.getReferralCode()
    @State private var enteredCode: String = ""
    @State private var showShareSheet = false
    @State private var showToast = false
    @State private var toastMessage = ""

    let shareText: String

    init() {
        self.shareText = "Join HorizonFrame Premium with my referral code \(ReferralCodeManager.shared.getReferralCode()) and we both get a free month! 🌟"
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            AnimatedGradientBackground().edgesIgnoringSafeArea(.all)

            VStack(spacing: 24) {
                // Header
                VStack(spacing: 8) {
                    Text("Share the Clarity")
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    Text("Give a friend one month of Premium, and get one month for yourself.")
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, 24)
                .padding(.top, 60)

                Spacer()

                // Your Code Section
                VStack(spacing: 16) {
                    Text("YOUR CODE")
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundColor(.white.opacity(0.7))
                        .kerning(1.5)

                    HStack {
                        Text(referralCode)
                            .font(.system(size: 28, weight: .bold, design: .monospaced))
                            .foregroundColor(.white)
                        
                        Button(action: {
                            UIPasteboard.general.string = referralCode
                            toastMessage = "Copied to clipboard!"
                            showToast = true
                        }) {
                            Image(systemName: "doc.on.doc.fill")
                                .foregroundColor(.white.opacity(0.8))
                        }
                    }

                    Button(action: { showShareSheet = true }) {
                        Text("Share Your Code")
                            .font(.system(size: 17, weight: .bold, design: .rounded))
                            .foregroundColor(.black)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(16)
                    }
                }
                .padding(24)
                .background(Color.white.opacity(0.1))
                .cornerRadius(20)
                .padding(.horizontal, 24)

                Spacer()

                // Redeem Code Section
                VStack(spacing: 12) {
                    Text("HAVE A CODE?")
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundColor(.white.opacity(0.7))
                        .kerning(1.5)

                    HStack {
                        TextField("Enter code", text: $enteredCode)
                            .font(.system(size: 17, weight: .semibold, design: .rounded))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(12)
                            .autocapitalization(.allCharacters)
                            .disableAutocorrection(true)
                        
                        Button(action: {
                            // Redeem logic
                            if ReferralManager.shared.applyReferralCode(enteredCode) {
                                toastMessage = "Code applied successfully!"
                            } else {
                                toastMessage = "Invalid referral code."
                            }
                            showToast = true
                            enteredCode = ""
                        }) {
                            Text("Redeem")
                                .font(.system(size: 17, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(12)
                        }
                        .disabled(enteredCode.isEmpty)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 30)
            }
            .padding(.vertical)

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
        .sheet(isPresented: $showShareSheet) {
            ShareSheet(items: [shareText])
        }
        .overlay(
            ToastView(message: toastMessage, isShowing: $showToast)
                .animation(.spring(), value: showToast)
        )
    }
}

// A simple toast view for feedback
struct ToastView: View {
    let message: String
    @Binding var isShowing: Bool

    var body: some View {
        VStack {
            Spacer()
            if isShowing {
                Text(message)
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(12)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                isShowing = false
                            }
                        }
                    }
            }
        }
        .padding(.bottom, 50)
    }
}

struct ReferralView_Previews: PreviewProvider {
    static var previews: some View {
        ReferralView()
    }
}
