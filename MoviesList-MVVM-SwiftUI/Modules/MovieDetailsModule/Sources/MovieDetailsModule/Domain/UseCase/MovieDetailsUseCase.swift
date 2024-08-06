//
//  MovieDetailsUseCase.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 05/08/2024.
//

import Combine
import Commons

final class MovieDetailsUseCase {
  // MARK: - Vars
  private var cancellable: Set<AnyCancellable> = []

  // MARK: - Dependencies
  private var repository: MovieDetailsRepositoryProtocol

  init(repository: MovieDetailsRepositoryProtocol) {
    self.repository = repository
  }

  // MARK: - Privates
  private
  func convert(_ response: [MovieDetailsGenreRepositoryModel]?) -> [MovieDetailsGenre]? {
    guard
      let genres = response
    else {
      return nil
    }
    return genres.map { genre in
      MovieDetailsGenre(
        id: genre.id ?? -1,
        name: genre.name ?? "--"
      )
    }
  }

  private
  func convert(_ response: [SpokenLanguageRepositoryModel]?) -> [SpokenLanguage]? {
    guard
      let languages = response
    else {
      return nil
    }
    return languages.map { language in
      SpokenLanguage(
        englishName: language.englishName ?? "--",
        name: language.name ?? "--"
      )
    }
  }

  private
  func convert(_ response: MovieDetailsRepositoryModel?) -> MovieDetailsItem {
    return MovieDetailsItem(
      id: response?.id ?? -1,
      originalLanguage: response?.originalLanguage ?? "--",
      originalTitle: response?.originalTitle ?? "--",
      overview: response?.overview ?? "--",
      status: response?.status ?? "--",
      posterPath: response?.posterPath ?? "--",
      releaseDate: response?.releaseDate ?? "--",
      genres: convert(response?.genres) ?? [],
      homepage: response?.homepage ?? "--",
      budget: response?.budget ?? 00,
      revenue: response?.revenue ?? 00,
      runtime: response?.runtime ?? 00,
      spokenLanguages: convert(response?.spokenLanguages) ?? []
    )
  }
}

// MARK: - MovieDetailsUseCaseProtocol
extension MovieDetailsUseCase: MovieDetailsUseCaseProtocol {
  func fetchMovieDetails(for id: String) -> AnyPublisher<MovieDetailsItem, ModuleError> {
    return Future { [weak self] promise in
      guard let self else { return }
      repository.getMovieDetails(with: id)
        .sink(receiveCompletion: { result in
          if case .failure(let error) = result {
            promise(.failure(ModuleError(error: error)))
          }
        }, receiveValue: { [weak self] response in
          guard let self else { return }
          promise(.success(convert(response)))
        })
        .store(in: &cancellable)
    }
    .eraseToAnyPublisher()
  }
}
