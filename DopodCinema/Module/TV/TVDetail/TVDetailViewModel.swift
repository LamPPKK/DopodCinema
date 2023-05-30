//
//  TVDetailViewModel.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/08.
//

import Foundation
import UIKit

class TVDetailViewModel {
    
    // MARK: - Properties
    private var navigator: TVDetailNavigator
    private var tvDetailInfo: TVShowDetailInfo
    
    init(navigator: TVDetailNavigator, tvDetailInfo: TVShowDetailInfo) {
        self.navigator = navigator
        self.tvDetailInfo = tvDetailInfo
    }
    
    func getTVDetailInfo() -> TVShowDetailInfo {
        tvDetailInfo
    }
    
    // MARK: - Check exist favorite
    func isFavourite(_ id: Int) -> Bool {
        let listLocal: [SavedInfo] = UserDataDefaults.shared.getListTV()
        let listExits = listLocal.filter { $0.id == id }
        return !listExits.isEmpty
    }
    
    // MARK: - Save movie to local
    func save() {
        var list: [SavedInfo] = UserDataDefaults.shared.getListTV()
        
        let tvInfo: SavedInfo = SavedInfo(id: tvDetailInfo.id,
                                          path: tvDetailInfo.poster_path ?? String.empty,
                                          name: tvDetailInfo.original_name)
        list.insert(tvInfo, at: 0)
        
        // Save
        UserDataDefaults.shared.setListTV(list)
    }
    
    func remove(_ id: Int) {
        var list: [SavedInfo] = UserDataDefaults.shared.getListTV()
        
        var listIndex: [Int] = []
        
        for index in 0..<list.count where list[index].id == id {
            listIndex.append(index)
        }
        
        // Remove in local list
        for index in listIndex {
            list.remove(at: index)
        }
        
        // Save
        UserDataDefaults.shared.setListTV(list)
    }
    
    func gotoTrailerScreen() {
        self.navigator.gotoTrailerScreen(with: tvDetailInfo.videos.results)
    }
    
    func gotoScreenShot(at selectedIndex: Int) {
        self.navigator.gotoScreenShots(with: selectedIndex, images: tvDetailInfo.images.posters)
    }
    
    func gotoYoutubeScreen(_ key: String) {
        navigator.gotoYoutubeScreen(key)
    }
    
    func gotoActorDetail(_ id: Int) {
        LoadingView.shared.startLoading()
        
        API.shared.getActorDetail(with: id) { [weak self] actorDetailInfo in
            guard let self = self else { return }
            
            self.navigator.gotoActorDetail(actorDetailInfo)
            LoadingView.shared.endLoading()
        } error: { error in
            LoadingView.shared.endLoading()
        }
    }
    
    func gotoTVDetail(_ id: Int) {
        LoadingView.shared.startLoading()
        
        API.shared.getTVShowDetail(with: id) { [weak self] tvShowDetail in
            guard let self = self else { return }
            
            self.navigator.start(tvShowDetail)
            LoadingView.shared.endLoading()
        } error: { error in
            LoadingView.shared.endLoading()
            if let topVC = UIApplication.getTopViewController() {
                topVC.showAlert(with: "Notification", msg: "The resource you requested could not be found.")
            }
        }
    }
    
    func showFullEpisode(_ linkInfo: LinkContainerInfo) {
        navigator.gotoWatchScreen(posterPath: tvDetailInfo.poster_path ?? .empty,
                                  linkContainerInfo: linkInfo)
    }
    
    func showEpisodeOverView(_ episcodeInfo: EpiscodeInfo) {
        navigator.gotoEpisodeOverView(episcodeInfo)
    }
}
