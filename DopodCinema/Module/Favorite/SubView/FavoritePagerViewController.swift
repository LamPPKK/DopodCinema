//
//  FavoritePagerViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/22.
//

import UIKit

protocol FavoritePagerViewDelegate: NSObjectProtocol {
    func didSelectedObject(id: Int, isMovie: Bool)
    func didSelectedActor(id: Int)
    func removeObject(_ type: SearchPagerTag, selectedObject: SavedInfo)
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
        actorFavVC.delegate = self
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
    func removeObject(type: SearchPagerTag, selectedObject: SavedInfo) {
        pagerDelegate?.removeObject(type, selectedObject: selectedObject)
    }
    
    func didSelectedObject(id: Int, isMovie: Bool) {
        pagerDelegate?.didSelectedObject(id: id, isMovie: isMovie)
    }
}

extension FavoritePagerViewController: FavoriteActorViewDelegate {
    func didSelected(id: Int) {
        pagerDelegate?.didSelectedActor(id: id)
    }
}
