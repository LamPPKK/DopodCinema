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
    let recommendations: RecommendationsInfo
    let credits: CreditsInfo
    let genres: [GenreInfo]
    let last_air_date: String
    let number_of_seasons: Int
    let images: MovieImagesInfo
    let seasons: [SeasonInfo]
    let videos: VideosContainerInfo
    let vote_average: Float
}

// MARK: - Seasons Info
struct SeasonInfo: Codable {
    let id: Int
    let episode_count: Int
    let name: String
    let overview: String
    let poster_path: String?
    let season_number: Int
}

struct SeasonDetailInfo: Codable {
    let id: Int
    let air_date: String?
    let name: String
    let overview: String
    let poster_path: String?
    let episodes: [EpiscodeInfo]
    let credits: CreditsInfo
}

// MARK: - Episcode Info
struct EpiscodeInfo: Codable {
    let id: Int
    let episode_number: Int
    let name: String
    let overview: String
    let still_path: String?
    let air_date: String?
    let runtime: Int?
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

struct TVSearchInfo: Codable {
    let results: [TVShowInfo]
}

struct TVGenreInfo: Codable {
    let results: [TVShowInfo]
}
