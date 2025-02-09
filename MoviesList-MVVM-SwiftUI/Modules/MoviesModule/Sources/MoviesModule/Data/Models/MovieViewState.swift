//
//  MovieViewState.swift
//  MoviesModule
//
//  Created by Menaim on 09/02/2025.
//

import Foundation

struct MovieViewState {
  var movies: [MovieItem] = []
  var filteredMovies: [MovieItem] = []
  var searchedMovies: [MovieItem] = []
  var genres: [MovieGenre] = []
  var selectedGenre: MovieGenre? = nil
  var isLoading: Bool = false
  var searchText: String = ""
  var isSearchActive: Bool = false
  var isOffline: Bool = false
}
