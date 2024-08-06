//
//  MovieDetailsNetworkResponse.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 05/08/2024.
//

import Foundation

// MARK: - MovieDetailsNetworkResponse
struct MovieDetailsNetworkResponse: Codable {
    let adult: Bool?
    let backdropPath: String?
    let budget: Int?
    let genres: [MovieDetailsGenreNetworkResponse]?
    let homepage: String?
    let id: Int?
    let imdbID: String?
    let originCountry: [String]?
    let originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let revenue, runtime: Int?
    let spokenLanguages: [SpokenLanguageNetworkResponse]?
    let status, tagline, title: String?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - Genre
struct MovieDetailsGenreNetworkResponse: Codable {
    let id: Int?
    let name: String?
}

// MARK: - SpokenLanguage
struct SpokenLanguageNetworkResponse: Codable {
    let englishName, name: String?

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case name
    }
}
