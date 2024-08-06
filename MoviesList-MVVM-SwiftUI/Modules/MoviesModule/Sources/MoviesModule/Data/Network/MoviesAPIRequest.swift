//
//  MoviesAPIRequest.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 04/08/2024.
//

import MANetwork
import Commons

enum MoviesAPIRequest: APIRequestConfiguration {
  case getMovies(currentPage: Int)
  case getSearchedMovies(searchText: String, searchPage: Int)

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
      case .getMovies(let currentPage):
        return "\(Constants.Network.baseURL)discover/movie?include_adult=false&sort_by=popularity.desc&page=\(currentPage)&\(Constants.Network.APIKey)"
      case.getSearchedMovies(let searchText, let searchPage):
        return "\(Constants.Network.baseURL)search/movie?query=\(searchText)&page=\(searchPage)&\(Constants.Network.APIKey)"
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
