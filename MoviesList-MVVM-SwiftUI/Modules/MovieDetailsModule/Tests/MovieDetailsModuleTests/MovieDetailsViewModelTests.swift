//
//  MovieDetailsViewModelTests.swift
//
//
//  Created by Menaim on 07/08/2024.
//

import XCTest
import Combine
@testable import MovieDetailsModule

final class MovieDetailsTests: XCTestCase {
  private var viewModel: MovieDetailsViewModel!
  private var mockUseCase: MockMovieDetailsUseCase!
  private var mockCoordinator: MockCoordinator!
  private var cancellable: Set<AnyCancellable>!

  override func setUp() {
    super.setUp()
    mockUseCase = MockMovieDetailsUseCase()
    mockCoordinator = MockCoordinator()
    viewModel = MovieDetailsViewModel(useCase: mockUseCase, coordinator: mockCoordinator)
    cancellable = []
  }

  override func tearDown() {
    mockUseCase = nil
    mockCoordinator = nil
    viewModel = nil
    cancellable = nil
    super.tearDown()
  }

  func test_show_movieDetails_successfully() {
    // Arrange
    let genres = [
      MovieDetailsGenre(
        id: 28,
        name: "Action"
      ),
      MovieDetailsGenre(
        id: 35,
        name: "Comedy"
      ),
      MovieDetailsGenre(
        id: 878,
        name: "Science Fiction"
      )
    ]

    let spokenLanguages = [
      SpokenLanguage(
        englishName: "English",
        name: "English"
      )
    ]

    let expectedMovieDetails = MovieDetailsItem(
      id: 448150,
      originalLanguage: "en",
      originalTitle: "Deadpool & Wolverine",
      overview: "A listless Wade Wilson toils away in civilian life with his days as the morally flexible mercenary, Deadpool, behind him. But when his homeworld faces an existential threat, Wade must reluctantly suit-up again with an even more reluctant Wolverine.",
      status: "Released",
      posterPath: "/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg",
      releaseDate: "2024-07-24",
      genres: genres,
      homepage: "https://www.marvel.com/movies/deadpool-and-wolverine",
      budget: 200000000,
      revenue: 824075919,
      runtime: 128,
      spokenLanguages: spokenLanguages
    )
    mockCoordinator.selectedMovieID = "448150"

    // Act
    viewModel.$movieDetails
      .dropFirst()
      .sink { details in
        XCTAssertEqual(details.overview, expectedMovieDetails.overview)
      }
      .store(in: &cancellable)

    viewModel.showMovieDetails()

    // Assert
    XCTAssertFalse(viewModel.isLoading)
  }
}
