//
//  MovieDetailsRepositoryTests.swift
//  
//
//  Created by Menaim on 07/08/2024.
//

import Foundation
import Combine
import XCTest
import MANetwork
@testable import MovieDetailsModule

final class MovieDetailsRepositoryTests: XCTestCase {
  private var sut: MovieDetailsRepositoryProtocol!
  private var client: MovieDetailsAPIClientProtocol!
  private var cancellable: Set<AnyCancellable> = []

  override func setUp() {
    super.setUp()
    client = MockMovieDetailsAPIClient()
    let repository = MovieDetailsRepository(client: client)
    sut = repository
  }

  override func tearDown() {
    sut = nil
    client = nil
    super.tearDown()
  }

  func test_returns_movieDetails_not_nil() {
    sut.getMovieDetails(with: "448150")
      .sink(receiveCompletion: { completion in
        // Assert
        if case .failure(let error) = completion {
          XCTFail("Expected success but received error: \(error)")
        }
      }, receiveValue: { movieDetails in
        // Assert
        XCTAssertNotNil(movieDetails, "Expected movie details not to be nil")
      })
      .store(in: &cancellable)
  }

  func test_returns_movieDetails_data_correctly() {
    // Arrange
    let expectedValue = "Deadpool & Wolverine"
    // Act
    sut.getMovieDetails(with: "448150")
      .sink(receiveCompletion: { completion in
        // Assert
        if case .failure(let error) = completion {
          XCTFail("Expected success but received error: \(error)")
        }
      }, receiveValue: { movieDetails in
        // Assert
        XCTAssertEqual(movieDetails?.originalTitle, expectedValue, "Expected title to be correct")
      })
      .store(in: &cancellable)
  }
}
