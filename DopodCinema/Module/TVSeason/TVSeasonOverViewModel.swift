//
//  TVSeasonOverViewModel.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/05/29.
//

import Foundation

class TVSeasonOverViewModel {
    
    private var navigator: TVSeasonOverViewNavigator
    private var seasonDetailInfo: SeasonDetailInfo
    
    init(navigator: TVSeasonOverViewNavigator,
         seasonDetailInfo: SeasonDetailInfo) {
        self.navigator = navigator
        self.seasonDetailInfo = seasonDetailInfo
    }
    
    func getSeasonDetailInfo() -> SeasonDetailInfo {
        self.seasonDetailInfo
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
