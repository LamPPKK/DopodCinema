//
//  ShowTimeViewModel.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/17.
//

import Foundation

class MovieCinema {
    var id: Int
    
    var name: String?
    
    var posterPath: String?
    
    var categories: [Int]
    
    init(id: Int,
         name: String?,
         posterPath: String?,
         categories: [Int]) {
        self.id = id
        self.name = name
        self.posterPath = posterPath
        self.categories = categories
    }
}

class ShowTimeViewModel {
    
    // MARK: - Properties
    private var theaters: [MovieTheaterSearchInfo] = []
    private var navigator: ShowTimeNavigator
    private var listMovieCinema: [MovieCinema] = []
    
    init(navigator: ShowTimeNavigator) {
        self.navigator = navigator
    }
    
    func getTheaterNearbyCurrentLocation(at location: Location, completion: @escaping () -> Void) {
        LoadingView.shared.startLoading()
        
        API.shared.getMovieTheaters(at: location, completion: { [weak self] theaterInfos in
            guard let self = self else {
                return
            }
            
            self.theaters = theaterInfos
            completion()
            LoadingView.shared.endLoading()
        }, error: { _ in
            completion()
            LoadingView.shared.endLoading()
        })
    }
    
    func getTheaters() -> [MovieTheaterSearchInfo] {
        self.theaters
    }
    
    func gotoCinemaDetail(with name: String, completion: @escaping (String) -> Void) {
        LoadingView.shared.startLoading()
        
        API.shared.getShowTimesCinema(with: name,
                                      completion: { [weak self] time in
            guard let self = self else {
                return
            }
            
            
            let movies: [MovieCinemaInfo] = time.first?.movies ?? []
            self.handleListCinema(with: movies,
                                  completion: {
                self.navigator.gotoCinemaScreen(with: self.listMovieCinema)
                completion(.empty)
                LoadingView.shared.endLoading()
            })
        }, error: { error in
            completion(error.localizedDescription)
            LoadingView.shared.endLoading()
        })
    }
    
    private func handleListCinema(with movies: [MovieCinemaInfo],
                                  completion: @escaping () -> Void) {
       
        self.listMovieCinema.removeAll()
        
        let group = DispatchGroup()
        
        for movie in movies {
            group.enter()
            self.getMovie(with: movie.name,
                          completion: { [weak self] movieInfo in
                guard let self = self else { return }
                
                if let movieInfo = movieInfo {
                    let movieCinema = MovieCinema(id: movieInfo.id,
                                                  name: movieInfo.original_title,
                                                  posterPath: movieInfo.poster_path,
                                                  categories: movieInfo.genre_ids)
                    self.listMovieCinema.append(movieCinema)
                }
                
                group.leave()
            })
        }
        
        group.notify(queue: .main, execute: {
            completion()
        })
    }
    
    private func getMovie(with name: String, completion: @escaping ((MovieInfo?) -> Void)) {
        API.shared.searchMovie(with: name,
                               completion: { movies in
            completion(movies.first)
        }, error: { _ in
            completion(nil)
        })
    }
}
