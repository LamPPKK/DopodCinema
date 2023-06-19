//
//  WallPaper.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/06/19.
//

import Foundation

struct WallpaperInfo: Codable {
    let wallpapers: [Wallpaper]
}

// MARK: - Wallpaper
struct Wallpaper: Codable {
    let id: Int
    let url_image: String
    let url_thumb: String
}
