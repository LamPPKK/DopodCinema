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
    
    init(listTrailer: [VideoInfo]) {
        self.listTrailer = listTrailer
    }
    
    func getListTrailer() -> [VideoInfo] {
        self.listTrailer
    }
}
