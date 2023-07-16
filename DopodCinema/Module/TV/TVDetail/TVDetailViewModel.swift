//
//  TVDetailViewModel.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/08.
//

import Foundation
import RxSwift
import RxCocoa

class TVDetailViewModel: ViewModelType {
    
    // MARK: - Properties
    private var navigator: TVDetailNavigator
    private var tvDetailInfo: TVShowDetailInfo
    private var services: TVServices
    
    init(navigator: TVDetailNavigator,
         services: TVServices = TVClient(),
         tvDetailInfo: TVShowDetailInfo) {
        self.navigator = navigator
        self.tvDetailInfo = tvDetailInfo
        self.services = services
    }
    
    func getTVDetailInfo() -> TVShowDetailInfo {
        tvDetailInfo
    }
    
    // MARK: - Check exist favorite
    func isFavourite(_ id: Int) -> Bool {
        let listLocal: [SavedInfo] = UserDataDefaults.shared.getListTV()
        let listExits = listLocal.filter { $0.id == id }
        return !listExits.isEmpty
    }
    
    // MARK: - Save movie to local
    func save() {
        var list: [SavedInfo] = UserDataDefaults.shared.getListTV()
        
        let tvInfo: SavedInfo = SavedInfo(id: tvDetailInfo.id,
                                          path: tvDetailInfo.poster_path ?? String.empty,
                                          name: tvDetailInfo.original_name)
        list.insert(tvInfo, at: 0)
        
        // Save
        UserDataDefaults.shared.setListTV(list)
    }
    
    func remove(_ id: Int) {
        var list: [SavedInfo] = UserDataDefaults.shared.getListTV()
        
        var listIndex: [Int] = []
        
        for index in 0..<list.count where list[index].id == id {
            listIndex.append(index)
        }
        
        // Remove in local list
        for index in listIndex {
            list.remove(at: index)
        }
        
        // Save
        UserDataDefaults.shared.setListTV(list)
    }
    
    func transform(input: Input) -> Output {
        let loading = ActivityIndicator()
        let error = ErrorTracker()
        
        let gotoTrailerEvent = input.gotoTrailerTrigger
            .do { [weak self] _ in
                guard let self = self else { return }
                self.navigator.gotoTrailerScreen(with: self.tvDetailInfo.videos.results)
            }
        
        let gotoScreenShotEvent = input.gotoScreenShotTrigger
            .do { [weak self] selectedIndex in
                guard let self = self else { return }
                self.navigator.gotoScreenShots(with: selectedIndex, images: self.tvDetailInfo.images.posters)
            }
            .mapToVoid()
        
        let gotoYoutubeTrigger = input.gotoYoutubeTrigger
            .do { [weak self] key in
                guard let self = self else { return }
                self.navigator.gotoYoutubeScreen(key)
            }
            .mapToVoid()
        
        let gotoActorDetailEvent = input.gotoActorDetailTrigger
            .flatMap { idActor in
                self.services.getActorDetail(idActor)
                    .trackActivity(loading)
                    .trackError(error)
            }
            .do { [weak self] actorDetailInfo in
                guard let self = self else { return }
                self.navigator.gotoActorDetail(actorDetailInfo)
            }
            .mapToVoid()
                
        let gotoTVDetailEvent = input.gotoTVDetailTrigger
            .flatMap { idTVShow in
                self.services.getTVShowDetail(idTVShow)
                    .trackActivity(loading)
                    .trackError(error)
            }
            .do { [weak self] tvDetailInfo in
                guard let self = self else { return }
                self.navigator.start(tvDetailInfo)
            }
            .mapToVoid()
        
        let showFullEpiscodeEvent = input.showFullEpiscodeTrigger
            .do { [weak self] linkInfo in
                guard let self = self else { return }
                self.navigator.gotoWatchScreen(posterPath: self.tvDetailInfo.poster_path ?? .empty,
                                               linkContainerInfo: linkInfo)
            }
            .mapToVoid()
        
        let gotoEpisodeOverViewEvent = input.gotoEpisodeOverViewTrigger
            .do { [weak self] episcodeInfo in
                guard let self = self else { return }
                self.navigator.gotoEpisodeOverView(episcodeInfo)
            }
            .mapToVoid()
        
        return .init(loadingEvent: loading.asDriver(),
                     allErrorEvent: error.asDriver(),
                     gotoTrailerEvent: gotoTrailerEvent.asDriverOnErrorJustComplete(),
                     gotoScreenShotEvent: gotoScreenShotEvent.asDriverOnErrorJustComplete(),
                     gotoYoutubeEvent: gotoYoutubeTrigger.asDriverOnErrorJustComplete(),
                     gotoActorDetailEvent: gotoActorDetailEvent.asDriverOnErrorJustComplete(),
                     gotoTVDetailEvent: gotoTVDetailEvent.asDriverOnErrorJustComplete(),
                     showFullEpiscodeEvent: showFullEpiscodeEvent.asDriverOnErrorJustComplete(),
                     gotoEpisodeOverViewEvent: gotoEpisodeOverViewEvent.asDriverOnErrorJustComplete())
    }
}

extension TVDetailViewModel {
    struct Input {
        let gotoTrailerTrigger: Observable<Void>
        let gotoScreenShotTrigger: Observable<Int>
        let gotoYoutubeTrigger: Observable<String>
        let gotoActorDetailTrigger: Observable<Int>
        let gotoTVDetailTrigger: Observable<Int>
        let showFullEpiscodeTrigger: Observable<LinkContainerInfo>
        let gotoEpisodeOverViewTrigger: Observable<EpiscodeInfo>
    }
    
    struct Output {
        let loadingEvent: Driver<Bool>
        let allErrorEvent: Driver<Error>
        let gotoTrailerEvent: Driver<Void>
        let gotoScreenShotEvent: Driver<Void>
        let gotoYoutubeEvent: Driver<Void>
        let gotoActorDetailEvent: Driver<Void>
        let gotoTVDetailEvent: Driver<Void>
        let showFullEpiscodeEvent: Driver<Void>
        let gotoEpisodeOverViewEvent: Driver<Void>
    }
}
