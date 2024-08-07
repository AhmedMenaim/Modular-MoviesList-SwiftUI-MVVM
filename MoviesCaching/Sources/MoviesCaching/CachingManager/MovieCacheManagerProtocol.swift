//
//  MovieCacheManagerProtocol.swift
//  
//
//  Created by Menaim on 06/08/2024.
//

import Foundation

public
protocol MovieCacheManagerProtocol {
  func cacheMovies(_ movies: [MovieEntity])
  func getCachedMovies() -> [MovieEntity]
  func getMovie(by id: String) -> MovieEntity?
  func clearCache()
}
