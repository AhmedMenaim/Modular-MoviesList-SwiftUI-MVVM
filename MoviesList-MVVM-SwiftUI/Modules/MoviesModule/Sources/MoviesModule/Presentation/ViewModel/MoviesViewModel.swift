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
  @Published var movies: [MovieItem] = []
  @Published var filteredMovies: [MovieItem] = []
  @Published var searchedMovies: [MovieItem] = []
  @Published var genres: [MovieGenre] = []
  @Published var isLoading = false
  @Published var searchText = ""
  @Published var isSearchActive = false
  @Published var selectedGenre: MovieGenre? = nil  
  {
    didSet {
      filterMovies()
    }
  }
  private var currentPage = 0
  private var searchPage = 1
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
    currentPage += 1
    useCase.fetchMovies(for: currentPage)
      .sink { [weak self] _ in
        guard let self else {
          return
        }
        isLoading = false
      } receiveValue: { [weak self] response in
        guard let self else { return }
        movies += response.movies
        filterMovies()
        isLoading = false
      }
      .store(in: &cancellable)
  }

  func showSearchedMovies(isPaginated: Bool = false) {
    isLoading = true
    if isPaginated {
      searchPage += 1
    }
    if !searchText.isEmpty {
      isSearchActive = true
      useCase.search(with: searchText, and: searchPage)
        .sink { [weak self] _ in
          guard let self else {
            return
          }
          isLoading = false
        } receiveValue: { [weak self] response in
          guard let self else { return }
          if !response.movies.isEmpty {
            if isPaginated {
              searchedMovies += response.movies
            } else {
              searchedMovies = response.movies
            }
            movies = searchedMovies
            filterMovies()
          }
          isLoading = false
        }
        .store(in: &cancellable)
    }
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

  func validatePagination(with movie: MovieItem) {
      if let lastMovie = filteredMovies.last, movie.id == lastMovie.id {
        isSearchActive ? showSearchedMovies(isPaginated: true) : showMovies()
      }
  }

  func resetSearch() {
    isSearchActive = false
    searchText = ""
    movies = []
    currentPage = 0
    showMovies()
  }

  func filterMovies() {
    if let selectedGenreID = selectedGenre?.id {
          filteredMovies = movies.filter { $0.genres.contains(selectedGenreID) }
      } else {
          filteredMovies = movies
      }
      if !searchText.isEmpty {
          filteredMovies = movies.filter { $0.title.contains(searchText) }
      }
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
