//
//  MovieListViewModel.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/14.
//

import Foundation
import UIKit

enum MovieType {
    case popular
    case new
    case upcoming
}

class MovieListViewModel {
    // MARK: - Properties
    private var navigator: MovieListNavigator
    private var title: String
    private var movieList: [MovieInfo]
    private var categories: [GenreInfo]
    private var type: MovieType
    
    init(navigator: MovieListNavigator,
         title: String,
         type: MovieType,
         movieList: [MovieInfo],
         categories: [GenreInfo]) {
        self.navigator = navigator
        self.title = title
        self.movieList = movieList
        self.categories = categories
        self.type = type
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
    
    func loadMore(at pageIndex: Int, completion: @escaping (Bool) -> Void) {
        switch type {
        case .popular:
            getMoviesPopular(at: pageIndex, completion: completion)

        case .new:
            getMoviesNew(at: pageIndex, completion: completion)
            
        case .upcoming:
            getMoviesUpcoming(at: pageIndex, completion: completion)
            
        }
    }
    
    func getMoviesPopular(at page: Int, completion: @escaping (Bool) -> Void) {
        API.shared.getMoviesPopular(at: page,
                                    completion: { [weak self] movies in
            guard let self = self else {
                return
            }
            
            self.movieList.append(contentsOf: movies)
            completion(true)
        }, error: { error in
            if let topVC = UIApplication.getTopViewController() {
                topVC.showAlert(msg: error.localizedDescription)
            }
            completion(false)
        })
    }
    
    func getMoviesNew(at page: Int, completion: @escaping (Bool) -> Void) {
        API.shared.getMoviesNowPlaying(at: page,
                                    completion: { [weak self] movies in
            guard let self = self else {
                return
            }
            
            self.movieList.append(contentsOf: movies)
            completion(true)
        }, error: { error in
            if let topVC = UIApplication.getTopViewController() {
                topVC.showAlert(msg: error.localizedDescription)
            }
            completion(false)
        })
    }
    
    func getMoviesUpcoming(at page: Int, completion: @escaping (Bool) -> Void) {
        API.shared.getMoviesUpComing(at: page,
                                    completion: { [weak self] movies in
            guard let self = self else {
                return
            }
            
            self.movieList.append(contentsOf: movies)
            completion(true)
        }, error: { error in
            if let topVC = UIApplication.getTopViewController() {
                topVC.showAlert(msg: error.localizedDescription)
            }
            completion(false)
        })
    }
}
