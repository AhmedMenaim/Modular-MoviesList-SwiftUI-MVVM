//
//  MovieDetailsRepositoryProtocol.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 05/08/2024.
//

import Combine

protocol MovieDetailsRepositoryProtocol: MovieDetailsRepositoryGettable { }

protocol MovieDetailsRepositoryGettable {
  func getMovieDetails(with id: String) -> AnyPublisher<MovieDetailsRepositoryModel?, RepositoryError>
}
