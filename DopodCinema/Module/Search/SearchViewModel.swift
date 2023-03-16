//
//  SearchViewModel.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/15.
//

import Foundation

class SearchObject {
    var id: Int
    var name: String?
    var posterPath: String?
    var overView: String?
    var isMovieObject: Bool
    
    init(id: Int,
         name: String?,
         posterPath: String?,
         overView: String?,
         isMovieObject: Bool) {
        self.id = id
        self.name = name
        self.posterPath = posterPath
        self.overView = overView
        self.isMovieObject = isMovieObject
    }
}

class SearchViewModel {
    
    // MARK: - Properties
    private var moviesSearch: [MovieInfo] = []
    private var tvShowsSearch: [TVShowInfo] = []
    private var personsSearch: [ActorInfo] = []
    
    func searchAll(_ key: String, completion: @escaping (() -> Void)) {
        LoadingView.shared.startLoading()
        
        let group = DispatchGroup()
        
        // 1. Search movie
        group.enter()
        API.shared.searchMovie(with: key,
                               completion: { [weak self] moviesSearch in
            
            self?.moviesSearch = moviesSearch
            group.leave()
        }, error: { _ in
            group.leave()
        })
        
        // 2. Search TV
        group.enter()
        API.shared.searchTVShow(with: key,
                                completion: { [weak self] tvShowsSearch in
            self?.tvShowsSearch = tvShowsSearch
            group.leave()
        }, error: { _ in
            group.leave()
        })
        
        // 3. Search person
        group.enter()
        API.shared.searchPerson(with: key,
                                completion: { [weak self] personsSearch in
            
            self?.personsSearch = personsSearch
            group.leave()
        }, error: { _ in
            group.leave()
        })
        
        group.notify(queue: .main, execute: {
            completion()
            LoadingView.shared.endLoading()
        })
    }
    
    func getSearchObjects(isMovie: Bool) -> [SearchObject] {
        if isMovie {
            return transformMovies()
        } else {
            return transformTVShows()
        }
    }
    
    func getSearchActors() -> [ActorInfo] {
        self.personsSearch
    }
    
    private func transformMovies() -> [SearchObject] {
        return self.moviesSearch
            .map {
                return SearchObject(id: $0.id,
                                    name: $0.title,
                                    posterPath: $0.poster_path,
                                    overView: $0.overview,
                                    isMovieObject: true)
            }
    }
    
    private func transformTVShows() -> [SearchObject] {
        return self.tvShowsSearch
            .map {
                return SearchObject(id: $0.id,
                                    name: $0.name,
                                    posterPath: $0.poster_path,
                                    overView: $0.overview,
                                    isMovieObject: false)
            }
    }
}
