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
