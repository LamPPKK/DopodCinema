//
//  SearchNavigator.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/15.
//

import UIKit

protocol SearchNavigator {
    func start()
}

class DefaultSearchNavigator: SearchNavigator {
    // MARK: - Properties
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let searchVC = SearchViewController(nibName: "SearchViewController", bundle: nil)
        searchVC.viewModel = SearchViewModel()
        navigationController.pushViewController(searchVC, animated: true)
    }
}
