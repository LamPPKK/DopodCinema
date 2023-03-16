//
//  TVShowNavigator.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/04.
//

import UIKit

protocol TVShowNavigator {
    func start()
    func gotoSearch()
    func gotoMovieDetail(_ movieDetailInfo: MovieDetailInfo)
    func gotoActorDetail(_ actorDetailInfo:  ActorDetailInfo)
    func gotoTVDetail(_ tvDetailInfo: TVShowDetailInfo)
}

class DefaultTVShowNavigator: TVShowNavigator {
    // MARK: - Properties
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    func start() {
        let tvShowVC = TVViewController(nibName: "TVViewController", bundle: nil)
        tvShowVC.viewModel = TVViewModel(navigator: self)
        navigationController.pushViewController(tvShowVC, animated: true)
    }
    
    func gotoSearch() {
        let navigator = DefaultSearchNavigator(navigationController: navigationController)
        navigator.start()
    }
    
    func gotoMovieDetail(_ movieDetailInfo: MovieDetailInfo) {
        let navigator = DefaultMovieDetailNavigator(navigationController: navigationController)
        navigator.start(movieDetailInfo)
    }
    
    func gotoActorDetail(_ actorDetailInfo:  ActorDetailInfo) {
        let navigator = DefaultActorDetailNavigator(navigationController: navigationController)
        navigator.start(actorDetailInfo)
    }
    
    func gotoTVDetail(_ tvDetailInfo: TVShowDetailInfo) {
        let navigator = DefaultTVDetailNavigator(navigationController: navigationController)
        navigator.start(tvDetailInfo)
    }
}
