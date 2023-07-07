//
//  MovieNavigator.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/25.
//

import UIKit

protocol MovieNavigator {
    func gotoSearch()
    func gotoMovieDetail(_ movieDetailInfo: MovieDetailInfo)
    func gotoActorDetail(_ actorDetailInfo: ActorDetailInfo)
    func gotoCategory(with categories: [GenreInfo])
    func gotoCategory(with selectedIndex: Int?, categories: [GenreInfo], id: Int)
    func gotoMovieList(with title: String, type: MovieType, categories: [GenreInfo])
    func gotoActorList(with title: String, actorList: [ActorInfo])
    func gotoDiscoverWallpaper()
}

class DefaultMovieNavigator: MovieNavigator {
    // MARK: - Properties
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: false)
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
    
    func gotoCategory(with categories: [GenreInfo]) {
        let navigator = DefaultCategoryNavigator(navigationController: navigationController)
        navigator.start(with: categories, screenType: .movie)
    }
    
    func gotoCategory(with selectedIndex: Int?, categories: [GenreInfo], id: Int) {
        let navigator = DefaultCategoryNavigator(navigationController: navigationController)
        navigator.start(with: selectedIndex, categories: categories, id: id, screenType: .movie)
    }
    
    func gotoMovieList(with title: String,
                       type: MovieType,
                       categories: [GenreInfo]) {
        let navigator = DefaultMovieListNavigator(navigationController: navigationController)
        let movieListVC = MovieListViewController(nibName: "MovieListViewController", bundle: nil)
        movieListVC.viewModel = MovieListViewModel(navigator: navigator,
                                                   service: MovieClient(),
                                                   title: title,
                                                   type: type,
                                                   categories: categories)
        navigationController.pushViewController(movieListVC, animated: true)
    }
    
    func gotoActorList(with title: String, actorList: [ActorInfo]) {
        let navigator = DefaultActorListNavigator(navigationController: navigationController)
        navigator.start(with: title, actorList: actorList)
    }
    
    func gotoDiscoverWallpaper() {
        let navigator = DefaultDiscoverWallpaperNavigator(navigationController: navigationController)
        navigator.start()
    }
}
