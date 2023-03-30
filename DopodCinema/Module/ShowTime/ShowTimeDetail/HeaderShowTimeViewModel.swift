//
//  HeaderShowTimeViewModel.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/18.
//

import Foundation

class HeaderShowTimeViewModel {
    // MARK: - Properties
    private var movieDetailInfo: MovieDetailInfo
    
    init(movieDetailInfo: MovieDetailInfo) {
        self.movieDetailInfo = movieDetailInfo
    }
    
    func getMovieDetailInfo() -> MovieDetailInfo {
        self.movieDetailInfo
    }
}
