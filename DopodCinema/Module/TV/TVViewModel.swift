//
//  TVViewModel.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/19.
//

import Foundation

enum TVSectionType {
    case top(tvshows: [TVShowInfo])
    case headerCategory(title: String)
    case category(categories: [GenreInfo])
    case headerPopular(title: String)
    case popular(tvshows: [TVShowInfo])
    case headerOnAir(title: String)
    case onAir(tvshows: [TVShowInfo])
    case headerToprate(title: String)
    case toprate(tvshows: [TVShowInfo])
    case headerActor(title: String)
    case actor(actors: [ActorInfo])
}

class TVViewModel: NSObject {
    
    // MARK: - Properties
    private var navigator: TVShowNavigator
    private var categories: [GenreInfo] = []
    private var tvShowsToprate: [TVShowInfo] = []
    private var tvShowsPopular: [TVShowInfo] = []
    private var tvShowsOnair: [TVShowInfo] = []
    private var actors: [ActorInfo] = []
    
    init(navigator: TVShowNavigator) {
        self.navigator = navigator
    }
    
    func getAllData(completion: @escaping () -> Void) {
        
        LoadingView.shared.startLoading()
        
        let group = DispatchGroup()
        
        // 1.
        group.enter()
        API.shared.getTVShowsTopRate { [weak self] tvShowsToprate in
            guard let self = self else { return }
            
            self.tvShowsToprate = tvShowsToprate
            group.leave()
        } error: { error in
            group.leave()
        }

        // 2.
        group.enter()
        API.shared.getListGenreTV { [weak self] categories in
            guard let self = self else { return }
            
            self.categories = categories
            group.leave()
        } error: { error in
            group.leave()
        }
        
        // 3.
        group.enter()
        API.shared.getTVShowsPopular { [weak self] tvShowsPopular in
            guard let self = self else { return }
            
            self.tvShowsPopular = tvShowsPopular
            group.leave()
        } error: { error in
            group.leave()
        }

        // 4.
        group.enter()
        API.shared.getTVShowOnAir { [weak self] tvShowsOnair in
            guard let self = self else { return }
            
            self.tvShowsOnair = tvShowsOnair
            group.leave()
        } error: { error in
            group.leave()
        }
        
        // 5.
        group.enter()
        API.shared.getActors(completion: { [weak self] actors in
            guard let self = self else { return }
            
            self.actors = actors
            group.leave()
        }, error: { error in
            group.leave()
        })
        
        group.notify(queue: .main) {
            LoadingView.shared.endLoading()
            completion()
        }
    }
    
    func getSections() -> [TVSectionType] {
        var sections: [TVSectionType] = []
        
        if !tvShowsOnair.isEmpty {
            sections.append(.top(tvshows: tvShowsOnair))
        }
        
        if !categories.isEmpty {
            sections.append(.headerCategory(title: "TV Show Category"))
            sections.append(.category(categories: categories))
        }
        
        if !tvShowsPopular.isEmpty {
            sections.append(.headerPopular(title: "Top Popular Shows"))
            sections.append(.popular(tvshows: tvShowsPopular))
        }
        
        if !tvShowsOnair.isEmpty {
            sections.append(.headerOnAir(title: "On Air"))
            sections.append(.onAir(tvshows: tvShowsOnair))
        }
        
        if !tvShowsToprate.isEmpty {
            sections.append(.headerToprate(title: "Top Rated Shows"))
            sections.append(.toprate(tvshows: tvShowsToprate))
        }
        
        if !actors.isEmpty {
            sections.append(.headerActor(title: "Popular people"))
            sections.append(.actor(actors: actors))
        }
        
        return sections
    }
    
    func getPopularList() -> [TVShowInfo] {
        tvShowsPopular
    }
    
    func getOnAirList() -> [TVShowInfo] {
        tvShowsOnair
    }
    
    func getToprateList() -> [TVShowInfo] {
        tvShowsToprate
    }
    
    func getCategories() -> [GenreInfo] {
        categories
    }
    
    func showActorDetail(with id: Int) {
        LoadingView.shared.startLoading()
        
        API.shared.getActorDetail(with: id) { [weak self] actorDetailInfo in
            guard let self = self else { return }
            
            self.navigator.gotoActorDetail(actorDetailInfo)
            LoadingView.shared.endLoading()
        } error: { error in
            LoadingView.shared.endLoading()
        }
    }
    
    func showTVDetail(with id: Int) {
        LoadingView.shared.startLoading()
        
        API.shared.getTVShowDetail(with: id) { [weak self] tvDetailInfo in
            guard let self = self else { return }
            
            self.navigator.gotoTVDetail(tvDetailInfo)
            LoadingView.shared.endLoading()
        } error: { error in
            LoadingView.shared.endLoading()
        }
    }
    
    func gotoSearch() {
        self.navigator.gotoSearch()
    }
    
    func gotoTVList(with title: String,
                    type: TVShowType,
                    list: [TVShowInfo],
                    categories: [GenreInfo]) {
        self.navigator.gotoTVList(with: title, type: type, list: list, categories: categories)
    }
    
    func gotoActorList(with title: String) {
        self.navigator.gotoActorList(with: title, actorList: self.actors)
    }
    
    func gotoCategory() {
        self.navigator.gotoCategory(with: categories)
    }
    
    func gotoCategory(with selectedIndex: Int, id: Int) {
        self.navigator.gotoCategory(with: selectedIndex, categories: categories, id: id)
    }
}
