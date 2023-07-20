//
//  TrailerNavigator.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/04/08.
//

import UIKit

protocol TrailerNavigator {
    func gotoYoutubeScreen(_ key: String)
}

class DefaultTrailerNavigator: TrailerNavigator {
    // MARK: - Properties
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func gotoYoutubeScreen(_ key: String) {
        let youtubeScreen = YoutubeViewController(key: key)
        youtubeScreen.viewModel = BaseViewModel()
        navigationController.pushViewController(youtubeScreen, animated: true)
    }
}

