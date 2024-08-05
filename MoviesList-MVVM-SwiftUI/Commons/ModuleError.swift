//
//  ModuleError.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 05/08/2024.
//

import Foundation

enum ModuleError: Error {
  case noInternetConnection
  case notFound
  case notAuthorized
  case server
  case noData
  case unowned

  init(error: RepositoryError) {
    switch error {
      case .noInternetConnection:
        self = .noInternetConnection
      case .server:
        self = .server
      case .notFound:
        self = .notFound
      case .notAuthorized:
        self = .notAuthorized
      default:
        self = .unowned
    }
  }
}
