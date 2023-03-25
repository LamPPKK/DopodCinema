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
    
    // MARK: - Check exist favorite
    func isFavourite(_ id: Int) -> Bool {
        let listLocal: [SavedInfo] = UserDataDefaults.shared.getListActor()
        let listExits = listLocal.filter { $0.id == id }
        return !listExits.isEmpty
    }
    
    // MARK: - Save actor to local
    func save() {
        var list: [SavedInfo] = UserDataDefaults.shared.getListActor()
        
        let tvInfo: SavedInfo = SavedInfo(id: self.actorDetailInfo.id,
                                          path: self.actorDetailInfo.profile_path ?? String.empty,
                                          name: self.actorDetailInfo.name)
        list.insert(tvInfo, at: 0)
        
        // Save
        UserDataDefaults.shared.setListActor(list)
    }
    
    func remove() {
        var list: [SavedInfo] = UserDataDefaults.shared.getListActor()
        
        var listIndex: [Int] = []
        
        for index in 0..<list.count where list[index].id == self.actorDetailInfo.id {
            listIndex.append(index)
        }
        
        // Remove in local list
        for index in listIndex {
            list.remove(at: index)
        }
        
        // Save
        UserDataDefaults.shared.setListActor(list)
    }
}
