//
//  CategoryNavigator.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/06.
//

import UIKit

protocol CategoryNavigator {
    func start(with categories: [GenreInfo], screenType: ScreenType)
    func start(with selectedIndex: Int?, categories: [GenreInfo], id: Int, screenType: ScreenType)
    func gotoMovieDetail(_ movieDetailInfo: MovieDetailInfo)
    func gotoTVDetail(_ tvDetailInfo: TVShowDetailInfo)
}

class DefaultCategoryNavigator: CategoryNavigator {
    // MARK: - Properties
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(with categories: [GenreInfo], screenType: ScreenType) {
        let viewModel = CategoryViewModel(navigator: self,
                                          screenType: screenType,
                                          categories: categories, idCategory: categories.first?.id ?? 0)
        let categoryViewController = CategoryViewController(nibName: "CategoryViewController", bundle: nil)
        categoryViewController.viewModel = viewModel
        self.navigationController.pushViewController(categoryViewController, animated: true)
    }
    
    func start(with selectedIndex: Int?,
               categories: [GenreInfo],
               id: Int,
               screenType: ScreenType) {
        let viewModel = CategoryViewModel(navigator: self,
                                          screenType: screenType,
                                          categories: categories,
                                          idCategory: id)
        let categoryViewController = CategoryViewController(nibName: "CategoryViewController", bundle: nil)
        categoryViewController.viewModel = viewModel
        categoryViewController.selectedIndex = selectedIndex
        self.navigationController.pushViewController(categoryViewController, animated: true)
    }
    
    func gotoMovieDetail(_ movieDetailInfo: MovieDetailInfo) {
        let navigator = DefaultMovieDetailNavigator(navigationController: navigationController)
        let movieDetailVC = MovieDetailViewController(nibName: "MovieDetailViewController", bundle: nil)
        let viewModel = MovieDetailViewModel(navigator,
                                             movieDetailInfo: movieDetailInfo)
        movieDetailVC.viewModel = viewModel
        navigationController.pushViewController(movieDetailVC, animated: true)
    }
    
    func gotoTVDetail(_ tvDetailInfo: TVShowDetailInfo) {
        let navigator = DefaultTVDetailNavigator(navigationController: navigationController)
        navigator.start(tvDetailInfo)
    }
}
