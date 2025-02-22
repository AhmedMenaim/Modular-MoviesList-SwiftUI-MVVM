//
//  File.swift
//  
//
//  Created by Menaim on 06/08/2024.
//

import UIKit

public
protocol MoviesCoordinatorProtocol {
  func start()
  func setRootViewController<T: UIViewController>(_ rootViewController: T) -> UINavigationController
  func push<T: UIViewController>(_ viewController: T, animated: Bool)
  func goBack(animated: Bool)
  func present<T: UIViewController>(_ viewController: T, animated: Bool)
  func getSelectedMovieID() -> String?
  func showMovieDetail(with movieID: String)
}
