//
//  FavoriteViewModel.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/22.
//

import Foundation

class FavoriteViewModel {
    
    // MARK: - Properties
    private var navigator: FavoriteNavigator
    
    init(navigator: FavoriteNavigator) {
        self.navigator = navigator
    }
    
    func gotoMovieDetail(with id: Int) {
        LoadingView.shared.startLoading()
        
        API.shared.getMovieDetail(with: id) { [weak self] movieDetailInfo in
            guard let self = self else { return }
            
            self.navigator.gotoMovieDetail(movieDetailInfo)
            LoadingView.shared.endLoading()
        } error: { error in
            LoadingView.shared.endLoading()
        }
    }
    
    func gotoTVDetail(with id: Int) {
        LoadingView.shared.startLoading()
        
        API.shared.getTVShowDetail(with: id) { [weak self] tvDetailInfo in
            guard let self = self else { return }
            
            self.navigator.gotoTVDetail(tvDetailInfo)
            LoadingView.shared.endLoading()
        } error: { error in
            LoadingView.shared.endLoading()
        }
    }
    
    func gotoActorDetail(with id: Int) {
        LoadingView.shared.startLoading()
        
        API.shared.getActorDetail(with: id) { [weak self] actorDetailInfo in
            guard let self = self else { return }
            
            self.navigator.gotoActorDetail(actorDetailInfo)
            LoadingView.shared.endLoading()
        } error: { error in
            LoadingView.shared.endLoading()
        }
    }
}
