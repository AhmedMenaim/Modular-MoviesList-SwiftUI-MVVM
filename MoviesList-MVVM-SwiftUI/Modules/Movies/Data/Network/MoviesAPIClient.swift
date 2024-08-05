//
//  MoviesAPIClient.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 04/08/2024.
//

import Foundation
import Combine

protocol MoviesAPIClientProtocol {
  func getMovies() -> AnyPublisher<MoviesNetworkResponse, SessionDataTaskError>
  func getSearchedMovies(with searchedText: String) -> AnyPublisher<MoviesNetworkResponse, SessionDataTaskError>
}

class MoviesAPIClient {
  private var client: BaseAPIClientProtocol
  init(client: BaseAPIClientProtocol) {
    self.client = client
  }
}

// MARK: - MoviesAPIClientProtocol
extension MoviesAPIClient: MoviesAPIClientProtocol {
  func getMovies() -> AnyPublisher<MoviesNetworkResponse, SessionDataTaskError> {
    let request = MoviesAPIRequest.getMovies
    return client.perform(request.asURLRequest())
  }

  func getSearchedMovies(with searchedText: String) -> AnyPublisher<MoviesNetworkResponse, SessionDataTaskError> {
    let request = MoviesAPIRequest.getSearchedMovies(searchText: searchedText)
    return client.perform(request.asURLRequest())
  }
}
