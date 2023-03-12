//
//  TVDetailNavigator.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/08.
//

import UIKit

protocol TVDetailNavigator {
    func start(_ tvDetailInfo: TVShowDetailInfo)
}

class DefaultTVDetailNavigator: TVDetailNavigator {
    
    // MARK: - Properties
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(_ tvDetailInfo: TVShowDetailInfo) {
        let viewModel = TVDetailViewModel(navigation: self,
                                                       tvDetailInfo: tvDetailInfo)
        let scrollTVDetailVC = ScrollTVDetailViewController(nibName: "ScrollTVDetailViewController", bundle: nil)
        scrollTVDetailVC.viewModel = viewModel
        navigationController.pushViewController(scrollTVDetailVC, animated: true)
    }
}
