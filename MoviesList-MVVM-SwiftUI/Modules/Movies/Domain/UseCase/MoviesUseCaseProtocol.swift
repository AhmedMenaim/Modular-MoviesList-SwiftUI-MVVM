//
//  MoviesUseCaseProtocol.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 05/08/2024.
//

import Foundation
import Combine

protocol MoviesUseCaseProtocol {
  func fetchMovies() -> AnyPublisher<MoviesItems, ModuleError>
  func fetchGenres() -> AnyPublisher<[MovieGenre], ModuleError>
  func search(with searchText: String) -> AnyPublisher<MoviesItems, ModuleError>
}

struct MoviesItems {
  let page: Int
  let movies: [MovieItem]
  let totalPages: Int

  init(
    page: Int = 0,
    movies: [MovieItem] = [],
    totalPages: Int = 0
  ) {
    self.page = page
    self.movies = movies
    self.totalPages = totalPages
  }
}

struct MovieItem {
  var posterPath: String
  var title: String
  var releaseDate: Date
  var genres: [Int]
  let id: Int
  let voteAverage: Double
  let voteCount: Int
  let overview: String
}

struct MovieGenre {
  let id: Int
  let name: String
}
