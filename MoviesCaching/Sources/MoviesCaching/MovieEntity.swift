//
//  MovieEntity.swift
//
//
//  Created by Menaim on 06/08/2024.
//

import Foundation
import RealmSwift

public
class MovieEntity: Object {
  @objc public dynamic var id: String = "--"
  @objc public dynamic var title: String = "--"
  @objc public dynamic var releaseDate: Date = Date()
  @objc public dynamic var overview: String = "--"
  public let genreIDs = List<Int>()
  @objc public dynamic var voteAverage: Double = 0.0
  @objc public dynamic var voteCount: Int = 0
  @objc public dynamic var posterPath: String = "--"

  public 
  override static func primaryKey() -> String? {
    return "id"
  }
}
