import Foundation

class ReferralManager {
    static let shared = ReferralManager()
    private let referralCodeKey = "userReferralCode"

    private init() {}

    func getUserReferralCode() -> String {
        if let existingCode = UserDefaults.standard.string(forKey: referralCodeKey) {
            return existingCode
        } else {
            let newCode = generateReferralCode()
            UserDefaults.standard.set(newCode, forKey: referralCodeKey)
            return newCode
        }
    }

    private func generateReferralCode(length: Int = 6) -> String {
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }

    // Placeholder for applying a referral code
    func applyReferralCode(_ code: String) -> Bool {
        // In a real app, this would validate the code against a backend
        // and grant the reward. For now, we'll just check if it's a valid format.
        return code.count == 6 && code.allSatisfy { $0.isLetter || $0.isNumber }
    }
}
