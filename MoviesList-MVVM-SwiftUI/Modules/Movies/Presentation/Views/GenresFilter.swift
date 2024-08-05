//
//  GenresFilter.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 05/08/2024.
//

import SwiftUI

struct GenresFilter: View {
  @ObservedObject var viewModel: MoviesViewModel
  
  var body: some View {
    ScrollView(.horizontal) {
      HStack(spacing: 12) {
        ForEach(viewModel.genres, id: \.id) { genre in
          Button(action: {
            viewModel.selectedGenre = genre
          }) {
            Text(genre.name)
              .padding()
              .background(
                viewModel.genreBackgroundColor(for: genre)
              )
              .foregroundColor(
                viewModel.genreForegroundColor(for: genre)
              )
              .frame(height: 32)
              .cornerRadius(16)
              .overlay(
                RoundedRectangle(cornerRadius: 16)
                  .stroke(Color.yellow, lineWidth: 2)
              )
              .foregroundColor(.black)
          }
        }
      }
      .padding(.horizontal)
    }
    .scrollIndicators(.hidden)
  }
}
