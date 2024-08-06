//
//  GenreLookupAPIRequest.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 05/08/2024.
//

import Combine
import MANetwork

enum GenreAPIRequest: APIRequestConfiguration {
  case getGenre

  var method: HTTPMethod {
    switch self {
      case .getGenre:
        return .GET
    }
  }

  var path: String {
    switch self {
      case .getGenre:
        return "\(Constants.Network.baseURL)\(Constants.Network.genrePath)?\(Constants.Network.APIKey)"
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
