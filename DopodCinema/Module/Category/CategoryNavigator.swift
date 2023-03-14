//
//  CategoryNavigator.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/06.
//

import UIKit

protocol CategoryNavigator {
    func start(with categories: [GenreInfo])
    func start(with selectedIndex: Int?, categories: [GenreInfo], id: Int)
    func gotoMovieDetail(_ movieDetailInfo: MovieDetailInfo)
}

class DefaultCategoryNavigator: CategoryNavigator {
    // MARK: - Properties
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(with categories: [GenreInfo]) {
        let viewModel = CategoryViewModel(navigator: self, categories: categories, idCategory: categories.first?.id ?? 0)
        let categoryViewController = CategoryViewController(nibName: "CategoryViewController", bundle: nil)
        categoryViewController.viewModel = viewModel
        self.navigationController.pushViewController(categoryViewController, animated: true)
    }
    
    func start(with selectedIndex: Int?, categories: [GenreInfo], id: Int) {
        let viewModel = CategoryViewModel(navigator: self,
                                          categories: categories,
                                          idCategory: id)
        let categoryViewController = CategoryViewController(nibName: "CategoryViewController", bundle: nil)
        categoryViewController.viewModel = viewModel
        categoryViewController.selectedIndex = selectedIndex
        self.navigationController.pushViewController(categoryViewController, animated: true)
    }
    
    func gotoMovieDetail(_ movieDetailInfo: MovieDetailInfo) {
        let navigator = DefaultMovieDetailNavigator(navigationController: navigationController)
        navigator.start(movieDetailInfo)
    }
    
}
