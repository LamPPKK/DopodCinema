//
//  TVDetailViewModel.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/08.
//

import Foundation

class TVDetailViewModel {
    
    // MARK: - Properties
    private var navigation: TVDetailNavigator
    private var tvDetailInfo: TVShowDetailInfo
    
    init(navigation: TVDetailNavigator, tvDetailInfo: TVShowDetailInfo) {
        self.navigation = navigation
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
}
