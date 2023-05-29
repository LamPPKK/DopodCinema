//
//  TVSeasonOverViewNavigator.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/05/29.
//

import Foundation
import UIKit

protocol TVSeasonOverViewNavigator {
    func start(_ seasonDetailInfo: SeasonDetailInfo)
    func gotoActorDetail(_ actorDetailInfo: ActorDetailInfo)
}

class DefaultTVSeasonOverViewNavigator: TVSeasonOverViewNavigator {
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(_ seasonDetailInfo: SeasonDetailInfo) {
        let seasonOverViewScreen = TVSeasonOverViewScreen(nibName: "TVSeasonOverViewScreen", bundle: nil)
        seasonOverViewScreen.viewModel = TVSeasonOverViewModel(navigator: self,
                                                               seasonDetailInfo: seasonDetailInfo)
        navigationController.pushViewController(seasonOverViewScreen, animated: true)
    }
    
    func gotoActorDetail(_ actorDetailInfo: ActorDetailInfo) {
        let navigator = DefaultActorDetailNavigator(navigationController: self.navigationController)
        navigator.start(actorDetailInfo)
    }
}
