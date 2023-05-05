//
//  MovieListNavigator.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/14.
//

import UIKit

protocol MovieListNavigator {
    func start(with title: String, type: MovieType, movieList: [MovieInfo], categories: [GenreInfo])
    func gotoMovieDetail(_ movieDetailInfo: MovieDetailInfo)
}

class DefaultMovieListNavigator: MovieListNavigator {
    // MARK: - Properties
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(with title: String, type: MovieType, movieList: [MovieInfo], categories: [GenreInfo]) {
        let movieListVC = MovieListViewController(nibName: "MovieListViewController", bundle: nil)
        movieListVC.viewModel = MovieListViewModel(navigator: self,
                                                   title: title,
                                                   type: type,
                                                   movieList: movieList,
                                                   categories: categories)
        navigationController.pushViewController(movieListVC, animated: true)
    }
    
    func gotoMovieDetail(_ movieDetailInfo: MovieDetailInfo) {
        let navigator = DefaultMovieDetailNavigator(navigationController: navigationController)
        navigator.start(movieDetailInfo)
    }
}
