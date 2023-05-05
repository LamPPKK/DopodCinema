//
//  TVListViewModel.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/25.
//

import Foundation
import UIKit

enum TVShowType {
    case popular
    case onAir
    case topRate
}

class TVListViewModel {
    // MARK: - Properties
    private var navigator: TVListNavigator
    private var title: String
    private var list: [TVShowInfo]
    private var categories: [GenreInfo]
    private var type: TVShowType
    
    init(navigator: TVListNavigator,
         title: String,
         type: TVShowType,
         list: [TVShowInfo],
         categories: [GenreInfo]) {
        self.navigator = navigator
        self.title = title
        self.type = type
        self.list = list
        self.categories = categories
    }
    
    func getNavigationTitle() -> String {
        self.title
    }
    
    func getTVList() -> [TVShowInfo] {
        self.list
    }
    
    func getCategories() -> [GenreInfo] {
        self.categories
    }
    
    func gotoTVDetail(with id: Int) {
        LoadingView.shared.startLoading()
        
        API.shared.getTVShowDetail(with: id) { [weak self] tvShowDetailInfo in
            guard let self = self else { return }
            
            self.navigator.gotoTVDetail(tvShowDetailInfo)
            LoadingView.shared.endLoading()
        } error: { error in
            LoadingView.shared.endLoading()
        }
    }
    
    func loadMore(at pageIndex: Int, completion: @escaping (Bool) -> Void) {
        switch type {
        case .popular:
            getTVShowsPopular(at: pageIndex, completion: completion)
            
        case .onAir:
            getTVShowsOnAir(at: pageIndex, completion: completion)
            
        case .topRate:
            getTVShowsTopRate(at: pageIndex, completion: completion)
            
        }
    }
    
    func getTVShowsPopular(at page: Int, completion: @escaping (Bool) -> Void) {
        API.shared.getTVShowsPopular(at: page,
                                    completion: { [weak self] tvShows in
            guard let self = self else {
                return
            }
            
            self.list.append(contentsOf: tvShows)
            completion(true)
        }, error: { error in
            if let topVC = UIApplication.getTopViewController() {
                topVC.showAlert(msg: error.localizedDescription)
            }
            completion(false)
        })
    }
    
    func getTVShowsOnAir(at page: Int, completion: @escaping (Bool) -> Void) {
        API.shared.getTVShowOnAir(at: page,
                                  completion: { [weak self] tvShows in
          guard let self = self else {
              return
          }
          
          self.list.append(contentsOf: tvShows)
          completion(true)
      }, error: { error in
          if let topVC = UIApplication.getTopViewController() {
              topVC.showAlert(msg: error.localizedDescription)
          }
          completion(false)
      })
    }
    
    func getTVShowsTopRate(at page: Int, completion: @escaping (Bool) -> Void) {
        API.shared.getTVShowsTopRate(at: page,
                                     completion: { [weak self] tvShows in
             guard let self = self else {
                 return
             }
             
             self.list.append(contentsOf: tvShows)
             completion(true)
         }, error: { error in
             if let topVC = UIApplication.getTopViewController() {
                 topVC.showAlert(msg: error.localizedDescription)
             }
             completion(false)
         })
    }
}
