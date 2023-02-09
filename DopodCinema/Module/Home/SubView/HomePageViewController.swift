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
    private var movieVC: MovieViewController!
    private var tvVC: TVViewController!
    private var favoriteVC: FavoriteViewController!
    private var showtimeVC: ShowTimeViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewControllers()
    }
    
    // MARK: - Private functions
    private func setupViewControllers() {
        movieVC = MovieViewController(nibName: "MovieViewController", bundle: nil)
        tvVC = TVViewController(nibName: "TVViewController", bundle: nil)
        favoriteVC = FavoriteViewController(nibName: "FavoriteViewController", bundle: nil)
        showtimeVC = ShowTimeViewController(nibName: "ShowTimeViewController", bundle: nil)
        
        setViewControllers([movieVC], direction: .forward, animated: false)
    }
    
    func moveToScreen(at index: PageVCTag) {
        var selectedVC: UIViewController!
        
        switch index {
        case .kMovie:
            selectedVC = movieVC
            
        case .kTV:
            selectedVC = tvVC
            
        case .kFavorite:
            selectedVC = favoriteVC
            
        case .kDiscovery:
            selectedVC = showtimeVC
        }
        
        setViewControllers([selectedVC], direction: .forward, animated: false)
    }
}
