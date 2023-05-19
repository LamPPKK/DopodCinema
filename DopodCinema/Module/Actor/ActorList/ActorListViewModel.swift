//
//  ActorListViewModel.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/14.
//

import Foundation
import UIKit

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
    
    func getActors(at page: Int, completion: @escaping (Bool) -> Void) {
        API.shared.getActors(at: page) { [weak self] actors in
            guard let self = self else {
                return
            }
            
            self.actorList.append(contentsOf: actors)
            completion(true)
        } error: { error in
            if let topVC = UIApplication.getTopViewController() {
                topVC.showAlert(msg: error.localizedDescription)
            }
            completion(false)
        }
    }
}
