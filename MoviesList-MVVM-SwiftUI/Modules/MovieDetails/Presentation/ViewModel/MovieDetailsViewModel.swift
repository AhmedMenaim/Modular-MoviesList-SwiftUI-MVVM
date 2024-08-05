//
//  MovieDetailsViewModel.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 05/08/2024.
//

import SwiftUI
import Combine

final class MovieDetailsViewModel: ObservableObject {
  // MARK: - Vars
  @Published var movieDetails: MovieDetailsItem = MovieDetailsItem()
  @Published var isLoading = true
  private var cancellable: Set<AnyCancellable> = []

  // MARK: - Dependencies
  private var useCase: MovieDetailsUseCaseProtocol
  private var coordinator: MoviesCoordinatorProtocol

  init(
    useCase: MovieDetailsUseCaseProtocol,
    coordinator: MoviesCoordinatorProtocol
  ) {
    self.useCase = useCase
    self.coordinator = coordinator
  }
}

// MARK: - MovieDetailsViewModel

extension MovieDetailsViewModel {
  func showMovieDetails() {
    isLoading = true
    guard 
      let selectedMovieID = coordinator.getSelectedMovieID()
    else { return }
    useCase.fetchMovieDetails(for: selectedMovieID)
        .sink { [weak self] _ in
          guard let self else {
            return
          }
          isLoading = false
        } receiveValue: { [weak self] details in
          guard let self else { return }
          movieDetails = details
          isLoading = false
        }
        .store(in: &cancellable)
    }
}
