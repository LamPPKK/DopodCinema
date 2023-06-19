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
    func gotoActorDetail(_ actorDetailInfo: ActorDetailInfo)
    func gotoTVDetail(_ tvDetailInfo: TVShowDetailInfo)
    func gotoActorList(with title: String, actorList: [ActorInfo])
    func gotoTVList(with title: String, type: TVShowType, list: [TVShowInfo], categories: [GenreInfo])
    func gotoCategory(with categories: [GenreInfo])
    func gotoCategory(with selectedIndex: Int?, categories: [GenreInfo], id: Int)
    func gotoDiscoverWallpaper()
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
    
    func gotoActorDetail(_ actorDetailInfo: ActorDetailInfo) {
        let navigator = DefaultActorDetailNavigator(navigationController: navigationController)
        navigator.start(actorDetailInfo)
    }
    
    func gotoTVDetail(_ tvDetailInfo: TVShowDetailInfo) {
        let navigator = DefaultTVDetailNavigator(navigationController: navigationController)
        navigator.start(tvDetailInfo)
    }
    
    func gotoActorList(with title: String, actorList: [ActorInfo]) {
        let navigator = DefaultActorListNavigator(navigationController: navigationController)
        navigator.start(with: title, actorList: actorList)
    }
    
    func gotoTVList(with title: String, type: TVShowType, list: [TVShowInfo], categories: [GenreInfo]) {
        let navigator = DefaultTVListNavigator(navigationController: navigationController)
        navigator.start(with: title, type: type, list: list, categories: categories)
    }
    
    func gotoCategory(with categories: [GenreInfo]) {
        let navigator = DefaultCategoryNavigator(navigationController: navigationController)
        navigator.start(with: categories, screenType: .tv)
    }
    
    func gotoCategory(with selectedIndex: Int?, categories: [GenreInfo], id: Int) {
        let navigator = DefaultCategoryNavigator(navigationController: navigationController)
        navigator.start(with: selectedIndex, categories: categories, id: id, screenType: .tv)
    }
    
    func gotoDiscoverWallpaper() {
        let navigator = DefaultDiscoverWallpaperNavigator(navigationController: navigationController)
        navigator.start()
    }
}
