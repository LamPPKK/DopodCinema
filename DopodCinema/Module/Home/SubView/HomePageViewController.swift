//
//  HomePageViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/07.
//

import UIKit

enum PageVCTag: Int {
    case kMovie
    case kTV
    case kFavorite
    case kDiscovery
}

class HomePageViewController: UIPageViewController {

    // MARK: - Properties
    private var movieNavigationController: UINavigationController!
    private var tvNavigationController: UINavigationController!
    private var favoriteVC: FavoriteViewController!
    private var showtimeVC: ShowTimeViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewControllers()
    }
    
    // MARK: - Private functions
    private func setupViewControllers() {
        movieNavigationController = UINavigationController()
        let movieNavigator = DefaultMovieNavigator(navigationController: movieNavigationController)
        movieNavigator.start()
        
        tvNavigationController = UINavigationController()
        let tvNavigator = DefaultTVShowNavigator(navigationController: tvNavigationController)
        tvNavigator.start()
        
        favoriteVC = FavoriteViewController(nibName: "FavoriteViewController", bundle: nil)
        showtimeVC = ShowTimeViewController(nibName: "ShowTimeViewController", bundle: nil)
        showtimeVC.viewModel = ShowTimeViewModel()
        
        setViewControllers([movieNavigationController], direction: .forward, animated: false)
    }
    
    func moveToScreen(at index: PageVCTag) {
        var selectedVC: UIViewController!
        
        switch index {
        case .kMovie:
            selectedVC = movieNavigationController
            
        case .kTV:
            selectedVC = tvNavigationController
            
        case .kFavorite:
            selectedVC = favoriteVC
            
        case .kDiscovery:
            selectedVC = showtimeVC
        }
        
        setViewControllers([selectedVC], direction: .forward, animated: false)
    }
}
