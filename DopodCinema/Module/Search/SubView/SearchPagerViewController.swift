//
//  SearchPagerViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/15.
//

import UIKit

enum SearchPagerTag {
    case kMovie
    case kTV
    case kActor
}

class SearchPagerViewController: UIPageViewController {

    // MARK: - Properties
    private var moviesSearchVC: SearchDataViewController!
    private var tvShowsSearchVC: SearchDataViewController!
    private var actorSearchVC: SearchActorViewController!
    
    private var searchObjects: [SearchObject] = []
    private var actors: [ActorInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupScreen()
    }
    
    private func setupScreen() {
        moviesSearchVC = SearchDataViewController(nibName: "SearchDataViewController", bundle: nil)
        moviesSearchVC.viewModel = SearchDataViewModel(searchObjects: self.searchObjects)
        
        tvShowsSearchVC = SearchDataViewController(nibName: "SearchDataViewController", bundle: nil)

        actorSearchVC = SearchActorViewController(nibName: "SearchActorViewController", bundle: nil)
        
        setViewControllers([moviesSearchVC], direction: .forward, animated: true)
    }
    
    func setupData(with searchObjects: [SearchObject] = [],
                   actors: [ActorInfo] = []) {
        self.searchObjects = searchObjects
        self.actors = actors
    }
    
    func moveToScreen(at index: SearchPagerTag) {
        var selectedVC: UIViewController!
        
        switch index {
        case .kMovie:
            moviesSearchVC.viewModel = SearchDataViewModel(searchObjects: self.searchObjects)
            selectedVC = moviesSearchVC
            
        case .kTV:
            tvShowsSearchVC.viewModel = SearchDataViewModel(searchObjects: self.searchObjects)
            selectedVC = tvShowsSearchVC
            
        case .kActor:
            actorSearchVC.viewModel = SearchActorViewModel(actorsSearch: self.actors)
            selectedVC = actorSearchVC
        }
        
        setViewControllers([selectedVC], direction: .forward, animated: false)
    }
}
