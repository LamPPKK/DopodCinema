//
//  MovieListNavigator.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/14.
//

import UIKit

protocol MovieListNavigator {
    func gotoMovieDetail(_ movieDetailInfo: MovieDetailInfo)
}

class DefaultMovieListNavigator: MovieListNavigator {
    // MARK: - Properties
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func gotoMovieDetail(_ movieDetailInfo: MovieDetailInfo) {
        let navigator = DefaultMovieDetailNavigator(navigationController: navigationController)
        navigator.start(movieDetailInfo)
    }
}
