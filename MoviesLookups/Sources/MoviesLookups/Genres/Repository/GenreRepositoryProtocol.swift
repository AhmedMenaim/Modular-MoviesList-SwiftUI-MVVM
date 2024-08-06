//
//  GenreRepositoryProtocol.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 05/08/2024.
//

import Combine
import MANetwork

public
protocol GenreRepositoryProtocol: GenreRepositoryGettable { }

public
protocol GenreRepositoryGettable {
  func getGenre() -> AnyPublisher<[GenreRepositoryModel]?, RepositoryError>
}
