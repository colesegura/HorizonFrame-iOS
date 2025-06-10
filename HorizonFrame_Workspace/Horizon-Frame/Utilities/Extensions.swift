// Utilities/Extensions.swift
import Foundation
// import FirebaseFirestore
// import FirebaseFirestoreSwift
import Combine

// extension Query {
//     /// A generic Combine wrapper converting FS query snapshots into Decodable arrays.
//     func publisher<T: Decodable>(as type: T.Type) -> AnyPublisher<[T], Error> {
//         Future { promise in
//             self.addSnapshotListener { snapshot, error in
//                 if let error = error {
//                     promise(.failure(error)); return
//                 }
//                 let models = snapshot?.documents.compactMap {
//                     try? $0.data(as: T.self)
//                 } ?? []
//                 promise(.success(models))
//             }
//         }
//         .eraseToAnyPublisher()
//     }
// }