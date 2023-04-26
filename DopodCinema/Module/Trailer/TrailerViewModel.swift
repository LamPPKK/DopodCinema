//
//  TrailerViewModel.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/04/07.
//

import Foundation

class TrailerViewModel {
    // MARK: - Properties
    private var listTrailer: [VideoInfo]
    private var navigator: TrailerNavigator
    
    init(listTrailer: [VideoInfo],
         navigator: TrailerNavigator) {
        self.listTrailer = listTrailer
        self.navigator = navigator
    }
    
    func getListTrailer() -> [VideoInfo] {
        self.listTrailer
    }
    
    func gotoYoutubeScreen(_ key: String) {
        self.navigator.gotoYoutubeScreen(key)
    }
}
