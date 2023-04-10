//
//  CinemaNavigator.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/04/10.
//

import Foundation
import UIKit

protocol CinemaNavigator {
    func start()
}

class DefaultCinemaNavigator: CinemaNavigator {
    // MARK: - Properties
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let scrollCinemaVC = ScrollCinemaViewController(nibName: "ScrollCinemaViewController", bundle: nil)
        navigationController.pushViewController(scrollCinemaVC, animated: true)
    }
}
