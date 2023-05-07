//
//  ActorDetailNavigator.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/04.
//

import UIKit

protocol ActorDetailNavigator {
    func start(_ actorDetailInfo: ActorDetailInfo)
    func gotoMovieDetail(_ movieDetailInfo: MovieDetailInfo)
    func gotoTVShowDetail(_ tvDetailInfo: TVShowDetailInfo)
}

class DefaultActorDetailNavigator: ActorDetailNavigator {
    // MARK: - Properties
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(_ actorDetailInfo: ActorDetailInfo) {
        let actorDetailVC = ActorDetailViewController(nibName: "ActorDetailViewController", bundle: nil)
        actorDetailVC.viewModel = ActorDetailViewModel(navigator: self, actorDetailInfo: actorDetailInfo)
        self.navigationController.pushViewController(actorDetailVC, animated: true)
    }
    
    func gotoMovieDetail(_ movieDetailInfo: MovieDetailInfo) {
        let navigator = DefaultMovieDetailNavigator(navigationController: self.navigationController)
        navigator.start(movieDetailInfo)
    }
    
    func gotoTVShowDetail(_ tvDetailInfo: TVShowDetailInfo) {
        let navigator = DefaultTVDetailNavigator(navigationController: navigationController)
        navigator.start(tvDetailInfo)
    }
}
