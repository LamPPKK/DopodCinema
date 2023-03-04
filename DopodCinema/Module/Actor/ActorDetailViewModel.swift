//
//  ActorDetailViewModel.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/04.
//

import Foundation

class ActorDetailViewModel {
    // MARK: - Properties
    private var navigator: ActorDetailNavigator
    var actorDetailInfo: ActorDetailInfo
    
    init(navigator: ActorDetailNavigator, actorDetailInfo: ActorDetailInfo) {
        self.navigator = navigator
        self.actorDetailInfo = actorDetailInfo
    }
    
    func showMovieDetailInfo(with id: Int) {
        LoadingView.shared.startLoading()
        
        API.shared.getMovieDetail(with: id) { [weak self] movieDetailInfo in
            guard let self = self else { return }
            
            self.navigator.gotoMovieDetail(movieDetailInfo)
            LoadingView.shared.endLoading()
        } error: { error in
            LoadingView.shared.endLoading()
        }
    }
}
