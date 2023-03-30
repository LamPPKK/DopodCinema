//
//  ShowTimeDetailNavigator.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/18.
//

import UIKit

protocol ShowTimeDetailNavigator {
    func start(with movieDetailInfo: MovieDetailInfo)
}

class DefaultShowTimeDetailNavigator: ShowTimeDetailNavigator {
    // MARK: - Properties
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(with movieDetailInfo: MovieDetailInfo) {
        let scrollShowTimeDetailVC = ScrollShowTimeViewController(nibName: "ScrollShowTimeViewController", bundle: nil)
        scrollShowTimeDetailVC.viewModel = HeaderShowTimeViewModel(movieDetailInfo: movieDetailInfo)
        navigationController.pushViewController(scrollShowTimeDetailVC, animated: true)
    }
}
