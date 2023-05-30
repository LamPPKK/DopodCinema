//
//  EpisodeOverViewNavigator.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/05/29.
//

import Foundation
import UIKit

protocol EpisodeOverViewNavigator {
    func start(_ episcodeInfo: EpiscodeInfo)
    func gotoActorDetail(_ actorDetailInfo: ActorDetailInfo)
}

class DefaultEpisodeOverViewNavigator: EpisodeOverViewNavigator {
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(_ episcodeInfo: EpiscodeInfo) {
        let episodeOverViewScreen = EpisodeOverViewScreen(nibName: "EpisodeOverViewScreen", bundle: nil)
        episodeOverViewScreen.viewModel = EpisodeOverViewModel(navigator: self,
                                                               episodeInfo: episcodeInfo)
        navigationController.pushViewController(episodeOverViewScreen, animated: true)
    }
    
    func gotoActorDetail(_ actorDetailInfo: ActorDetailInfo) {
        let navigator = DefaultActorDetailNavigator(navigationController: self.navigationController)
        navigator.start(actorDetailInfo)
    }
}
