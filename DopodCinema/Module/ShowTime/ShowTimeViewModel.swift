//
//  ShowTimeViewModel.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/17.
//

import Foundation

class ListMovieByDate {
    var date: String
    
    var day: String
    
    var movies: [MovieInfo]
    
    init(date: String,
         day: String,
         movies: [MovieInfo]) {
        self.date = date
        self.day = day
        self.movies = movies
    }
}

class ShowTimeViewModel {
    
    // MARK: - Properties
    private var theaters: [MovieTheaterSearchInfo] = []
    private var navigator: ShowTimeNavigator
    
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
            
            self.navigator.gotoCinemaScreen()
            completion(.empty)
            LoadingView.shared.endLoading()
        }, error: { error in
            completion(error.localizedDescription)
            LoadingView.shared.endLoading()
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
