//
//  MockMovieDetailsRepository.swift
//
//
//  Created by Menaim on 06/08/2024.
//

import Foundation
import Combine
import MANetwork
@testable import MovieDetailsModule

class MockMovieDetailsRepository: MovieDetailsRepositoryProtocol {
  func getMovieDetails(with id: String) -> AnyPublisher<MovieDetailsRepositoryModel?, RepositoryError> {
    let genres = [
      MovieDetailsGenreRepositoryModel(
        id: 28,
        name: "Action"
      ),
      MovieDetailsGenreRepositoryModel(
        id: 35,
        name: "Comedy"
      ),
      MovieDetailsGenreRepositoryModel(
        id: 878,
        name: "Science Fiction"
      )
    ]

    let spokenLanguages = [
      SpokenLanguageRepositoryModel(
        englishName: "English",
        name: "English"
      )
    ]

    let mockMovieDetails = MovieDetailsRepositoryModel(
        id: Int(id),
        originalLanguage: "en",
        originalTitle: "Deadpool & Wolverine",
        overview: "A listless Wade Wilson toils away in civilian life with his days as the morally flexible mercenary, Deadpool, behind him. But when his homeworld faces an existential threat, Wade must reluctantly suit-up again with an even more reluctant Wolverine.",
        status: "Released",
        posterPath: "/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg",
        releaseDate: "2024-07-24",
        genres: genres,
        homepage: "https://www.marvel.com/movies/deadpool-and-wolverine",
        budget: 200000000,
        revenue: 824075919,
        runtime: 128,
        spokenLanguages: spokenLanguages
    )
    return Future { promise in
        promise(.success(mockMovieDetails))
    }
    .eraseToAnyPublisher()
  }
}
