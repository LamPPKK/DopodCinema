//
//  MovieDetailNavigator.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/25.
//

import UIKit

protocol MovieDetailNavigator {
    func gotoMovieDetail(_ movieDetailInfo: MovieDetailInfo)
    func gotoActorDetail(_ actorDetailInfo: ActorDetailInfo)
    func gotoDetailShowTime(_ movieDetailInfo: MovieDetailInfo)
    func gotoTrailerScreen(with list: [VideoInfo])
    func gotoScreenShots(with selectedIndex: Int, images: [ImageInfo])
    func gotoWatchScreen(posterPath: String, linkContainerInfo: LinkContainerInfo)
    func gotoYoutubeScreen(_ key: String)
}

class DefaultMovieDetailNavigator: MovieDetailNavigator {
    // MARK: - Properties
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func gotoMovieDetail(_ movieDetailInfo: MovieDetailInfo) {
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
    
    func gotoScreenShots(with selectedIndex: Int, images: [ImageInfo]) {
        let imageDetailViewController = ImageDetailScreen(selectedIndex: selectedIndex, images: images)
        navigationController.pushViewController(imageDetailViewController, animated: true)
    }
    
    func gotoWatchScreen(posterPath: String, linkContainerInfo: LinkContainerInfo) {
        let watchScreen = WatchScreen(posterPath: posterPath,
                                      linkContainerInfo: linkContainerInfo)
        navigationController.pushViewController(watchScreen, animated: true)
    }
    
    func gotoYoutubeScreen(_ key: String) {
        let youtubeScreen = YoutubeViewController(key: key)
        youtubeScreen.viewModel = BaseViewModel()
        navigationController.pushViewController(youtubeScreen, animated: true)
    }
}

