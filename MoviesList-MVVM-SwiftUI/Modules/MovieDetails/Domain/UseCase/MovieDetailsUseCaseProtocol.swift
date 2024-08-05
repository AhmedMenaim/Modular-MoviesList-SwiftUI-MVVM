//
//  MovieDetailsUseCaseProtocol.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 05/08/2024.
//

import Combine
import Foundation

protocol MovieDetailsUseCaseProtocol {
  func fetchMovieDetails(for id: String) -> AnyPublisher<MovieDetailsItem, ModuleError>
}

struct MovieDetailsItem {
  let id: Int
  let originalLanguage, originalTitle, overview: String
  let status: String
  var posterPath: String
  let releaseDate: String
  let genres: [MovieDetailsGenre]
  let homepage: String
  let budget: Int
  let revenue, runtime: Int
  let spokenLanguages: [SpokenLanguage]

  init(
    id: Int = 00,
    originalLanguage: String = "--",
    originalTitle: String = "--",
    overview: String = "--",
    status: String = "--",
    posterPath: String = "--",
    releaseDate: String = "--",
    genres: [MovieDetailsGenre] = [],
    homepage: String = "--",
    budget: Int = 00,
    revenue: Int = 00,
    runtime: Int = 00,
    spokenLanguages: [SpokenLanguage] = []
  ) {
    self.id = id
    self.originalLanguage = originalLanguage
    self.originalTitle = originalTitle
    self.overview = overview
    self.status = status
    self.posterPath = posterPath
    self.releaseDate = releaseDate
    self.genres = genres
    self.homepage = homepage
    self.budget = budget
    self.revenue = revenue
    self.runtime = runtime
    self.spokenLanguages = spokenLanguages
  }
}

// MARK: - Genre
struct MovieDetailsGenre {
    let id: Int
    let name: String
}

// MARK: - SpokenLanguage
struct SpokenLanguage {
    let englishName, name: String?
}
