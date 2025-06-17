import Foundation

class ReferralCodeManager {
    static let shared = ReferralCodeManager()
    private let userDefaultsKey = "userReferralCode"

    private init() {}

    func getReferralCode() -> String {
        if let existingCode = UserDefaults.standard.string(forKey: userDefaultsKey) {
            return existingCode
        } else {
            let newCode = generateRandomCode(length: 6)
            UserDefaults.standard.set(newCode, forKey: userDefaultsKey)
            return newCode
        }
    }

    private func generateRandomCode(length: Int) -> String {
        let characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
        var randomCode = ""
        for _ in 0..<length {
            let randomIndex = Int.random(in: 0..<characters.count)
            let character = characters[characters.index(characters.startIndex, offsetBy: randomIndex)]
            randomCode.append(character)
        }
        return randomCode
    }
    // Optional: A way to reset for testing, if needed in the future
    // func resetReferralCode() {
    //     UserDefaults.standard.removeObject(forKey: userDefaultsKey)
    // }
}
