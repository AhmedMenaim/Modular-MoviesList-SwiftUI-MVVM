//
//  MoviesModuleFactory.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 04/08/2024.
//

import Foundation

class MoviesModuleFactory {
  static func makeModule(with coordinator: MoviesCoordinatorProtocol) -> MoviesView {
    let baseAPIClient = BaseAPIClient()
    let moviesClient = MoviesAPIClient(client: baseAPIClient)
    let genresClient = GenreAPIClient(client: baseAPIClient)
    let moviesRepository = MoviesRepository(client: moviesClient)
    let genresRepository = GenreRepository(client: genresClient)
    let useCase = MoviesUseCase(
      moviesRepository: moviesRepository,
      genresRepository: genresRepository
    )
    let viewModel = MoviesViewModel(
      useCase: useCase,
      coordinator: coordinator
    )
    let view = MoviesView(viewModel: viewModel)
    return view
  }
}
