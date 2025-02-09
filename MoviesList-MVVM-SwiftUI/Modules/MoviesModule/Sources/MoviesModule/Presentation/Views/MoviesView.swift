//
//  MoviesView.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 05/08/2024.
//

import SwiftUI
import Kingfisher

public
struct MoviesView: View {
  @StateObject private var viewModel: MoviesViewModel

  init(viewModel: MoviesViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel)
  }

  // MARK: - Views
  public
  var body: some View {
    NavigationView {
      VStack {
        SearchBar(viewModel: viewModel)
        GenresFilter(viewModel: viewModel)
        ScrollView(showsIndicators: false) {
          LazyVGrid(
            columns: viewModel.columnsGrids, spacing: 12) {
              ForEach(viewModel.state.filteredMovies, id: \.id) { movie in
                VStack(alignment: .leading) {
                  KFImage(URL(string: movie.posterPath))
                    .placeholder {
                      // Placeholder while downloading.
                      Image(systemName: "arrow.2.circlepath.circle")
                        .font(.largeTitle)
                        .opacity(0.3)
                    }
                    .retry(maxCount: 3, interval: .seconds(5))
                    .resizable()
                    .aspectRatio(contentMode: .fill)


                  Text(movie.title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(4)

                  Text("\(movie.releaseDate.year())")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(4)
                }
                .frame(maxWidth: .infinity)
                .background(Color.black)
                .cornerRadius(10)
                .padding(8)
                .onTapGesture {
                  viewModel.selectMovie(movie)
                }
                .onAppear {
                  viewModel.validatePagination(with: movie)
                }
              }
            }
        }
        .padding(12)
      }
      .navigationTitle("Watch New Movies")
      .redacted(reason: viewModel.state.isLoading ? .placeholder : [])
    }
    .onAppear {
      viewModel.showMovies()
      viewModel.showGenres()
    }
    .onChange(of: viewModel.state.searchText) { _ in
      viewModel.showSearchedMovies()
    }
    .alert(isPresented: $viewModel.state.isOffline) {
      return Alert(
        title: Text("You are in offline mode"),
        dismissButton: .default(Text("OK"))
      )
    }
  }
}
