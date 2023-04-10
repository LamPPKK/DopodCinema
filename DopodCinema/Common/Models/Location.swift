//
//  Location.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/17.
//

import Foundation

struct MovieTheaterSearchContainerInfo: Codable {
    let results: [MovieTheaterSearchInfo]
}

struct MovieTheaterSearchInfo: Codable {
    let geometry: Geometry
    let name: String
    let vicinity: String
}

struct Geometry: Codable {
    let location: Location
}

struct Location: Codable {
    let lat, lng: Double
}

struct CinemaTimeInfo: Codable {
    let showtimes: [TimeInfo]
}

struct TimeInfo: Codable {
    let day: String
    let date: String
    let movies: [MovieCinemaInfo]
}

struct MovieCinemaInfo: Codable {
    let name: String
    let link: String
    let showing: [ShowingInfo]
}
