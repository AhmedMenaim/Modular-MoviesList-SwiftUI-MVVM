//
//  DatabaseProtocol.swift
//
//
//  Created by Menaim on 06/08/2024.
//

import RealmSwift
import Foundation

public
final class RealmDatabaseManager<T: Codable & Identifiable> {
  public typealias Identifier = T.ID
  private var realm: Realm?

  public
  init() {
    configureRealm()
  }

  // MARK: - Privates
  private func configureRealm() {
    let config = Realm.Configuration(objectTypes: [
      RealmObjectWrapper<MovieEntity>.self
    ])
    do {
      self.realm = try Realm(configuration: config)
    } catch {
      fatalError("Failed to initialize Realm: \(error)")
    }
  }

  /// Always return a fresh Realm instance for thread safety
  private func getRealm() -> Realm? {
      return try? Realm()
  }
}

// MARK: - DatabaseProtocol - Writing/Saving
extension RealmDatabaseManager: DatabaseProtocol {

  /// Saving a single object to the database
  /// - Parameter object: The used generic object to be saved
  public func save(_ object: T) {
    /// Making sure to create a new instance before writing in database
    /// To make sure of thread safety
    guard let realm = getRealm() else { return }
    do {
      /// Converting the generic object into realm object to be able to get saved
      let realmObject = RealmObjectWrapper(object: object)
      /// Writing on database
      try realm.write {
        realm.add(realmObject, update: .modified)
      }
    } catch {
      print("Failed to save object: \(error)")
    }
  }

  /// Saving multiple objects in one time to the database
  /// - Parameter objects: Array of generic objects to be saved
  public func save(_ objects: [T]) {
    /// If a large batch, write in the background
    if objects.count > 50 {
      DispatchQueue.global(qos: .background).async { [weak self] in
        guard let self,
              let realm = getRealm()
        else { return }
        do {
          /// Writing on database
          try realm.write {
            /// Mapping to the Realm object to be able to be saved into the database
            let realmObjects = objects.map { RealmObjectWrapper(object: $0) }
            /** From Realm Documentation `.modified`
             Overwrite only properties in the existing object which are different from the new values. This results
             in change notifications reporting only the properties which changed, and influences the sync merge logic.

             If few or no of the properties are changing this will be faster than .all and reduce how much data has
             to be written to the Realm file. If all of the properties are changing, it may be slower than .all (but
             will never result in *more* data being written).
             */
            realm.add(realmObjects, update: .modified)
          }
        } catch {
          print("Failed to save objects: \(error)")
        }
      }
    } else {
      /// Small batch, write immediately
      guard let realm = self.getRealm() else { return }
      do {
        /// Writing on database
        try realm.write {
          /// Mapping to the Realm object to be able to be saved into the database
          let realmObjects = objects.map { RealmObjectWrapper(object: $0) }
          realm.add(realmObjects, update: .modified)
        }
      } catch {
        print("Failed to save objects: \(error)")
      }
    }
  }
}

// MARK: - DatabaseProtocol - Reading
extension RealmDatabaseManager {
  /// Retrieve all objects from Realm
  public func getAll() -> [T] {
    if let results = realm?.objects(RealmObjectWrapper<T>.self) {
      let mappedResults = results.compactMap { $0.decodedObject }
      return Array(mappedResults) // Ensures proper conversion
    }
    return []
  }

  /// Retrieve a specific object by ID
  public func get(by id: Identifier) -> T? {
    return realm?.object(ofType: RealmObjectWrapper<T>.self, forPrimaryKey: id)?.decodedObject
  }
}

// MARK: - DatabaseProtocol - Clearing/Deleting
extension RealmDatabaseManager {
  /// Delete an object from Realm
  public func delete(_ object: T) {
    guard let realmObject = realm?.object(ofType: RealmObjectWrapper<T>.self, forPrimaryKey: object.id) else { return }
    do {
      try realm?.write {
        realm?.delete(realmObject)
      }
    } catch {
      print("Failed to delete object: \(error)")
    }
  }

  /// Delete an object by ID
  public func delete(by id: Identifier) {
    guard let realmObject = realm?.object(ofType: RealmObjectWrapper<T>.self, forPrimaryKey: id) else { return }
    do {
      try realm?.write {
        realm?.delete(realmObject)
      }
    } catch {
      print("Failed to delete object: \(error)")
    }
  }

  /// Delete multiple objects from Realm (Optimized for performance)
  public func delete(_ objects: [T]) {
    if objects.count > 50 { // If deleting many items, move to a background thread
      DispatchQueue.global(qos: .background).async {
        guard let realm = self.getRealm() else { return }
        do {
          try realm.write {
            let realmObjects = objects.compactMap {
              realm.object(ofType: RealmObjectWrapper<T>.self, forPrimaryKey: $0.id)
            }
            realm.delete(realmObjects)
          }
        } catch {
          print("Failed to delete objects: \(error)")
        }
      }
    } else { // If a small batch, delete immediately
      guard let realm = getRealm() else { return }
      do {
        try realm.write {
          let realmObjects = objects.compactMap {
            realm.object(ofType: RealmObjectWrapper<T>.self, forPrimaryKey: $0.id)
          }
          realm.delete(realmObjects)
        }
      } catch {
        print("Failed to delete objects: \(error)")
      }
    }
  }

  /// Clear all cached objects from Realm
  public func clear() {
    do {
      if let objects = realm?.objects(RealmObjectWrapper<T>.self) {
        try realm?.write {
          realm?.delete(objects)
        }
      }
    } catch {
      print("Failed to clear cache: \(error)")
    }
  }
}
