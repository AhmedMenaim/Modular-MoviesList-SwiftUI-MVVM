//
//  RealmObjectWrapper.swift
//  DatabaseKit
//
//  Created by Menaim on 24/02/2025.
//

import RealmSwift
import Foundation

/// A generic wrapper for storing Codable objects in Realm
/// - Important: Realm doesn't support generics, So it can't store a generic object directly
/// - Note: The code bases is depending on structs like `MovieEntity` & `Object` from Realm can be used only with classes
final class RealmObjectWrapper<T: Codable>: Object {
  /// - Important: From Realm documentation
  /// If a class has at least one @Persisted property, all other properties will be
  ///  ignored by Realm. This means that they will not be persisted and will not
  ///  be usable in queries and other operations such as sorting and aggregates
  ///  which require a managed property.
    @Persisted(primaryKey: true) var id: String
    @Persisted var jsonData: Data

    var decodedObject: T? {
      /// Decodeing it back to its original type (decodedObject).
        return try? JSONDecoder().decode(T.self, from: jsonData)
    }

    convenience init(object: T) {
        self.init()
      /// Encodeing any `Codable` object into Data (jsonData field).
      if let objectID = (object as? (any Identifiable))?.id as? String,
           let encodedData = try? JSONEncoder().encode(object) {
            self.id = objectID
        /// Storeing Data instead of the generic object itself.
            self.jsonData = encodedData
        } else {
            fatalError("Failed to encode object")
        }
    }
}
