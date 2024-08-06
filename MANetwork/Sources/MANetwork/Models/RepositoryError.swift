//
//  RepositoryError.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 04/08/2024.
//

import Foundation

public
enum RepositoryError: Error {
  case noInternetConnection
  case notFound
  case notAuthorized
  case server
  case noData
  case unowned

  public
  init(error: SessionDataTaskError) {
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
