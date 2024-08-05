//
//  MoviesRepositoryProtocol.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 05/08/2024.
//

import Combine

protocol MoviesRepositoryProtocol: MoviesRepositoryGettable { }

protocol MoviesRepositoryGettable {
  func getMovies() -> AnyPublisher<MoviesRepositoryModel?, RepositoryError>
  func getSearchedMovies(with searchedText: String) -> AnyPublisher<MoviesRepositoryModel?, RepositoryError>
}
