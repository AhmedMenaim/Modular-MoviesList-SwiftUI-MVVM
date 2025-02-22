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

  func setRootViewController<T>(_ rootViewController: T) -> UINavigationController where T : UIViewController {
    let navigationController = UINavigationController(rootViewController: rootViewController)
    self.navigationController = navigationController
    return navigationController
  }

  func push<T>(_ viewController: T, animated: Bool = true) where T : UIViewController {
    navigationController.pushViewController(viewController, animated: animated)
  }

  func present<T>(_ viewController: T, animated: Bool) where T : UIViewController {
    navigationController.present(viewController, animated: animated)
  }

  func goBack(animated: Bool = true) {
    if let presentedVC = navigationController.presentedViewController {
      presentedVC.dismiss(animated: animated)
    } else {
      navigationController.popViewController(animated: animated)
    }
  }

  func showMovieDetail(with movieID: String) {
    selectedMovieID = movieID
    let movieDetailView = MovieDetailsModuleFactory.makeModule(with: self)
    let hostingController = UIHostingController(rootView: movieDetailView)
    push(hostingController)
  }

  func getSelectedMovieID() -> String? {
    selectedMovieID
  }
}
