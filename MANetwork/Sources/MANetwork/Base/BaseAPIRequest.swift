//
//  BaseAPIRequest.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 04/08/2024.
//

import Foundation

public
enum BaseAPIRequest: APIRequestConfiguration {
  // MARK: - HTTPMethod
  public
  var method: HTTPMethod {
    switch self {
      default:
        return .GET
    }
  }

  // MARK: - Path
  public 
  var path: String {
    return ""
  }

  // MARK: - Parameters
  public 
  var parameters: Parameters? {
    return [:]
  }

  // MARK: - Headers
  public
  var headers: HTTPHeaders? {
    return nil
  }

  public 
  var queryParams: [String : Any]? {
    return nil
  }

  public 
  var files: [UploadMediaFile]? {
    return nil
  }
}
