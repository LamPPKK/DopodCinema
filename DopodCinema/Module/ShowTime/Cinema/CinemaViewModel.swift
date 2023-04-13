//
//  CinemaViewModel.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/04/10.
//

import Foundation

class CinemaViewModel {
    // MARK: - Properties
    private var moviesCinema: [MovieCinema]
    
    init(moviesCinema: [MovieCinema]) {
        self.moviesCinema = moviesCinema
    }
    
    func getMoviesCinema() -> [MovieCinema] {
        self.moviesCinema
    }
    
    func getCategories() -> [GenreInfo] {
        return UserDataDefaults.shared.getCategories().map {
            return GenreInfo(id: $0.id, name: $0.name)
        }
    }
}
