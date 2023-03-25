//
//  TVListNavigator.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/25.
//

import UIKit

protocol TVListNavigator {
    func start(with title: String, list: [TVShowInfo], categories: [GenreInfo])
    func gotoTVDetail(_ tvDetailInfo: TVShowDetailInfo)
}

class DefaultTVListNavigator: TVListNavigator {
    // MARK: - Properties
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(with title: String, list: [TVShowInfo], categories: [GenreInfo]) {
        let tvListVC = TVListViewController(nibName: "TVListViewController", bundle: nil)
        tvListVC.viewModel = TVListViewModel(navigator: self,
                                             title: title,
                                             list: list,
                                             categories: categories)
        navigationController.pushViewController(tvListVC, animated: true)
    }
    
    func gotoTVDetail(_ tvDetailInfo: TVShowDetailInfo) {
        let navigator = DefaultTVDetailNavigator(navigationController: navigationController)
        navigator.start(tvDetailInfo)
    }
}
