//
//  Movie.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/22.
//

import Foundation

struct MovieInfo: Codable {
    let id: Int
    let title: String?
    let original_title: String?
    let overview: String
    let original_language: String
    let backdrop_path: String?
    let popularity: Double
    let poster_path: String?
    let vote_average: Double
    let vote_count: Int
    let adult: Bool
    let genre_ids: [Int]
}

struct MoviesNowPlaying: Codable {
    let results: [MovieInfo]
}

struct MoviesTopRated: Codable {
    let results: [MovieInfo]
}

struct MoviesPopular: Codable {
    let results: [MovieInfo]
}

struct MoviesUpComing: Codable {
    let results: [MovieInfo]
}
