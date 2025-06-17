import Foundation
import StoreKit

enum StoreError: Error {
    case failedVerification
}

// Define product identifiers
enum ProductIdentifiers {
    static let monthly = "com.yourapp.monthly"
    static let yearly = "com.yourapp.yearly"
}

@MainActor
class StoreManager: ObservableObject {
    @Published private(set) var products: [Product] = []
    @Published private(set) var purchasedProductIDs = Set<String>()

    var isPremium: Bool {
        !purchasedProductIDs.isEmpty
    }

    private var productsLoaded = false
    private var updates: Task<Void, Never>? = nil

    init() {
        updates = observeTransactionUpdates()
    }

    deinit {
        updates?.cancel()
    }

    func loadProducts() async throws {
        guard !productsLoaded else { return }
        let productIds = [ProductIdentifiers.monthly, ProductIdentifiers.yearly]
        self.products = try await Product.products(for: productIds)
        self.productsLoaded = true
    }

    func purchase(_ product: Product) async throws {
        let result = try await product.purchase()

        switch result {
        case .success(let verification):            
            let transaction = try checkVerified(verification)
            await updatePurchasedProducts()
            await transaction.finish()
        case .userCancelled, .pending:
            break
        @unknown default:
            break
        }
    }

    private func observeTransactionUpdates() -> Task<Void, Never> {
        Task(priority: .background) {
            for await verification in Transaction.updates {
                let transaction = try? self.checkVerified(verification)
                if transaction != nil {
                    await self.updatePurchasedProducts()
                }
            }
        }
    }

    private func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:            
            throw StoreError.failedVerification
        case .verified(let safe):
            return safe
        }
    }

    @MainActor
    func updatePurchasedProducts() async {
        var foundRealEntitlement = false
        for await result in Transaction.currentEntitlements {
            if let transaction = try? checkVerified(result) {
                // Check if it's one of our actual product IDs before inserting
                if [ProductIdentifiers.monthly, ProductIdentifiers.yearly].contains(transaction.productID) {
                    purchasedProductIDs.insert(transaction.productID)
                    foundRealEntitlement = true
                }
            } 
        }
        // If no real entitlements were found, clear any test/dummy IDs
        if !foundRealEntitlement {
            purchasedProductIDs.removeAll()
        }
    }

    @MainActor
    func unlockPremiumWithTestCode() {
        // Use a special, non-App Store product ID for testing
        let testProductID = "com.yourapp.testpremium"
        purchasedProductIDs.insert(testProductID)
        // Manually trigger an objectWillChange to ensure UI updates if needed, 
        // though @Published should handle it.
        objectWillChange.send()
    }
}
