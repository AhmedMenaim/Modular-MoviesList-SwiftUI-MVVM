//
//  MoviesCoordinator.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 05/08/2024.
//

import UIKit
import SwiftUI
import Commons
import MoviesModule
import MovieDetailsModule

class MoviesCoordinator {
  var navigationController: UINavigationController
  private var selectedMovieID: String?

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
}

// MARK: - MoviesCoordinatorProtocol
extension MoviesCoordinator: MoviesCoordinatorProtocol {
  func start() {
    let moviesView = MoviesModuleFactory.makeModule(with: self)
    let hostingController = UIHostingController(rootView: moviesView)
    navigationController.setViewControllers([hostingController], animated: false)
  }

  func showMovieDetail(with movieID: String) {
    selectedMovieID = movieID
    let movieDetailView = MovieDetailsModuleFactory.makeModule(with: self)
    let hostingController = UIHostingController(rootView: movieDetailView)
    navigationController.pushViewController(hostingController, animated: true)
  }

  func getSelectedMovieID() -> String? {
    selectedMovieID
  }

  func goBack() {
    navigationController.popViewController(animated: true)
  }
}
