//
//  MovieDetailNavigator.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/25.
//

import UIKit

protocol MovieDetailNavigator {
    func start()
}

class DefaultMovieDetailNavigator: MovieDetailNavigator {
    // MARK: - Properties
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let navigator = DefaultMovieNavigator(navigationController: navigationController)
    }
}

