//
//  MovieDetailsView.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 05/08/2024.
//

import SwiftUI
import Kingfisher

public
struct MovieDetailView: View {
  @StateObject private var viewModel: MovieDetailsViewModel

  init(viewModel: MovieDetailsViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel)
  }

  public
  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 16) {
        KFImage(URL(string: viewModel.movieDetails.posterPath))
          .resizable()
          .aspectRatio(contentMode: .fit)

        HStack(alignment: .top, spacing: 12) {
          KFImage(URL(string: viewModel.movieDetails.posterPath))
            .resizable()
            .frame(width: 100, height: 150)
            .cornerRadius(8)

          VStack(alignment: .leading, spacing: 4) {
            Text(viewModel.movieDetails.originalTitle)
              .font(.title)
              .bold()

            Text(viewModel.movieDetails.genres.map { $0.name }.joined(separator: ", "))
              .font(.subheadline)
              .foregroundColor(.gray)
          }
        }

        Text(viewModel.movieDetails.overview)
          .font(.body)
          .padding(.vertical)

        if let homePageURL = URL(string: viewModel.movieDetails.homepage) {
          HStack {
            Text("Homepage: ")
              .bold()
            Link(viewModel.movieDetails.homepage, destination: homePageURL)
              .foregroundColor(.blue)
          }
        }
        HStack {
          Text("Languages: ")
            .bold()
          Text(viewModel.movieDetails.spokenLanguages.compactMap { $0.name }.joined(separator: ", "))
        }

        HStack {
          Text("Status: ")
            .bold()
          Text(viewModel.movieDetails.status)
        }

        HStack {
          Text("Runtime: ")
            .bold()
          Text("\(viewModel.movieDetails.runtime) minutes")
        }

        HStack {
          Text("Budget: ")
            .bold()
          Text("\(viewModel.movieDetails.budget) $")
        }

        HStack {
          Text("Revenue: ")
            .bold()
          Text("\(viewModel.movieDetails.revenue) $")
        }

        Spacer()
      }
      .padding()
    }
    .background(Color(UIColor.systemBackground))
    .foregroundColor(.primary)
    .navigationBarTitle(viewModel.movieDetails.originalTitle, displayMode: .inline)
    .redacted(reason: viewModel.state.isLoading ? .placeholder : [])
    .onAppear {
      viewModel.showMovieDetails()
    }
    .alert(isPresented: $viewModel.state.isOffline) {
      return Alert(
        title: Text("You are in offline mode"),
        message: Text(""),
        dismissButton: .default(Text("Go Back")) {
          viewModel.goBack()
        }
      )
    }
  }
}
