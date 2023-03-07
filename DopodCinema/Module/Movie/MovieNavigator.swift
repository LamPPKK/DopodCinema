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
    func gotoActorDetail(_ actorDetailInfo: ActorDetailInfo)
    func gotoCategory(with selectedIndex: Int?, categories: [GenreInfo], id: Int)
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
        let navigator = DefaultMovieDetailNavigator(navigationController: navigationController)
        navigator.start(movieDetailInfo)
    }
    
    func gotoActorDetail(_ actorDetailInfo:  ActorDetailInfo) {
        let navigator = DefaultActorDetailNavigator(navigationController: navigationController)
        navigator.start(actorDetailInfo)
    }
    
    func gotoCategory(with selectedIndex: Int?, categories: [GenreInfo], id: Int) {
        let navigator = DefaultCategoryNavigator(navigationController: navigationController)
        navigator.start(with: selectedIndex, categories: categories, id: id)
    }
}
