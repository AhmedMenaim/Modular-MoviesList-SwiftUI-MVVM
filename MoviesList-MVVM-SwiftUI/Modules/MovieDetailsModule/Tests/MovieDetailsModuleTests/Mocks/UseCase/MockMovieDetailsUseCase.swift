//
//  MockMovieDetailsUseCase.swift
//
//
//  Created by Menaim on 07/08/2024.
//

import Foundation
import Combine
import Commons
@testable import MovieDetailsModule

class MockMovieDetailsUseCase: MovieDetailsUseCaseProtocol {
  func fetchMovieDetails(for id: String) -> AnyPublisher<MovieDetailsItem, ModuleError> {
    let genres = [
      MovieDetailsGenre(
        id: 28,
        name: "Action"
      ),
      MovieDetailsGenre(
        id: 35,
        name: "Comedy"
      ),
      MovieDetailsGenre(
        id: 878,
        name: "Science Fiction"
      )
    ]

    let spokenLanguages = [
      SpokenLanguage(
        englishName: "English",
        name: "English"
      )
    ]

    let mockMovieDetails = MovieDetailsItem(
      id: Int(id) ?? 00,
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
