//
//  MockCoordinator.swift
//
//
//  Created by Menaim on 07/08/2024.
//

import Foundation
@testable import Commons

final class MockCoordinator: MoviesCoordinatorProtocol {
  func start() {
  }

  func showMovieDetail(with movieID: String) {
  }

    var selectedMovieID: String?

    func getSelectedMovieID() -> String? {
        return selectedMovieID
    }
}
