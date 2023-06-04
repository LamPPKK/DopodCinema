//
//  CinemaNavigator.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/04/10.
//

import Foundation
import UIKit

protocol CinemaNavigator {
    func start(with cinemaName: String, movies: [MovieCinema])
}

class DefaultCinemaNavigator: CinemaNavigator {
    // MARK: - Properties
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(with cinemaName: String,
               movies: [MovieCinema]) {
        let scrollCinemaVC = ScrollCinemaViewController(cinemaName: cinemaName,
                                                        movies: movies)
        navigationController.pushViewController(scrollCinemaVC, animated: true)
    }
}
