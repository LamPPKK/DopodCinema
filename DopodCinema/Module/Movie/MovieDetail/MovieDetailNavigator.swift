//
//  MovieDetailNavigator.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/25.
//

import UIKit

protocol MovieDetailNavigator {
    func start(_ movieDetailInfo: MovieDetailInfo)
    func gotoActorDetail(_ actorDetailInfo: ActorDetailInfo)
    func gotoDetailShowTime(_ movieDetailInfo: MovieDetailInfo)
    func gotoTrailerScreen(with list: [VideoInfo])
}

class DefaultMovieDetailNavigator: MovieDetailNavigator {
    // MARK: - Properties
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(_ movieDetailInfo: MovieDetailInfo) {
        let movieDetailVC = MovieDetailViewController(nibName: "MovieDetailViewController", bundle: nil)
        let viewModel = MovieDetailViewModel(self,
                                             movieDetailInfo: movieDetailInfo)
        movieDetailVC.viewModel = viewModel
        self.navigationController.pushViewController(movieDetailVC, animated: true)
    }
    
    func gotoActorDetail(_ actorDetailInfo: ActorDetailInfo) {
        let navigator = DefaultActorDetailNavigator(navigationController: self.navigationController)
        navigator.start(actorDetailInfo)
    }
    
    func gotoDetailShowTime(_ movieDetailInfo: MovieDetailInfo) {
        let navigator = DefaultShowTimeDetailNavigator(navigationController: self.navigationController)
        navigator.start(with: movieDetailInfo)
    }
    
    func gotoTrailerScreen(with list: [VideoInfo]) {
        let navigator = DefaultTrailerNavigator(navigationController: self.navigationController)
        navigator.start(with: list)
    }
}

