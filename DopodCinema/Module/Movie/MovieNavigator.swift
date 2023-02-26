//
//  MovieNavigator.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/25.
//

import UIKit

protocol MovieNavigator {
    func start()
    func gotoMovieDetail(_ movieDetailInfo: MovieDetailInfo)
}

class DefaultMovieNavigator: MovieNavigator {
    // MARK: - Properties
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    func start() {
        let movieVC = MovieViewController(nibName: "MovieViewController", bundle: nil)
        movieVC.viewModel = MovieViewModel(navigator: self)
        navigationController.pushViewController(movieVC, animated: true)
    }
    
    func gotoMovieDetail(_ movieDetailInfo: MovieDetailInfo) {
        let movieDetailViewModel = MovieDetailViewModel(movieDetailInfo)
        let movieDetailVC = MovieDetailViewController(nibName: "MovieDetailViewController", bundle: nil)
        movieDetailVC.viewModel = movieDetailViewModel
        navigationController.pushViewController(movieDetailVC, animated: true)
    }
}
