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

struct PersonSearchInfo: Codable {
    let results: [ActorInfo]
}

struct ActorDetailInfo: Codable {
    let id: Int
    let name: String
    let profile_path: String?
    let gender: Int
    let birthday: String?
    let place_of_birth: String?
    let biography: String?
    let movie_credits: MovieCredits
    let tv_credits: TVCreditsInfo
    
    static func empty() -> ActorDetailInfo {
        return .init(id: 0,
                     name: .empty,
                     profile_path: nil,
                     gender: 0,
                     birthday: nil,
                     place_of_birth: nil,
                     biography: nil,
                     movie_credits: MovieCredits(cast: []),
                     tv_credits: TVCreditsInfo(cast: []))
    }
}

// MARK: - Movie Credits Info
struct MovieCredits: Codable {
    let cast: [MovieInfo]
}

// MARK: - TV Credits Info
struct TVCreditsInfo: Codable {
    let cast: [TVShowInfo]
}
