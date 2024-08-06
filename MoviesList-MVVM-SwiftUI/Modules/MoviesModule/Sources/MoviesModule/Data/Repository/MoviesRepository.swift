//
//  MoviesRepository.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 05/08/2024.
//

import Foundation
import Combine
import MANetwork
import Commons

final
class MoviesRepository {
  // MARK: - Vars
  private var cancellable: Set<AnyCancellable> = []
  private var client: MoviesAPIClientProtocol

  init(client: MoviesAPIClientProtocol) {
    self.client = client
  }

  // MARK: - Privates
  private
  func convert(_ response: [MovieNetworkResponse]?) -> [MovieRepositoryModel]? {
    guard
      let movies = response
    else {
      return nil
    }
    return movies.map { movie in
      MovieRepositoryModel(
        posterPath: "\(Constants.Network.imageBaseURL)\(movie.posterPath ?? "")",
        title: movie.title,
        releaseDate: movie.releaseDate?.toDate(),
        genreIDs: movie.genreIDS,
        id: movie.id,
        voteAverage: movie.voteAverage,
        voteCount: movie.voteCount,
        overview: movie.overview
      )
    }
  }

  private
  func convert(_ response: MoviesNetworkResponse?) -> MoviesRepositoryModel {
    MoviesRepositoryModel(
      page: response?.page,
      movies: convert(response?.movies),
      totalPages: response?.totalPages
    )
  }
}

extension MoviesRepository: MoviesRepositoryProtocol {
  func getMovies(for currentPage: Int) -> AnyPublisher<MoviesRepositoryModel?, RepositoryError> {
    return Future { [weak self] promise in
      guard let self else { return }
      client.getMovies(for: currentPage)
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

  func getSearchedMovies(
    with searchedText: String,
    and searchPage: Int
  ) -> AnyPublisher<MoviesRepositoryModel?, RepositoryError> {
    return Future { [weak self] promise in
      guard let self else { return }
      client.getSearchedMovies(with: searchedText, and: searchPage)
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
