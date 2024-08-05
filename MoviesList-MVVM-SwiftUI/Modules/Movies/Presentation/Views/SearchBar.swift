//
//  SearchBar.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 05/08/2024.
//

import SwiftUI

struct SearchBar: View {
  @ObservedObject var viewModel: MoviesViewModel

  var body: some View {
    HStack {
      TextField("Search TMDB", text: $viewModel.searchText)
        .padding(7)
        .padding(.horizontal, 25)
        .background(Color(.systemGray6))
        .cornerRadius(8)
        .overlay(
          HStack {
            Image(systemName: "magnifyingglass")
              .foregroundColor(.gray)
              .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
              .padding(.leading, 8)

            if !viewModel.searchText.isEmpty {
              Button(action: {
                viewModel.searchText = ""
                viewModel.showMovies()
              }) {
                Image(systemName: "multiply.circle.fill")
                  .foregroundColor(.gray)
                  .padding(.trailing, 8)
              }
            }
          }
        )
        .padding(.horizontal, 10)
    }
    .padding(.top, 10)
  }
}
