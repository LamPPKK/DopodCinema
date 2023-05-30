//
//  EpisodeOverViewModel.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/05/29.
//

import Foundation

class EpisodeOverViewModel {
    
    private var navigator: EpisodeOverViewNavigator
    private var episodeInfo: EpiscodeInfo
    
    init(navigator: EpisodeOverViewNavigator,
         episodeInfo: EpiscodeInfo) {
        self.navigator = navigator
        self.episodeInfo = episodeInfo
    }
    
    func getEpiscodeInfo() -> EpiscodeInfo {
        self.episodeInfo
    }
    
    func showActorDetailInfo(with id: Int) {
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
