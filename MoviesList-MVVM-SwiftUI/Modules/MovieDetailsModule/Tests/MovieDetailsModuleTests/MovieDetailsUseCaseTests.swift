//
//  MovieDetailsUseCaseTests.swift
//  
//
//  Created by Menaim on 07/08/2024.
//

import Foundation
import Combine
import XCTest
import MANetwork
@testable import MovieDetailsModule

final class MovieDetailsUseCaseTests: XCTestCase {
  private var sut: MovieDetailsUseCaseProtocol!
  private var repository: MovieDetailsRepositoryProtocol!
  private var cancellable: Set<AnyCancellable> = []

  override func setUp() {
    super.setUp()
    repository = MockMovieDetailsRepository()
    sut = MovieDetailsUseCase(repository: repository)
  }

  override func tearDown() {
    sut = nil
    repository = nil
    super.tearDown()
  }

  func test_returns_movieDetails_not_nil() {
    sut.fetchMovieDetails(for: "448150")
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
    let expectedValue = 128
    // Act
    sut.fetchMovieDetails(for: "448150")
      .sink(receiveCompletion: { completion in
        // Assert
        if case .failure(let error) = completion {
          XCTFail("Expected success but received error: \(error)")
        }
      }, receiveValue: { movieDetails in
        // Assert
        XCTAssertEqual(movieDetails.runtime, expectedValue, "Expected title to be correct")
      })
      .store(in: &cancellable)
  }
}
