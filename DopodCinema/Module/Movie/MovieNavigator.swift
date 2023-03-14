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
    func gotoCategory(with categories: [GenreInfo])
    func gotoCategory(with selectedIndex: Int?, categories: [GenreInfo], id: Int)
    func gotoMovieList(with title: String, movieList: [MovieInfo], categories: [GenreInfo])
    func gotoActorList(with title: String, actorList: [ActorInfo])
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
    
    func gotoCategory(with categories: [GenreInfo]) {
        let navigator = DefaultCategoryNavigator(navigationController: navigationController)
        navigator.start(with: categories)
    }
    
    func gotoCategory(with selectedIndex: Int?, categories: [GenreInfo], id: Int) {
        let navigator = DefaultCategoryNavigator(navigationController: navigationController)
        navigator.start(with: selectedIndex, categories: categories, id: id)
    }
    
    func gotoMovieList(with title: String,
                       movieList: [MovieInfo],
                       categories: [GenreInfo]) {
        let navigator = DefaultMovieListNavigator(navigationController: navigationController)
        navigator.start(with: title, movieList: movieList, categories: categories)
    }
    
    func gotoActorList(with title: String, actorList: [ActorInfo]) {
        let navigator = DefaultActorListNavigator(navigationController: navigationController)
        navigator.start(with: title, actorList: actorList)
    }
}
