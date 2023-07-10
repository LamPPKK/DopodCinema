//
//  TVViewModel.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/19.
//

import Foundation
import RxSwift
import RxCocoa

enum TVSectionType {
    case top(tvshows: [TVShowInfo])
    case headerCategory(title: String)
    case category(categories: [GenreInfo])
    case headerPopular(title: String)
    case popular(tvshows: [TVShowInfo])
    case discoverWallpaper
    case headerOnAir(title: String)
    case onAir(tvshows: [TVShowInfo])
    case headerToprate(title: String)
    case toprate(tvshows: [TVShowInfo])
    case headerActor(title: String)
    case actor(actors: [ActorInfo])
}

class TVViewModel: ViewModelType {
    
    // MARK: - Properties
    private var navigator: TVShowNavigator
    private var services: TVServices
    private var categories: [GenreInfo] = []
    private var tvShowsToprate: [TVShowInfo] = []
    private var tvShowsPopular: [TVShowInfo] = []
    private var tvShowsOnair: [TVShowInfo] = []
    private var actors: [ActorInfo] = []
    
    init(navigator: TVShowNavigator,
         services: TVServices = TVClient()) {
        self.navigator = navigator
        self.services = services
    }
    
    func transform(input: Input) -> Output {
        let loading = ActivityIndicator()
        let error = ErrorTracker()
        
        let getTVOnAirTrigger = services.getTVShowOnAir(at: 1).trackActivity(loading).asDriverOnErrorJustComplete()
        let getTVPopularTrigger = services.getTVShowsPopular(at: 1).trackActivity(loading).asDriverOnErrorJustComplete()
        let getTVTopRateTrigger = services.getTVShowsTopRate(at: 1).trackActivity(loading).asDriverOnErrorJustComplete()
        let getTVCategorisTrigger = services.getTVCategories().trackActivity(loading).asDriverOnErrorJustComplete()
        let getActorsTrigger = services.getActors(at: 1).trackActivity(loading).asDriverOnErrorJustComplete()

        let getDataEvent = Driver.zip(getTVOnAirTrigger,
                                      getTVPopularTrigger,
                                      getTVTopRateTrigger,
                                      getTVCategorisTrigger,
                                      getActorsTrigger)
            .map { (onAirInfo, popularInfo, toprateInfo, categoryInfo, actorInfo) in
                return (onAirInfo.results,
                        popularInfo.results,
                        toprateInfo.results,
                        categoryInfo.genres,
                        actorInfo.results)
            }
            .do { [weak self] (tvsOnAir, tvsPopular, tvsToprate, categories, actors) in
                guard let self = self else { return }
                self.tvShowsOnair = tvsOnAir
                self.tvShowsPopular = tvsPopular
                self.tvShowsToprate = tvsToprate
                self.categories = categories
                self.actors = actors
            }
            .mapToVoid()
        
        let selectedActorEvent = input.selectedActorTrigger
            .flatMapLatest { idActor in
                self.services.getActorDetail(idActor)
                    .trackActivity(loading)
                    .trackError(error)
            }
            .do { [weak self] actorDetailInfo in
                guard let self = self else { return }
                self.navigator.gotoActorDetail(actorDetailInfo)
            }
            .mapToVoid()
        
        let selectedTVShowEvent = input.selectedTVShowTrigger
            .flatMapLatest { idTV in
                self.services.getTVShowDetail(idTV)
                    .trackActivity(loading)
                    .trackError(error)
            }
            .do { [weak self] tvShowDetailInfo in
                guard let self = self else { return }
                self.navigator.gotoTVDetail(tvShowDetailInfo)
            }
            .mapToVoid()
        
        let gotoSearchEvent = input.gotoSearchTrigger
            .do { [weak self] _ in
                guard let self = self else { return }
                self.navigator.gotoSearch()
            }
        
        let gotoDiscoveryEvent = input.gotoDiscoveryWallPaperTrigger
            .do { [weak self] _ in
                guard let self = self else { return }
                self.navigator.gotoDiscoverWallpaper()
            }
        
        let gotoCategoryEvent = input.gotoCategoryTrigger
            .do { [weak self] _ in
                guard let self = self else { return }
                self.navigator.gotoCategory(with: self.categories)
            }
        
        let selectedCategoryEvent = input.selectedCategoryTrigger
            .do { [weak self] (selectedIndex, categoryID) in
                guard let self = self else { return }
                self.navigator.gotoCategory(with: selectedIndex,
                                            categories: self.categories,
                                            id: categoryID)
            }
            .mapToVoid()
        
        let gotoTVListEvent = input.gotoTVListTrigger
            .do { [weak self] (title, type, tvShows) in
                guard let self = self else { return }
                self.navigator.gotoTVList(with: title,
                                          type: type,
                                          list: tvShows,
                                          categories: self.categories)
            }
            .mapToVoid()
        
        let gotoActorListEvent = input.gotoActorListTrigger
            .do { [weak self] title in
                guard let self = self else { return }
                self.navigator.gotoActorList(with: title,
                                             actorList: self.actors)
            }
            .mapToVoid()
        
        return .init(getDataEvent: getDataEvent.asDriver(),
                     loadingEvent: loading.asDriver(),
                     errorEvent: error.asDriver(),
                     selectedActorEvent: selectedActorEvent.asDriverOnErrorJustComplete(),
                     selectedTVShowEvent: selectedTVShowEvent.asDriverOnErrorJustComplete(),
                     gotoSearchEvent: gotoSearchEvent.asDriverOnErrorJustComplete(),
                     gotoDiscoveryWallPaperEvent: gotoDiscoveryEvent.asDriverOnErrorJustComplete(),
                     gotoCategoryEvent: gotoCategoryEvent.asDriverOnErrorJustComplete(),
                     selectedCategoryEvent: selectedCategoryEvent.asDriverOnErrorJustComplete(),
                     gotoTVListEvent: gotoTVListEvent.asDriverOnErrorJustComplete(),
                     gotoActorListEvent: gotoActorListEvent.asDriverOnErrorJustComplete())
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
        
        sections.append(.discoverWallpaper)
        
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
}

extension TVViewModel {
    struct Input {
        let selectedActorTrigger: Observable<Int>
        let selectedTVShowTrigger: Observable<Int>
        let gotoSearchTrigger: Observable<Void>
        let gotoDiscoveryWallPaperTrigger: Observable<Void>
        let gotoCategoryTrigger: Observable<Void>
        let selectedCategoryTrigger: Observable<(selectedIndex: Int, categoryID: Int)>
        let gotoTVListTrigger: Observable<(title: String, type: TVShowType, tvShows: [TVShowInfo])>
        let gotoActorListTrigger: Observable<String>
    }
    
    struct Output {
        let getDataEvent: Driver<Void>
        let loadingEvent: Driver<Bool>
        let errorEvent: Driver<Error>
        let selectedActorEvent: Driver<Void>
        let selectedTVShowEvent: Driver<Void>
        let gotoSearchEvent: Driver<Void>
        let gotoDiscoveryWallPaperEvent: Driver<Void>
        let gotoCategoryEvent: Driver<Void>
        let selectedCategoryEvent: Driver<Void>
        let gotoTVListEvent: Driver<Void>
        let gotoActorListEvent: Driver<Void>
    }
}
