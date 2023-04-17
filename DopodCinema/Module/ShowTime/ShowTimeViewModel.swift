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
    
    private var showtimes: [TimeInfo]
    
    init(id: Int,
         name: String?,
         posterPath: String?,
         categories: [Int],
         showTimes: [TimeInfo]) {
        self.id = id
        self.name = name
        self.posterPath = posterPath
        self.categories = categories
        self.showtimes = showTimes
    }
    
    func getDays() -> [TransformShowTime] {
        var listDay: [TransformShowTime] = []
        
        for showtime in showtimes {
            for movie in showtime.movies where movie.name == self.name {
                let time = TransformShowTime(day: showtime.day,
                                             date: showtime.date,
                                             isSelected: false,
                                             theaters: [])
                listDay.append(time)
            }
        }
        
        return listDay
    }
}

class ShowTimeViewModel {
    
    // MARK: - Properties
    private var theaters: [MovieTheaterSearchInfo] = []
    private var navigator: ShowTimeNavigator
    private var listMovieCinema: [MovieCinema] = []
    private var showTimes: [TimeInfo] = []
    
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
                                      completion: { [weak self] times in
            guard let self = self else {
                return
            }
            
            self.showTimes = times
            let movies: [MovieCinemaInfo] = times.first?.movies ?? []
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
                                                  categories: movieInfo.genre_ids,
                                                  showTimes: self.showTimes)
                    
                    if movieCinema.name == movie.name {
                        self.listMovieCinema.append(movieCinema)
                    }
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
