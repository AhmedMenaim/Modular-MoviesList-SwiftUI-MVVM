//
//  MoviesNetworkResponse.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 05/08/2024.
//

import Foundation

struct MoviesNetworkResponse: Codable {
  let page: Int?
  let movies: [MovieNetworkResponse]?
  let totalPages, totalResults: Int?

  enum CodingKeys: String, CodingKey {
    case page
    case movies = "results"
    case totalPages = "total_pages"
    case totalResults = "total_results"
  }
}

// MARK: - Result
struct MovieNetworkResponse: Codable {
  let adult: Bool?
  let backdropPath: String?
  let genreIDS: [Int]?
  let id: Int?
  let originalLanguage: String?
  let originalTitle, overview: String?
  let popularity: Double?
  let posterPath, releaseDate, title: String?
  let video: Bool?
  let voteAverage: Double?
  let voteCount: Int?

  enum CodingKeys: String, CodingKey {
    case adult
    case backdropPath = "backdrop_path"
    case genreIDS = "genre_ids"
    case id
    case originalLanguage = "original_language"
    case originalTitle = "original_title"
    case overview, popularity
    case posterPath = "poster_path"
    case releaseDate = "release_date"
    case title, video
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
  }
}
