//
//  ActorListViewModel.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/14.
//

import Foundation

class ActorListViewModel {
    // MARK: - Properties
    private var navigator: ActorListNavigator
    private var navigationTitle: String
    private var actorList: [ActorInfo]
    
    init(navigator: ActorListNavigator,
         navigationTitle: String,
         actorList: [ActorInfo]) {
        self.navigator = navigator
        self.navigationTitle = navigationTitle
        self.actorList = actorList
    }
    
    func getNavigationTitle() -> String {
        self.navigationTitle
    }
    
    func getActorList() -> [ActorInfo] {
        self.actorList
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
