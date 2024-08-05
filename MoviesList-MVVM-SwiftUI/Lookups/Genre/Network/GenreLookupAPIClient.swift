//
//  GenreLookupAPIClient.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 05/08/2024.
//

//import Foundation
import Combine

protocol GenreAPIClientProtocol {
  func getGenre() -> AnyPublisher<GenreNetworkResponse, SessionDataTaskError>
}

class GenreAPIClient {
  private var client: BaseAPIClientProtocol
  init(client: BaseAPIClientProtocol) {
    self.client = client
  }
}

// MARK: - GenreAPIClientProtocol
extension GenreAPIClient: GenreAPIClientProtocol {
  func getGenre() -> AnyPublisher<GenreNetworkResponse, SessionDataTaskError> {
    let request = GenreAPIRequest.getGenre
    return client.perform(request.asURLRequest())
  }
}

