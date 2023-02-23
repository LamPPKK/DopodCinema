//
//  Genre.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/23.
//

import Foundation

struct Genres: Codable {
    let genres: [GenreInfo]
}

struct GenreInfo: Codable {
    let id: Int
    let name: String
}
