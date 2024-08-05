//
//  MoviesCoordinatorView.swift
//  MoviesList-MVVM-SwiftUI
//
//  Created by Menaim on 05/08/2024.
//

import SwiftUI
import UIKit

struct MoviesCoordinatorView: UIViewControllerRepresentable {
    var coordinator: MoviesCoordinator

    func makeUIViewController(context: Context) -> UINavigationController {
        // Use the coordinator passed to the view
        let navigationController = UINavigationController()
        coordinator.navigationController = navigationController
        coordinator.start()
        return navigationController
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        // No updates needed for this example
    }
}
