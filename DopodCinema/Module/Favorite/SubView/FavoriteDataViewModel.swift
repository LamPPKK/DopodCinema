//
//  FavoriteDataViewModel.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/22.
//

import Foundation

class FavoriteDataViewModel {
    
    private var tag: SearchPagerTag
    
    init(tag: SearchPagerTag) {
        self.tag = tag
    }
    
    func isMovie() -> Bool {
        return self.tag == .kMovie
    }
    
    func getListFavorite() -> [SavedInfo] {
        if tag == .kMovie {
            return UserDataDefaults.shared.getListMovie()
        } else {
            return UserDataDefaults.shared.getListTV()
        }
    }
}
