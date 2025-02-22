//
//  MovieDetailsViewModel.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 05/08/2024.
//

import SwiftUI
import Combine
import Commons

final class MovieDetailsViewModel: ObservableObject {
  // MARK: - Vars
  @Published var state = MovieDetailsViewState()
  var movieDetails: MovieDetailsItem {
    state.movieDetails
  }
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
    state.isLoading = true
    guard
      let selectedMovieID = coordinator.getSelectedMovieID()
    else { return }
    useCase.fetchMovieDetails(for: selectedMovieID)
      .sink { [weak self] completion in
        guard let self else {
          return
        }
        if case .failure = completion {
          state.isOffline = true
        }
        state.isLoading = false
      } receiveValue: { [weak self] details in
        guard let self else { return }
        state.movieDetails = details
        state.isLoading = false
      }
      .store(in: &cancellable)
  }

  func goBack() {
    coordinator.goBack(animated: true)
  }
}
