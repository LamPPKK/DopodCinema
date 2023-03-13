//
//  TVDetailSeasonViewModel.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/13.
//

import Foundation

class SeasonObject {
    let id: Int
    let name: String
    let posterPath: String?
    var isSelected: Bool
    
    init(id: Int, name: String, posterPath: String?, isSelected: Bool) {
        self.id = id
        self.name = name
        self.posterPath = posterPath
        self.isSelected = isSelected
    }
}

enum SeasonSection {
    case season(seasons: [SeasonObject])
    case episcode(episcodes: [EpiscodeInfo])
}

class TVDetailSeasonViewModel {
    
    // MARK: - Properties
    private var tvDetailInfo: TVShowDetailInfo
    private var seasonsObject: [SeasonObject] = []
    private var episodes: [EpiscodeInfo] = []
    
    init(tvDetailInfo: TVShowDetailInfo) {
        self.tvDetailInfo = tvDetailInfo
        
        self.handleSeasonsObject()
    }
    
    private func handleSeasonsObject() {
        seasonsObject = self.tvDetailInfo.seasons
            .map {
                return SeasonObject(id: $0.id,
                                    name: $0.name,
                                    posterPath: $0.poster_path,
                                    isSelected: false)
            }
    }
    
    func getSection() -> [SeasonSection] {
        var sections: [SeasonSection] = []
        
        if !seasonsObject.isEmpty {
            sections.append(.season(seasons: seasonsObject))
        }
        
        if !episodes.isEmpty {
            sections.append(.episcode(episcodes: episodes))
        }
        
        return sections
    }
    
    func didSelectedCategory(with id: Int, season: String, completion: @escaping (() -> Void)) {
        for season in self.seasonsObject {
            if season.id == id {
                season.isSelected = true
            } else {
                season.isSelected = false
            }
        }
        
        getSeasonDetail(season: season, completion: completion)
    }
    
    func getSeasonDetail(season: String, completion: @escaping (() -> Void)) {
        LoadingView.shared.startLoading()
        API.shared.getSeasonDetail(with: self.tvDetailInfo.id,
                                   season: season) { [weak self] seasonDetailInfo in
            guard let self = self else {
                return
            }
            
            self.episodes = seasonDetailInfo.episodes
            completion()
            LoadingView.shared.endLoading()
        } error: { error in
            completion()
            LoadingView.shared.endLoading()
        }
    }
}