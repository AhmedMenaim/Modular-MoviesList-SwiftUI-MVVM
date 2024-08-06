//
//  MovieDetailsRepository.swift
//  MovieDetailsList-MVVM-SwiftUI
//
//  Created by Menaim on 05/08/2024.
//

import Combine
import MANetwork

final
class MovieDetailsRepository {
  // MARK: - Vars
  private var cancellable: Set<AnyCancellable> = []
  private var client: MovieDetailsAPIClientProtocol

  init(client: MovieDetailsAPIClientProtocol) {
    self.client = client
  }

  // MARK: - Privates
  private
  func convert(_ response: [MovieDetailsGenreNetworkResponse]?) -> [MovieDetailsGenreRepositoryModel]? {
    guard
      let genres = response
    else {
      return nil
    }
    return genres.map { genre in
      MovieDetailsGenreRepositoryModel(
        id: genre.id,
        name: genre.name
      )
    }
  }

  private
  func convert(_ response: [SpokenLanguageNetworkResponse]?) -> [SpokenLanguageRepositoryModel]? {
    guard
      let languages = response
    else {
      return nil
    }
    return languages.map { language in
      SpokenLanguageRepositoryModel(
        englishName: language.englishName,
        name: language.name
      )
    }
  }

  private
  func convert(_ response: MovieDetailsNetworkResponse?) -> MovieDetailsRepositoryModel? {
    return MovieDetailsRepositoryModel(
      id: response?.id,
      originalLanguage: response?.originalLanguage,
      originalTitle: response?.originalTitle,
      overview: response?.overview,
      status: response?.status,
      posterPath: "\(Constants.Network.imageBaseURL)\(response?.posterPath ?? "").jpg",
      releaseDate: response?.releaseDate,
      genres: convert(response?.genres),
      homepage: response?.homepage,
      budget: response?.budget,
      revenue: response?.revenue,
      runtime: response?.runtime,
      spokenLanguages: convert(response?.spokenLanguages)
    )
  }
}

extension  MovieDetailsRepository: MovieDetailsRepositoryProtocol {
  func getMovieDetails(with id: String) -> AnyPublisher<MovieDetailsRepositoryModel?, RepositoryError> {
    return Future { [weak self] promise in
      guard let self else { return }
      client.getMovieDetails(with: id)
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
