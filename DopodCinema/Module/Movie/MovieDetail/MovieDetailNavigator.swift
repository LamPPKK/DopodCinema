//
//  MovieDetailNavigator.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/25.
//

import UIKit

protocol MovieDetailNavigator {
    func start(_ movieDetailInfo: MovieDetailInfo)
}

class DefaultMovieDetailNavigator: MovieDetailNavigator {
    // MARK: - Properties
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(_ movieDetailInfo: MovieDetailInfo) {
        let navigator = DefaultMovieDetailNavigator(navigationController: navigationController)
        let movieDetailVC = MovieDetailViewController(nibName: "MovieDetailViewController", bundle: nil)
        let viewModel = MovieDetailViewModel(navigator, movieDetailInfo: movieDetailInfo)
        movieDetailVC.viewModel = viewModel
        self.navigationController.pushViewController(movieDetailVC, animated: true)
    }
}

