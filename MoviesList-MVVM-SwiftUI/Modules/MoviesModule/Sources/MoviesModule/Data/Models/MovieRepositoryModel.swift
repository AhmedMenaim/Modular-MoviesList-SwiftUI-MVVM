//
//  MovieRepositoryModel.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 05/08/2024.
//

import Foundation

struct MoviesRepositoryModel {
  let page: Int?
  let movies: [MovieRepositoryModel]?
  let totalPages: Int?
}

// MARK: - MovieRepositoryModel
struct MovieRepositoryModel {
  let posterPath: String?
  let title: String?
  let releaseDate: Date?
  let genreIDs: [Int]?
  let id: Int?
  let voteAverage: Double?
  let voteCount: Int?
  let overview: String?
}
