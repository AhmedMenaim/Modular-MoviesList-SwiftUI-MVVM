//
//  MovieDetailsAPIRequest.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 05/08/2024.
//

import Foundation

enum MovieDetailsAPIRequest: APIRequestConfiguration {
  case getMovieDetails(id: String)

  var method: HTTPMethod {
    switch self {
      case .getMovieDetails:
        return .GET
    }
  }

  var path: String {
    switch self {
      case .getMovieDetails(let id):
        return "\(Constants.Network.baseURL)movie/\(id)?\(Constants.Network.APIKey)"
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
