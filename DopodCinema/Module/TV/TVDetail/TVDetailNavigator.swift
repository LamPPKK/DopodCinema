//
//  TVDetailNavigator.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/08.
//

import UIKit

protocol TVDetailNavigator {
    func start(_ tvDetailInfo: TVShowDetailInfo)
    func gotoActorDetail(_ actorDetailInfo: ActorDetailInfo)
    func gotoTrailerScreen(with list: [VideoInfo])
    func gotoScreenShots(with selectedIndex: Int, images: [ImageInfo])
    func gotoYoutubeScreen(_ key: String)
    func gotoWatchScreen(posterPath: String, linkContainerInfo: LinkContainerInfo)
    func gotoEpisodeOverView(_ episcodeInfo: EpiscodeInfo)
}

class DefaultTVDetailNavigator: TVDetailNavigator {
    
    // MARK: - Properties
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(_ tvDetailInfo: TVShowDetailInfo) {
        let viewModel = TVDetailViewModel(navigator: self, tvDetailInfo: tvDetailInfo)
        let scrollTVDetailVC = ScrollTVDetailViewController(nibName: "ScrollTVDetailViewController", bundle: nil)
        scrollTVDetailVC.viewModel = viewModel
        navigationController.pushViewController(scrollTVDetailVC, animated: true)
    }
    
    func gotoActorDetail(_ actorDetailInfo: ActorDetailInfo) {
        let navigator = DefaultActorDetailNavigator(navigationController: self.navigationController)
        navigator.start(actorDetailInfo)
    }
    
    func gotoTrailerScreen(with list: [VideoInfo]) {
        let navigator = DefaultTrailerNavigator(navigationController: self.navigationController)
        navigator.start(with: list)
    }
    
    func gotoScreenShots(with selectedIndex: Int, images: [ImageInfo]) {
        let imageDetailViewController = ImageDetailScreen(selectedIndex: selectedIndex, images: images)
        navigationController.pushViewController(imageDetailViewController, animated: true)
    }
    
    func gotoYoutubeScreen(_ key: String) {
        let youtubeScreen = YoutubeViewController(key: key)
        youtubeScreen.viewModel = BaseViewModel()
        navigationController.pushViewController(youtubeScreen, animated: true)
    }
    
    func gotoWatchScreen(posterPath: String, linkContainerInfo: LinkContainerInfo) {
        let watchScreen = WatchScreen(posterPath: posterPath,
                                      linkContainerInfo: linkContainerInfo)
        navigationController.pushViewController(watchScreen, animated: true)
    }
    
    func gotoEpisodeOverView(_ episcodeInfo: EpiscodeInfo) {
        let navigator = DefaultEpisodeOverViewNavigator(navigationController: navigationController)
        navigator.start(episcodeInfo)
    }
}
