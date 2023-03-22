//
//  FavoriteNavigator.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/22.
//

import UIKit

protocol FavoriteNavigator {
    func start()
    func gotoMovieDetail(_ movieDetailInfo: MovieDetailInfo)
    func gotoActorDetail(_ actorDetailInfo: ActorDetailInfo)
    func gotoTVDetail(_ tvDetailInfo: TVShowDetailInfo)
}

class DefaultFavoriteNavigator: FavoriteNavigator {

    // MARK: - Properties
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let favoriteVC = FavoriteViewController(nibName: "FavoriteViewController", bundle: nil)
        favoriteVC.viewModel = FavoriteViewModel(navigator: self)
        navigationController.pushViewController(favoriteVC, animated: true)
    }
    
    func gotoMovieDetail(_ movieDetailInfo: MovieDetailInfo) {
        let navigator = DefaultMovieDetailNavigator(navigationController: navigationController)
        navigator.start(movieDetailInfo)
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
