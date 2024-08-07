//
//  File.swift
//  
//
//  Created by Menaim on 06/08/2024.
//

import Foundation

public
protocol MoviesCoordinatorProtocol {
  func start()
  func getSelectedMovieID() -> String?
  func showMovieDetail(with movieID: String)
  func goBack()
}
