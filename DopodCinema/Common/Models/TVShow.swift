//
//  TVShow.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/04.
//

import Foundation

struct TVShowInfo: Codable {
    let id: Int
    let backdrop_path: String?
    let genre_ids: [Int]
    let name: String
    let popularity: Double
    let poster_path: String?
    let vote_average: Double
    let vote_count: Int
    let overview: String?
}

struct TVShowDetailInfo: Codable {
    let id: Int
    let backdrop_path: String?
    let poster_path: String?
    let overview: String
    let original_name: String
//    let networks: [NetworkInfo]
//    let reviews: ReviewsInfo
    let recommendations: RecommendationsInfo
    let credits: CreditsInfo
    let genres: [GenreInfo]
    let last_air_date: String
    let number_of_seasons: Int
    let images: MovieImagesInfo
//    let seasons: [SeasonInfo]
    let videos: VideosContainerInfo
    let vote_average: Float
}

struct TVShowsPopularInfo: Codable {
    let results: [TVShowInfo]
}

struct TVShowsOnAirInfo: Codable {
    let results: [TVShowInfo]
}

struct TVShowsTopRateInfo: Codable {
    let results: [TVShowInfo]
}
