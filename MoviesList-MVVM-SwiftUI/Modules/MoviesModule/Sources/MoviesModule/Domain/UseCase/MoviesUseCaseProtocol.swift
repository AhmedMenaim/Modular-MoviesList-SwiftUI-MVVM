//
//  MoviesUseCaseProtocol.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 05/08/2024.
//

import Foundation
import Combine
import Commons

protocol MoviesUseCaseProtocol {
  func fetchMovies(for currentPage: Int) -> AnyPublisher<MoviesItems, ModuleError>
  func fetchGenres() -> AnyPublisher<[MovieGenre], ModuleError>
  func search(with searchText: String,and searchPage: Int) -> AnyPublisher<MoviesItems, ModuleError>
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

public
struct MovieGenre {
  let id: Int
  let name: String
}
