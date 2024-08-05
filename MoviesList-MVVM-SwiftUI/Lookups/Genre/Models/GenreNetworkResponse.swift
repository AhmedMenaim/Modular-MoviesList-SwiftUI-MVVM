//
//  GenreNetworkResponse.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 05/08/2024.
//

import Foundation

// MARK: - GenreNetworkResponse
struct GenreNetworkResponse: Codable {
    let genres: [Genre]?
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int?
    let name: String?
}
