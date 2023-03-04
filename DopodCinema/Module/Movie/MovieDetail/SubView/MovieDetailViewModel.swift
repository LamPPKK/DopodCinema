//
//  MovieDetailViewModel.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/25.
//

import Foundation

class MovieDetailViewModel {
    
    // MARK: - Properties
    private var navigator: DefaultMovieDetailNavigator
    var movieDetailInfo: MovieDetailInfo
    
    init(_ navigator: DefaultMovieDetailNavigator, movieDetailInfo: MovieDetailInfo) {
        self.navigator = navigator
        self.movieDetailInfo = movieDetailInfo
    }
    
    func showMovieDetail(with id: Int) {
        LoadingView.shared.startLoading()
        
        API.shared.getMovieDetail(with: id) { [weak self] movieDetailInfo in
            guard let self = self else { return }
            
            self.navigator.start(movieDetailInfo)
            LoadingView.shared.endLoading()
        } error: { error in
            LoadingView.shared.endLoading()
        }
    }
    
    func showActorDetailInfo(with id: Int) {
        LoadingView.shared.startLoading()
        
        API.shared.getActorDetail(with: id) { [weak self] actorDetailInfo in
            guard let self = self else { return }
            
            self.navigator.gotoActorDetail(actorDetailInfo)
            LoadingView.shared.endLoading()
        } error: { error in
            LoadingView.shared.endLoading()
        }
    }
}
