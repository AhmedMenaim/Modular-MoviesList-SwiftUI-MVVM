//
//  BaseAPIClient.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 04/08/2024.
//

import Foundation
import Combine

protocol BaseAPIClientProtocol {
    func perform<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, SessionDataTaskError>
}

struct BaseAPIClient: BaseAPIClientProtocol {
  private let session = URLSession.shared
  func perform<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, SessionDataTaskError> {
    if let url = request.url {
      print("[\(request.httpMethod?.uppercased() ?? "")] '\(url)'")
    } else {
      print("❌ ERROR WHILE RETRIEVING REQUEST URL ❌")
    }
    return session.dataTaskPublisher(for: request)
      .tryMap { result in
        guard let httpResponse = result.response as? HTTPURLResponse else {
          throw SessionDataTaskError.requestFailed
        }
        let statusCode = httpResponse.statusCode
        switch statusCode {
          case 200..<300:
            if let url = request.url {

              print("[\(request.httpMethod?.uppercased() ?? "")] '\(url)'")
            } else {
              print("❌ ERROR WHILE RETRIEVING REQUEST URL ❌")
              throw SessionDataTaskError.notValidURL
            }
            return result.data
            /// 1020 means dataNotAllowed -> Internet is closed
            /// 1009 Internet is opened but no connection happens
          case 1009, 1020:
            throw SessionDataTaskError.noInternetConnection
          case 404:
            throw SessionDataTaskError.notFound
          case 400, 401:
            throw SessionDataTaskError.notAuthorized
          case 500 ... 599:
            throw SessionDataTaskError.server
          default:
            if let error = try? JSONDecoder().decode(SessionDataTaskErrorResponse.self, from: result.data) {
              throw SessionDataTaskError.internalError(error)
            } else {
              throw SessionDataTaskError.emptyErrorWithStatusCode(httpResponse.statusCode.description)
            }
        }
      }
      .receive(on: DispatchQueue.main)
      .decode(type: T.self, decoder: JSONDecoder())
      .mapError { error -> SessionDataTaskError in
        if let error = error as? SessionDataTaskError {
          return error
        }
        return SessionDataTaskError.failWithError(error)
      }
      .eraseToAnyPublisher()
  }
}
