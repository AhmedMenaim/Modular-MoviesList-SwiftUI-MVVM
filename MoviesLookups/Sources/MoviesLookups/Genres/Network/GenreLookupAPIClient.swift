//
//  GenreLookupAPIClient.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 05/08/2024.
//

import MANetwork
import Combine

public
protocol GenreAPIClientProtocol {
  func getGenre() -> AnyPublisher<GenreNetworkResponse, SessionDataTaskError>
}

public
class GenreAPIClient {
  private var client: BaseAPIClientProtocol
  public
  init(client: BaseAPIClientProtocol) {
    self.client = client
  }
}

// MARK: - GenreAPIClientProtocol
extension GenreAPIClient: GenreAPIClientProtocol {
  public
  func getGenre() -> AnyPublisher<GenreNetworkResponse, SessionDataTaskError> {
    let request = GenreAPIRequest.getGenre
    return client.perform(request.asURLRequest())
  }
}

