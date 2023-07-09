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
        let movieDetailVC = MovieDetailViewController(nibName: "MovieDetailViewController", bundle: nil)
        let viewModel = MovieDetailViewModel(navigator,
                                             movieDetailInfo: movieDetailInfo)
        movieDetailVC.viewModel = viewModel
        navigationController.pushViewController(movieDetailVC, animated: true)
    }
}
