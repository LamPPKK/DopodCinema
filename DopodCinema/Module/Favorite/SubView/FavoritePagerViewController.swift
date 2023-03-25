//
//  FavoritePagerViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/22.
//

import UIKit

protocol FavoritePagerViewDelegate: NSObjectProtocol {
    func didSelectedObject(id: Int, isMovie: Bool)
}

class FavoritePagerViewController: UIPageViewController {
    
    // MARK: - Properties
    private var movieFavVC: FavoriteDataViewController!
    private var tvShowFavVC: FavoriteDataViewController!
    private var actorFavVC: FavoriteActorViewController!
    
    weak var pagerDelegate: FavoritePagerViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
    }
    
    private func setupScreen() {
        movieFavVC = FavoriteDataViewController(nibName: "FavoriteDataViewController", bundle: nil)
        movieFavVC.delegate = self
        movieFavVC.viewModel = FavoriteDataViewModel(tag: .kMovie)
        
        tvShowFavVC = FavoriteDataViewController(nibName: "FavoriteDataViewController", bundle: nil)
        tvShowFavVC.delegate = self
        tvShowFavVC.viewModel = FavoriteDataViewModel(tag: .kTV)
        
        actorFavVC = FavoriteActorViewController(nibName: "FavoriteActorViewController", bundle: nil)
        actorFavVC.viewModel = FavoriteActorViewModel()
        
        setViewControllers([movieFavVC], direction: .forward, animated: true)
    }
    
    func moveToScreen(at index: SearchPagerTag) {
        var selectedVC: UIViewController!
        
        switch index {
        case .kMovie:
            selectedVC = movieFavVC
            
        case .kTV:
            selectedVC = tvShowFavVC
            
        case .kActor:
            selectedVC = actorFavVC
        }
        
        setViewControllers([selectedVC], direction: .forward, animated: false)
    }
}

extension FavoritePagerViewController: FavoriteDataViewDelegate {
    func didSelectedObject(id: Int, isMovie: Bool) {
        pagerDelegate?.didSelectedObject(id: id, isMovie: isMovie)
    }
}
