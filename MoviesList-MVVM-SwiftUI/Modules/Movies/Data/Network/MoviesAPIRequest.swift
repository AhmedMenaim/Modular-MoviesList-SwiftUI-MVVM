//
//  MoviesAPIRequest.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 04/08/2024.
//

import Foundation

enum MoviesAPIRequest: APIRequestConfiguration {
  case getMovies
  case getSearchedMovies(searchText: String)

  var method: HTTPMethod {
    switch self {
      case .getMovies:
        return .GET
      case .getSearchedMovies:
        return .GET
    }
  }

  var path: String {
    switch self {
        /// We can save the APIKey in keychain
        /// Also create a common BaseURL and paths for each one.
      case .getMovies:
        return "\(Constants.Network.baseURL)trending/movie/week?\(Constants.Network.APIKey)"
      case.getSearchedMovies(let searchText):
        return "\(Constants.Network.baseURL)search/movie?query=\(searchText)&\(Constants.Network.APIKey)"
    }
  }

  var parameters: Parameters? {
    nil
  }

  var headers: HTTPHeaders? {
    nil
  }

  var queryParams: [String : Any]? {
    nil
  }

  var files: [UploadMediaFile]? {
    nil
  }
}
