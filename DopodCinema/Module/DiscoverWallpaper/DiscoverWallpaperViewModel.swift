//
//  DiscoverWallpaperViewModel.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/06/17.
//

import Foundation

enum DiscoverSectionType {
    case checkout
    case headerMovie
    case movies(wallpapers: [Wallpaper])
    case headerActor
    case actors(wallpapers: [Wallpaper])
}

class DiscoverWallpaperViewModel {
    // MARK: - Properties
    private var navigator: DiscoverWallpaperNavigator
    private var movies: [Wallpaper] = []
    private var actors: [Wallpaper] = []
    
    init(navigator: DiscoverWallpaperNavigator) {
        self.navigator = navigator
    }
    
    func getAllData(completion: @escaping () -> Void) {
        LoadingView.shared.startLoading()
        
        let group = DispatchGroup()

        // 1. Get movies wallpaper
        group.enter()
        API.shared.getWallpaper(with: .movie) { [weak self] wallpapers in
            guard let self = self else {
                return
            }
            
            self.movies = wallpapers
            group.leave()
        } error: { _ in
            group.leave()
        }

        // 2. Get actors wallpaper
        group.enter()
        API.shared.getWallpaper(with: .actor) { [weak self] wallpapers in
            guard let self = self else {
                return
            }
            
            self.actors = wallpapers
            group.leave()
        } error: { _ in
            group.leave()
        }
        
        group.notify(queue: .main) {
            LoadingView.shared.endLoading()
            completion()
        }
    }
    
    func getSections() -> [DiscoverSectionType] {
        var sections = [DiscoverSectionType]()
        
        sections.append(.checkout)
        
        if !movies.isEmpty {
            sections.append(.headerMovie)
            sections.append(.movies(wallpapers: movies))
        }
        
        if !actors.isEmpty {
            sections.append(.headerActor)
            sections.append(.actors(wallpapers: actors))
        }
        
        return sections
    }
    
    func gotoWallpaperPreview(_ url: String) {
        self.navigator.gotoWallpaperPreview(url)
    }
}
