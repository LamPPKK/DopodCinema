//
//  Actor.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/22.
//

struct ActorInfo: Codable {
    let id: Int
    let adult: Bool
    let gender: Int
    let name: String
    let popularity: Double
    let profile_path: String?
}

struct ActorPopular: Codable {
    let results: [ActorInfo]
}
