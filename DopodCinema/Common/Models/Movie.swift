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

struct MovieContainerInfo: Codable {
    let results: [MovieInfo]
}

struct MovieSearchInfo: Codable {
    let results: [MovieInfo]
}

struct MovieDetailInfo: Codable {
    let id: Int
    let backdrop_path: String?
    let poster_path: String?
    let overview: String?
    let runtime: Int
    let release_date: String
    let original_title: String
    let genres: [GenreInfo]
    let vote_average: Float
    let images: MovieImagesInfo
//    let reviews: ReviewsInfo
    let recommendations: RecommendationsInfo
    let credits: CreditsInfo
    let videos: VideosContainerInfo
}

struct MovieImagesInfo: Codable {
    let posters: [ImageInfo]
}

struct ImageInfo: Codable {
    let file_path: String?
}

struct RecommendationsInfo: Codable {
    let results: [MovieInfo]
}

struct VideosContainerInfo: Codable {
    let results: [VideoInfo]
}

struct VideoInfo: Codable {
    let id: String
    let name: String
    let key: String
    let published_at: String
}

struct CreditsInfo: Codable {
    let cast: [CastInfo]
}

struct CastInfo: Codable {
    let id: Int
    let name: String
    let profile_path: String?
}

struct LinkContainerInfo: Codable {
    let time: Int
    let data: [LinkInfo]
}

struct LinkInfo: Codable {
    let website: String
    let links: [String]
}
