// Services/FirestorePassageRepository.swift
import Foundation
import Combine

final class FirestorePassageRepository {
    static let shared = FirestorePassageRepository()
    private init() {}

    // MARK: – Public publishers

    func recentPassages(limit: Int = 25) -> AnyPublisher<[Passage], Error> {
        // FBEnv.db.collection("passages")
        //     .order(by: "createdAt", descending: true)
        //     .limit(to: limit)
        //     .publisher(as: Passage.self)   // see Extensions.swift for helper
        return Just([]).setFailureType(to: Error.self).eraseToAnyPublisher() // Return empty publisher
    }

    func add(_ passage: Passage) async throws {
        // var doc = passage
        // doc.createdAt = Date()
        // try FBEnv.db.collection("passages").addDocument(from: doc)
        // No operation
    }

    // etc…
}