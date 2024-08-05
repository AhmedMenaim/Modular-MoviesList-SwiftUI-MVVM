//
//  SessionDataTaskErrorResponse.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 04/08/2024.
//

import Foundation

struct SessionDataTaskErrorResponse: Codable {
  let error: SessionDataTaskErrorModel?
}

struct SessionDataTaskErrorModel: Codable {
  let code: Int?
  let status: Int?
  let message: String?
}
