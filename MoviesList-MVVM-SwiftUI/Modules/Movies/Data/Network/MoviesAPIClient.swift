//
//  MoviesAPIClient.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 04/08/2024.
//

import Foundation
import Combine

protocol MoviesAPIClientProtocol {
  func getMovies(for currentPage: Int) -> AnyPublisher<MoviesNetworkResponse, SessionDataTaskError>
  func getSearchedMovies(
    with searchedText: String,
    and searchPage: Int
  ) -> AnyPublisher<MoviesNetworkResponse, SessionDataTaskError>
}

class MoviesAPIClient {
  private var client: BaseAPIClientProtocol
  init(client: BaseAPIClientProtocol) {
    self.client = client
  }
}

// MARK: - MoviesAPIClientProtocol
extension MoviesAPIClient: MoviesAPIClientProtocol {
  func getMovies(for currentPage: Int) -> AnyPublisher<MoviesNetworkResponse, SessionDataTaskError> {
    let request = MoviesAPIRequest.getMovies(currentPage: currentPage)
    return client.perform(request.asURLRequest())
  }

  func getSearchedMovies(
    with searchedText: String,
    and searchPage: Int
  ) -> AnyPublisher<MoviesNetworkResponse, SessionDataTaskError> {
    let request = MoviesAPIRequest.getSearchedMovies(
      searchText: searchedText,
      searchPage: searchPage
    )
    return client.perform(request.asURLRequest())
  }
}
