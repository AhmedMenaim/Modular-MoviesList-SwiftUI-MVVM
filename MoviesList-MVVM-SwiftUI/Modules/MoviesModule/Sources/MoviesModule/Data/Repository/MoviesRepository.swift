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
import DatabaseKit

final
class MoviesRepository<Cache: DatabaseProtocol> where Cache.T == MovieEntity {
  // MARK: - Vars
  private var cancellable: Set<AnyCancellable> = []
  private var client: MoviesAPIClientProtocol
  private let cacheManager: Cache

  init(
    client: MoviesAPIClientProtocol,
    cacheManager: Cache
  ) {
    self.client = client
    self.cacheManager = cacheManager
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

  private func convert(_ entity: MovieEntity) -> MovieRepositoryModel {
    return MovieRepositoryModel(
      posterPath: entity.posterPath,
      title: entity.title,
      releaseDate: entity.releaseDate,
      genreIDs: Array(entity.genreIDs),
      id: Int(entity.id),
      voteAverage: entity.voteAverage,
      voteCount: entity.voteCount,
      overview: entity.overview
    )
  }

  private func convert(_ movie: MovieRepositoryModel) -> MovieEntity {
    let entity = MovieEntity()
    entity.id = "\(movie.id ?? 0)"
    entity.posterPath = movie.posterPath ?? "--"
    entity.title = movie.title ?? "--"
    entity.genreIDs.append(objectsIn: movie.genreIDs ?? [])
    entity.releaseDate = movie.releaseDate ?? Date()
    entity.overview = movie.overview ?? "--"
    entity.voteAverage = movie.voteAverage ?? 0
    entity.voteCount = movie.voteCount ?? 0
    return entity
  }
}

extension MoviesRepository: MoviesRepositoryProtocol {
  func getMovies(for currentPage: Int) -> AnyPublisher<MoviesRepositoryModel?, RepositoryError> {
    return Future { [weak self] promise in
      guard let self = self else { return }

      client.getMovies(for: currentPage)
        .sink(receiveCompletion: { result in
          if case .failure(let error) = result {
            if RepositoryError(error: error) == RepositoryError.noInternetConnection {
              let cachedMovies = self.cacheManager.getAll()
              if !cachedMovies.isEmpty {
                let repositoryModels = cachedMovies.map { self.convert($0) }
                let repositoryModel = MoviesRepositoryModel(
                  page: currentPage,
                  movies: repositoryModels,
                  totalPages: 1
                )
                promise(.success(repositoryModel))
              }
            } else {
              promise(.failure(RepositoryError(error: error)))
            }
          }
        }, receiveValue: { [weak self] response in
          guard let self = self else { return }
          let repositoryModel = self.convert(response)
          if let movies = repositoryModel.movies {
            let entities = movies.map { self.convert($0) }
            self.cacheManager.save(entities)
          }
          promise(.success(repositoryModel))
        })
        .store(in: &self.cancellable)
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
