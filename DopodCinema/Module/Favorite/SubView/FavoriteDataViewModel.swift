//
//  FavoriteDataViewModel.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/22.
//

import Foundation

class FavoriteDataViewModel {
    private var listFavorite: [SavedInfo]
    
    init() {
        self.listFavorite = UserDataDefaults.shared.getListMovie()
    }
    
    func getListFavorite() -> [SavedInfo] {
        UserDataDefaults.shared.getListMovie()
    }
}
