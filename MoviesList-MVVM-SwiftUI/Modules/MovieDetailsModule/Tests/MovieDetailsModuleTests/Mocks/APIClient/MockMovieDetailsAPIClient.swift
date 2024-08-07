//
//  MockMovieDetailsAPIClient.swift
//
//
//  Created by Menaim on 06/08/2024.
//

import Foundation
import XCTest
import Combine
import MANetwork
@testable import MovieDetailsModule

final class MockMovieDetailsAPIClient {
  func loadJson<T: Decodable>(filename fileName: String) -> AnyPublisher<T, SessionDataTaskError> {
    Future { promise in
      guard let url = Bundle.module.url(forResource: fileName, withExtension: "json") else {
        promise(.failure(SessionDataTaskError.notValidURL))
        return
      }
      print("Failed to find the file in the bundle path: \(url)")
      do {
        let data = try Data(contentsOf: url)
        print("Raw JSON data: \(String(data: data, encoding: .utf8) ?? "nil")")
        let decoder = JSONDecoder()
        let decodedData = try decoder.decode(T.self, from: data)
        promise(.success(decodedData))
      } catch {
        promise(.failure(SessionDataTaskError.noData))
      }
    }
    .eraseToAnyPublisher()
  }
}

extension MockMovieDetailsAPIClient: MovieDetailsAPIClientProtocol {
  func getMovieDetails(with movieID: String) -> AnyPublisher<MovieDetailsNetworkResponse, SessionDataTaskError> {
    loadJson(filename: "MockMovieDetailsNetworkResponse")
  }
}
