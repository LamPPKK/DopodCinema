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
    
    func isFavourite(_ id: Int) -> Bool {
        let listLocal: [SavedInfo] = UserDataDefaults.shared.getListMovie()
        let listExits = listLocal.filter { $0.id == id }
        return !listExits.isEmpty
    }
    
    // MARK: - Save movie to local
    func saveMovieToLocal() {
        var list: [SavedInfo] = UserDataDefaults.shared.getListMovie()
        
        let movieInfo: SavedInfo = SavedInfo(id: self.movieDetailInfo.id,
                                             path: self.movieDetailInfo.poster_path ?? String.empty,
                                             name: self.movieDetailInfo.original_title)
        list.insert(movieInfo, at: 0)
        
        // Save
        UserDataDefaults.shared.setListMovie(list)
    }
    
    func remove(_ id: Int) {
        var list: [SavedInfo] = UserDataDefaults.shared.getListMovie()
        
        var listIndex: [Int] = []
        
        for index in 0..<list.count where list[index].id == id {
            listIndex.append(index)
        }
        
        // Remove in local list
        for index in listIndex {
            list.remove(at: index)
        }
        
        // Save
        UserDataDefaults.shared.setListMovie(list)
    }
    
    func gotoDetailShowTime() {
        self.navigator.gotoDetailShowTime(self.movieDetailInfo)
    }
    
    func gotoTrailerScreen() {
        self.navigator.gotoTrailerScreen(with: movieDetailInfo.videos.results)
    }
    
    func gotoScreenShot(at selectedIndex: Int) {
        self.navigator.gotoScreenShots(with: selectedIndex, images: movieDetailInfo.images.posters)
    }
    
    func gotoPlayScreen() {
        LoadingView.shared.startLoading()
        
        API.shared.getLinkMovie(with: self.movieDetailInfo.original_title,
                                completion: { [weak self] linkInfo in
            guard let self = self else { return }
            self.navigator.gotoWatchScreen(posterPath: self.movieDetailInfo.poster_path ?? .empty,
                                           linkContainerInfo: linkInfo)
            LoadingView.shared.endLoading()
        }, error: { _ in
            LoadingView.shared.endLoading()
        })
    }
}
