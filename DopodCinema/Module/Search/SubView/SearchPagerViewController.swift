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

protocol SearchPagerViewDelegate: NSObjectProtocol {
    func didSelectedObject(id: Int, isMovie: Bool)
    func didSelectedActor(id: Int)
}

class SearchPagerViewController: UIPageViewController {

    // MARK: - Properties
    private var moviesSearchVC: SearchDataViewController!
    private var tvShowsSearchVC: SearchDataViewController!
    private var actorSearchVC: SearchActorViewController!
    
    weak var delegatePager: SearchPagerViewDelegate?
    
    private var searchObjects: [SearchObject] = []
    private var actors: [ActorInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupScreen()
    }
    
    private func setupScreen() {
        moviesSearchVC = SearchDataViewController(nibName: "SearchDataViewController", bundle: nil)
        moviesSearchVC.viewModel = SearchDataViewModel(searchObjects: self.searchObjects)
        moviesSearchVC.delegate = self

        tvShowsSearchVC = SearchDataViewController(nibName: "SearchDataViewController", bundle: nil)
        tvShowsSearchVC.delegate = self

        actorSearchVC = SearchActorViewController(nibName: "SearchActorViewController", bundle: nil)
        actorSearchVC.delegate = self
        
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

extension SearchPagerViewController: SearchDataViewDelegate, SearchActorViewDelegate {
    func didSelectedObject(id: Int, isMovie: Bool) {
        delegatePager?.didSelectedObject(id: id, isMovie: isMovie)
    }
    
    func didSelected(id: Int) {
        delegatePager?.didSelectedActor(id: id)
    }
}
