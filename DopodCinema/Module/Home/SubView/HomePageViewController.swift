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
    private var favNavigationController: UINavigationController!
    private var showTimeNavigationController: UINavigationController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewControllers()
    }
    
    // MARK: - Private functions
    private func setupViewControllers() {
        movieNavigationController = UINavigationController()
        let movieNavigator = DefaultMovieNavigator(navigationController: movieNavigationController)
        let movieVC = MovieViewController(nibName: "MovieViewController", bundle: nil)
        movieVC.viewModel = MovieViewModel(navigator: movieNavigator, movieServices: MovieClient())
        movieNavigationController.pushViewController(movieVC, animated: true)
        
        tvNavigationController = UINavigationController()
        let tvNavigator = DefaultTVShowNavigator(navigationController: tvNavigationController)
        let tvShowVC = TVViewController(nibName: "TVViewController", bundle: nil)
        tvShowVC.viewModel = TVViewModel(navigator: tvNavigator)
        tvNavigationController.pushViewController(tvShowVC, animated: true)
        
        favNavigationController = UINavigationController()
        let favNavigator = DefaultFavoriteNavigator(navigationController: favNavigationController)
        favNavigator.start()
        
        showTimeNavigationController = UINavigationController()
        let showTimeNavigator = DefaultShowTimeNavigator(navigationController: showTimeNavigationController)
        showTimeNavigator.start()
        
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
            selectedVC = favNavigationController
            
        case .kDiscovery:
            selectedVC = showTimeNavigationController
        }
        
        setViewControllers([selectedVC], direction: .forward, animated: false)
    }
}
