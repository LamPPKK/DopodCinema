//
//  CinemaNavigator.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/04/10.
//

import Foundation
import UIKit

protocol CinemaNavigator {
    func start(with movies: [MovieCinema])
}

class DefaultCinemaNavigator: CinemaNavigator {
    // MARK: - Properties
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(with movies: [MovieCinema]) {
        let scrollCinemaVC = ScrollCinemaViewController(nibName: "ScrollCinemaViewController", bundle: nil)
        scrollCinemaVC.moviesCinema = movies
        navigationController.pushViewController(scrollCinemaVC, animated: true)
    }
}
