//
//  MovieListViewModel.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/14.
//

import Foundation

class MovieListViewModel {
    // MARK: - Properties
    private var navigator: MovieListNavigator
    private var title: String
    private var movieList: [MovieInfo]
    private var categories: [GenreInfo]
    
    init(navigator: MovieListNavigator,
         title: String,
         movieList: [MovieInfo],
         categories: [GenreInfo]) {
        self.navigator = navigator
        self.title = title
        self.movieList = movieList
        self.categories = categories
    }
    
    func getNavigationTitle() -> String {
        self.title
    }
    
    func getMovieList() -> [MovieInfo] {
        self.movieList
    }
    
    func getCategories() -> [GenreInfo] {
        self.categories
    }
    
    func gotoMovieDetail(with id: Int) {
        LoadingView.shared.startLoading()
        
        API.shared.getMovieDetail(with: id) { [weak self] movieDetailInfo in
            guard let self = self else { return }
            
            self.navigator.gotoMovieDetail(movieDetailInfo)
            LoadingView.shared.endLoading()
        } error: { error in
            LoadingView.shared.endLoading()
        }
    }
}
