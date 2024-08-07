//
//  File.swift
//
//
//  Created by Menaim on 06/08/2024.
//

import RealmSwift

class RealmManager {
  static let shared = RealmManager()
  private var realm: Realm?

  private init() {
    do {
      realm = try Realm()
    } catch {
      print("Failed to initialize Realm: \(error.localizedDescription)")
    }
  }

  func getRealm() -> Realm? {
    return realm
  }
}
