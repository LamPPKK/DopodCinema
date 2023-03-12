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
}
