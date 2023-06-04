//
//  ShowTimeNavigator.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/04/10.
//

import Foundation
import UIKit

protocol ShowTimeNavigator {
    func start()
    func gotoCinemaScreen(with cinemaName: String, movies: [MovieCinema])
}

class DefaultShowTimeNavigator: ShowTimeNavigator {
    // MARK: - Properties
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let showTimeViewController = ShowTimeViewController(nibName: "ShowTimeViewController", bundle: nil)
        showTimeViewController.viewModel = ShowTimeViewModel(navigator: self)
        navigationController.pushViewController(showTimeViewController, animated: true)
    }
    
    func gotoCinemaScreen(with cinemaName: String,
                          movies: [MovieCinema]) {
        let navigator = DefaultCinemaNavigator(navigationController: navigationController)
        navigator.start(with: cinemaName, movies: movies)
    }
}
