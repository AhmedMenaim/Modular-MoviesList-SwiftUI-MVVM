//
//  MovieDetailsModuleFactory.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 05/08/2024.
//

import Foundation

class MovieDetailsModuleFactory {
  static func makeModule(with coordinator: MoviesCoordinatorProtocol) -> MovieDetailView {
    let baseAPIClient = BaseAPIClient()
    let movieDetailsClient = MovieDetailsAPIClient(client: baseAPIClient)
    let repository = MovieDetailsRepository(client: movieDetailsClient)
    let useCase = MovieDetailsUseCase(repository: repository)
    let viewModel = MovieDetailsViewModel(
      useCase: useCase,
      coordinator: coordinator
    )
    let view = MovieDetailView(viewModel: viewModel)
    return view
  }
}
