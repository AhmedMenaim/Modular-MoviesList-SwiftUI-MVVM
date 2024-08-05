//
//  GenreRepositoryProtocol.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 05/08/2024.
//

import Combine

protocol GenreRepositoryProtocol: GenreRepositoryGettable { }

protocol GenreRepositoryGettable {
  func getGenre() -> AnyPublisher<[GenreRepositoryModel]?, RepositoryError>
}
