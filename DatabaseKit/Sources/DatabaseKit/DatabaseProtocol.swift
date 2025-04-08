//
//  DatabaseProtocol.swift
//  
//
//  Created by Menaim on 06/08/2024.
//

import Foundation

public protocol DatabaseProtocol {
  /// T → To be able to use generics
  associatedtype T
  /// Defining a unique way to identify each object stored in the database.
  /// - Note: `Hashable`→ Allowing Use in Generic Functions → Without Hashable, Swift cannot guarantee unique comparisons.
  associatedtype Identifier: Hashable
  func save(_ value: T)
  func save(_ objects: [T])
  func getAll() -> [T]
  func get(by id: Identifier) -> T?
  func delete(_ object: T)
  func delete(by id: Identifier)
  func delete(_ objects: [T])
  func clear()

}
