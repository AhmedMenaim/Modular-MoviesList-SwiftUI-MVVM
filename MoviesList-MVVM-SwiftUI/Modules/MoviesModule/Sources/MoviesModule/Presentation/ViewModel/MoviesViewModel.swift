//
//  MoviesViewModel.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 05/08/2024.
//

import SwiftUI
import Combine
import Commons

final class MoviesViewModel: ObservableObject {
  // MARK: - Vars
  @Published var state = MovieViewState() {
      didSet {
          filterMovies()
      }
  }
  var isEmptySearchText: Bool {
      state.searchText.isEmpty
  }

  private var currentPage = 0
  private var searchPage = 1
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
    state.isLoading = true
    currentPage += 1
    useCase.fetchMovies(for: currentPage)
      .sink { [weak self] completion in
        guard let self else {
          return
        }
        if case .failure = completion {
          state.isOffline = true
        }
        state.isLoading = false
      } receiveValue: { [weak self] response in
        guard let self else { return }
        state.movies += response.movies
        filterMovies()
        state.isLoading = false
      }
      .store(in: &cancellable)
  }

  func showSearchedMovies(isPaginated: Bool = false) {
    state.isLoading = true
    if isPaginated {
      searchPage += 1
    }
    if !isEmptySearchText {
      state.isSearchActive = true
      useCase.search(
        with: state.searchText,
        and: searchPage
      )
        .sink { [weak self] _ in
          guard let self else {
            return
          }
          state.isLoading = false
        } receiveValue: { [weak self] response in
          guard let self else { return }
          if !response.movies.isEmpty {
            if isPaginated {
              state.searchedMovies += response.movies
            } else {
              state.searchedMovies = response.movies
            }
            state.movies = state.searchedMovies
            filterMovies()
          }
          state.isLoading = false
        }
        .store(in: &cancellable)
    } else {
      showMovies()
    }
  }

  func showGenres() {
    state.isLoading = true
    useCase.fetchGenres()
      .sink { [weak self] _ in
        guard let self else {
          return
        }
        state.isLoading = false
      } receiveValue: { [weak self] response in
        guard let self else { return }
        state.genres = response
        state.isLoading = false
      }
      .store(in: &cancellable)
  }

  func selectMovie(_ movie: MovieItem) {
    coordinator.showMovieDetail(with: "\(movie.id)")
  }

  func validatePagination(with movie: MovieItem) {
    if
      let lastMovie = state.filteredMovies.last,
      movie.id == lastMovie.id
    {
      state.isSearchActive ? showSearchedMovies(isPaginated: true) : showMovies()
      }
  }

  func resetSearch() {
    state.isSearchActive = false
    state.searchText = ""
    state.movies = []
    currentPage = 0
    showMovies()
  }

  func filterMovies() {
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      var filtered = state.movies
      if let selectedGenreID = state.selectedGenre?.id {
        filtered = filtered.filter { $0.genres.contains(selectedGenreID) }
      }
      if !isEmptySearchText {
        filtered = filtered.filter { $0.title.localizedCaseInsensitiveContains(
          self.state.searchText
        )}
      }
      state.filteredMovies = filtered
    }
  }
}

// MARK: - Presentation Logic
extension MoviesViewModel {
  func genreBackgroundColor(for genre: MovieGenre) -> Color {
    if
      let selectedGender = state.selectedGenre,
       selectedGender.id == genre.id
    {
      return Color.yellow
    } else {
      return Color.clear
    }
  }
  
  func genreForegroundColor(for genre: MovieGenre) -> Color {
    if let selectedGender = state.selectedGenre,
       selectedGender.id == genre.id {
      return Color.black
    } else {
      return Color.primary
    }
  }
}
