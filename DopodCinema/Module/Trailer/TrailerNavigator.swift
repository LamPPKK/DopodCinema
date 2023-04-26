//
//  TrailerNavigator.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/04/08.
//

import UIKit

protocol TrailerNavigator {
    func start(with list: [VideoInfo])
    func gotoYoutubeScreen(_ key: String)
}

class DefaultTrailerNavigator: TrailerNavigator {
    // MARK: - Properties
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(with list: [VideoInfo]) {
        let trailerViewController = TrailerViewController(nibName: "TrailerViewController", bundle: nil)
        trailerViewController.viewModel = TrailerViewModel(listTrailer: list, navigator: self)
        navigationController.pushViewController(trailerViewController, animated: true)
    }
    
    func gotoYoutubeScreen(_ key: String) {
        let youtubeScreen = YoutubeViewController(key: key)
        youtubeScreen.viewModel = BaseViewModel()
        navigationController.pushViewController(youtubeScreen, animated: true)
    }
}
