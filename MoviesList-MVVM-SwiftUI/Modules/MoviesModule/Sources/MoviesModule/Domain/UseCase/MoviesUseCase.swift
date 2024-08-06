//
//  MoviesUseCase.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 05/08/2024.
//

import Foundation
import MoviesLookups
import Combine
import Commons

final class MoviesUseCase {
  // MARK: - Private Vars
  private var cancellable: Set<AnyCancellable> = []

  // MARK: - Dependencies
  private var moviesRepository: MoviesRepositoryProtocol
  private var genresRepository: GenreRepositoryProtocol

  init(
    moviesRepository: MoviesRepositoryProtocol,
    genresRepository: GenreRepositoryProtocol
  ) {
    self.moviesRepository = moviesRepository
    self.genresRepository = genresRepository
  }


  // MARK: - Privates
  private func convert(_ repositoryItem: [MovieRepositoryModel]?) -> [MovieItem] {
    guard
      let movies = repositoryItem
    else { return [] }
    return movies.compactMap({ movie in
        MovieItem(
          posterPath: movie.posterPath ?? "",
          title: movie.title ?? "",
          releaseDate: movie.releaseDate ?? Date(),
          genres: movie.genreIDs ?? [],
          id: movie.id ?? 0,
          voteAverage: movie.voteAverage ?? 0.0,
          voteCount: movie.voteCount ?? 0,
          overview: movie.overview ?? ""
        )
      })
  }

  private
  func convert(_ repositoryItem: MoviesRepositoryModel?) -> MoviesItems {
    MoviesItems(
      page: repositoryItem?.page ?? 0,
      movies: convert(repositoryItem?.movies),
      totalPages: repositoryItem?.totalPages ?? 0
    )
  }

  public
  func convert(_ genres: [GenreRepositoryModel]?) -> [MovieGenre] {
    genres?.compactMap({ genre in
      MovieGenre(
        id: genre.id ?? 00,
        name:genre.name ?? "--"
      )
    }) ?? []
  }

  func fetchGenres() -> AnyPublisher<[MovieGenre], ModuleError> {
    return Future { [weak self] promise in
      guard let self else { return }
      genresRepository.getGenre()
        .sink(receiveCompletion: { result in
          if case .failure(let error) = result {
            promise(.failure(
              ModuleError(error: error)
            ))
          }
        }, receiveValue: { [weak self] response in
          guard 
            let self,
            let response
          else { return }
          promise(.success(convert(response)))
        })
        .store(in: &cancellable)
      }
    .eraseToAnyPublisher()
  }
}

// MARK: - MoviesUseCaseProtocol
extension MoviesUseCase: MoviesUseCaseProtocol {
  func fetchMovies(for currentPage: Int) -> AnyPublisher<MoviesItems, ModuleError> {
    return Future { [weak self] promise in
      guard let self else { return }
      moviesRepository.getMovies(for: currentPage)
        .sink(receiveCompletion: { result in
          if case .failure(let error) = result {
            promise(.failure(
              ModuleError(error: error)
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

  func search(with searchText: String, and searchPage: Int) -> AnyPublisher<MoviesItems, ModuleError> {
      return Future { [weak self] promise in
        guard let self else { return }
        moviesRepository.getSearchedMovies(with: searchText, and: searchPage)
          .sink(receiveCompletion: { result in
            if case .failure(let error) = result {
              promise(.failure(
                ModuleError(error: error)
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
