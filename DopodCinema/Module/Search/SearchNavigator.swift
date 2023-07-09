//
//  SearchNavigator.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/15.
//

import UIKit

protocol SearchNavigator {
    func start()
    func gotoMovieDetail(_ movieDetailInfo: MovieDetailInfo)
    func gotoTVDetail(_ tvDetailInfo: TVShowDetailInfo)
    func gotoActorDetail(_ actorDetailInfo: ActorDetailInfo)
}

class DefaultSearchNavigator: SearchNavigator {
    // MARK: - Properties
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let searchVC = SearchViewController(nibName: "SearchViewController", bundle: nil)
        searchVC.viewModel = SearchViewModel(navigator: self)
        navigationController.pushViewController(searchVC, animated: true)
    }
    
    func gotoMovieDetail(_ movieDetailInfo: MovieDetailInfo) {
        let navigator = DefaultMovieDetailNavigator(navigationController: navigationController)
        let movieDetailVC = MovieDetailViewController(nibName: "MovieDetailViewController", bundle: nil)
        let viewModel = MovieDetailViewModel(navigator,
                                             movieDetailInfo: movieDetailInfo)
        movieDetailVC.viewModel = viewModel
        navigationController.pushViewController(movieDetailVC, animated: true)
    }
    
    func gotoTVDetail(_ tvDetailInfo: TVShowDetailInfo) {
        let navigator = DefaultTVDetailNavigator(navigationController: navigationController)
        navigator.start(tvDetailInfo)
    }
    
    func gotoActorDetail(_ actorDetailInfo: ActorDetailInfo) {
        let navigator = DefaultActorDetailNavigator(navigationController: navigationController)
        navigator.start(actorDetailInfo)
    }
}
