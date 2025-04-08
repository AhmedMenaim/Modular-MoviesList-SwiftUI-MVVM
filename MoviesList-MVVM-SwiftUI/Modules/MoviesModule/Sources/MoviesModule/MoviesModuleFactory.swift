//
//  MoviesModuleFactory.swift
//  
//
//  Created by Menaim on 06/08/2024.
//

import MANetwork
import MoviesLookups
import Commons
import DatabaseKit

public
class MoviesModuleFactory {
  public
  static func makeModule(with coordinator: MoviesCoordinatorProtocol) -> MoviesView {
    let baseAPIClient = BaseAPIClient()
    let moviesClient = MoviesAPIClient(client: baseAPIClient)
    let genresClient = GenreAPIClient(client: baseAPIClient)
    let cacheManager = RealmDatabaseManager<MovieEntity>()
    let moviesRepository = MoviesRepository(
      client: moviesClient,
      cacheManager: cacheManager
    )
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

