//
//  MoviesViewModel.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 05/08/2024.
//

import SwiftUI
import Combine

final class MoviesViewModel: ObservableObject {
  // MARK: - Vars
  @Published var movies: [MovieItem] = []
  @Published var genres: [MovieGenre] = []
  @Published var isLoading = false
  @Published var searchText = ""
  @Published var selectedGenre: MovieGenre? = nil
  private let debounceInterval = 0.3
  private var cancellable: Set<AnyCancellable> = []
  let columnsGrids = Array(repeating: GridItem(.flexible()), count: 2)

  // MARK: - Dependencies
  private var useCase: MoviesUseCaseProtocol
  private var coordinator: MoviesCoordinatorProtocol

  init(
    useCase: MoviesUseCaseProtocol,
    coordinator: MoviesCoordinatorProtocol
  ) {
    self.useCase = useCase
    self.coordinator = coordinator
  }
}

// MARK: - Fetching Data
extension MoviesViewModel {
  func showMovies() {
    isLoading = true
    useCase.fetchMovies()
      .sink { [weak self] _ in
        guard let self else {
          return
        }
        isLoading = false
      } receiveValue: { [weak self] response in
        guard let self else { return }
        movies = response.movies
        isLoading = false
      }
      .store(in: &cancellable)
  }

  func showSearchedMovies() {
    isLoading = true
    useCase.search(with: searchText)
      .sink { [weak self] _ in
        guard let self else {
          return
        }
        isLoading = false
      } receiveValue: { [weak self] response in
        guard let self else { return }
        if !response.movies.isEmpty {
          movies = response.movies
        }
        isLoading = false
      }
      .store(in: &cancellable)
  }

  func showGenres() {
    isLoading = true
    useCase.fetchGenres()
      .sink { [weak self] _ in
        guard let self else {
          return
        }
        isLoading = false
      } receiveValue: { [weak self] response in
        guard let self else { return }
        genres = response
        isLoading = false
      }
      .store(in: &cancellable)
  }

  func selectMovie(_ movie: MovieItem) {
    coordinator.showMovieDetail(with: "\(movie.id)")
  }
}

// MARK: - Presentation Logic
extension MoviesViewModel {
  func genreBackgroundColor(for genre: MovieGenre) -> Color {
    if let selectedGender = self.selectedGenre,
       selectedGender.id == genre.id {
      return Color.yellow
    } else {
      return Color.clear
    }
  }
  
  func genreForegroundColor(for genre: MovieGenre) -> Color {
    if let selectedGender = self.selectedGenre,
       selectedGender.id == genre.id {
      return Color.black
    } else {
      return Color.primary
    }
  }
}
