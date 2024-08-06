//
//  GenreRepository.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 05/08/2024.
//

import Combine
import MANetwork

public
final class GenreRepository {
  // MARK: - Vars
  private var cancellable: Set<AnyCancellable> = []
  private var client: GenreAPIClientProtocol

  public
  init(client: GenreAPIClientProtocol) {
    self.client = client
  }

  // MARK: - Privates
  private
  func convert(_ response: GenreNetworkResponse?) -> [GenreRepositoryModel]? {
    response?.genres?.compactMap({ genre in
      GenreRepositoryModel(
        id: genre.id,
        name: genre.name
      )
    })
  }
}

// MARK: - GenreRepositoryProtocol
extension  GenreRepository: GenreRepositoryProtocol {
  public 
  func getGenre() -> AnyPublisher<[GenreRepositoryModel]?, RepositoryError> {
    return Future { [weak self] promise in
      guard let self else { return }
      client.getGenre()
        .sink(receiveCompletion: { result in
          if case .failure(let error) = result {
            promise(.failure(
              RepositoryError(error: error)
            ))
          }
        }, receiveValue: { [weak self] response in
          guard let self else { return }
          promise(.success(
            self.convert(response)
          ))
        })
        .store(in: &cancellable)
      }
    .eraseToAnyPublisher()
  }
}
