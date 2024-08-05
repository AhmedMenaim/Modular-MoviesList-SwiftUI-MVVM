//
//  MovieDetailsAPIClient.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 05/08/2024.
//

import Foundation
import Combine

protocol MovieDetailsAPIClientProtocol {
  func getMovieDetails(with movieID: String) -> AnyPublisher<MovieDetailsNetworkResponse, SessionDataTaskError>
}

class MovieDetailsAPIClient {
  private var client: BaseAPIClientProtocol
  init(client: BaseAPIClientProtocol) {
    self.client = client
  }
}

// MARK: - MovieDetailsAPIClientProtocol
extension MovieDetailsAPIClient: MovieDetailsAPIClientProtocol {
  func getMovieDetails(with movieID: String) -> AnyPublisher<MovieDetailsNetworkResponse, SessionDataTaskError> {
    let request = MovieDetailsAPIRequest.getMovieDetails(id: movieID)
    return client.perform(request.asURLRequest())
  }

}
