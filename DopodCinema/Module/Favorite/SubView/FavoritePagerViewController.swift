//
//  FavoritePagerViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/22.
//

import UIKit

class FavoritePagerViewController: UIPageViewController {
    
    // MARK: - Properties
    private var movieFavVC: FavoriteDataViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
    }
    
    private func setupScreen() {
        movieFavVC = FavoriteDataViewController(nibName: "FavoriteDataViewController", bundle: nil)
        movieFavVC.viewModel = FavoriteDataViewModel()
        
        setViewControllers([movieFavVC], direction: .forward, animated: true)
    }
    
    func moveToScreen(at index: SearchPagerTag) {
        var selectedVC: UIViewController!
        
        switch index {
        case .kMovie:
            selectedVC = movieFavVC
            
        case .kTV:
            break
            
        case .kActor:
            break
        }
        
        setViewControllers([selectedVC], direction: .forward, animated: false)
    }
}
