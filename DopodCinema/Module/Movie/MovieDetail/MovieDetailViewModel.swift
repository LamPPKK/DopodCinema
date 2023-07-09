//
//  MovieDetailViewModel.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/25.
//

import Foundation
import RxSwift
import RxCocoa

class MovieDetailViewModel: ViewModelType {
    
    // MARK: - Properties
    private var navigator: DefaultMovieDetailNavigator
    private var service: MovieServices
    private var movieDetailInfo: MovieDetailInfo
    
    init(_ navigator: DefaultMovieDetailNavigator,
         movieDetailInfo: MovieDetailInfo,
         service: MovieServices = MovieClient()) {
        self.navigator = navigator
        self.movieDetailInfo = movieDetailInfo
        self.service = service
    }
    
    func transform(input: Input) -> Output {
        let loading = ActivityIndicator()
        let error = ErrorTracker()
        
        let getDataEvent = input.loadingTrigger
            .flatMapLatest { _ in
                return Observable.just(self.movieDetailInfo)
            }
        
        let selectMovieEvent = input.selectedMovieTrigger
            .flatMapLatest { idMovie in
                self.service.getMovieDetail(idMovie)
                    .trackActivity(loading)
                    .trackError(error)
            }
            .do { movieDetailInfo in
                self.navigator.gotoMovieDetail(movieDetailInfo)
            }
            .mapToVoid()
        
        let selectedActorEvent = input.selectedActorTrigger
            .flatMapLatest { idActor in
                self.service.getActorDetail(idActor)
                    .trackActivity(loading)
                    .trackError(error)
            }
            .do { actorDetailInfo in
                self.navigator.gotoActorDetail(actorDetailInfo)
            }
            .mapToVoid()
        
        let gotoYoutubeEvent = input.gotoYoutubeTrigger
            .do { [weak self] key in
                guard let self = self else { return }
                self.navigator.gotoYoutubeScreen(key)
            }
            .mapToVoid()
        
        let gotoShowTimeEvent = input.gotoShowTimeTrigger
            .do { [weak self] _ in
                guard let self = self else { return }
                self.navigator.gotoDetailShowTime(self.movieDetailInfo)
            }
        
        let gotoTrailerEvent = input.gotoTrailerTrigger
            .do { [weak self] _ in
                guard let self = self else { return }
                self.navigator.gotoTrailerScreen(with: self.movieDetailInfo.videos.results)
            }
        
        let gotoScreenShotEvent = input.gotoScreenShotTrigger
            .do { [weak self] selectedIndex in
                guard let self = self else { return }
                self.navigator.gotoScreenShots(with: selectedIndex,
                                               images: self.movieDetailInfo.images.posters)
            }
            .mapToVoid()
        
        let saveEvent = input.saveTrigger
            .do { [weak self] _ in
                guard let self = self else { return }
                self.saveMovieToLocal()
            }
        
        let removeEvent = input.removeTrigger
            .do { [weak self] _ in
                guard let self = self else { return }
                self.remove(self.movieDetailInfo.id)
            }
        
        let playEvent = input.playTrigger
            .flatMapLatest { _ in
                self.service.getLinkMovie(self.movieDetailInfo.original_title)
                    .trackActivity(loading)
                    .trackError(error)
            }
            .do { [weak self] linkInfo in
                guard let self = self else { return }
                self.navigator.gotoWatchScreen(posterPath: self.movieDetailInfo.poster_path ?? .empty,
                                               linkContainerInfo: linkInfo)
            }
            .mapToVoid()
        
        return .init(loadingEvent: loading.asObservable(),
                     errorEvent: error.asObservable(),
                     getDataEvent: getDataEvent,
                     selectedMovieEvent: selectMovieEvent,
                     selectedActorEvent: selectedActorEvent,
                     gotoYoutubeEvent: gotoYoutubeEvent,
                     gotoShowTimeEvent: gotoShowTimeEvent,
                     gotoTrailerEvent: gotoTrailerEvent,
                     gotoScreenShotEvent: gotoScreenShotEvent,
                     saveEvent: saveEvent,
                     removeEvent: removeEvent,
                     playTrigger: playEvent)
    }
    
    func getMovieDetailInfo() -> MovieDetailInfo {
        movieDetailInfo
    }

    func isFavourite(_ id: Int) -> Bool {
        let listLocal: [SavedInfo] = UserDataDefaults.shared.getListMovie()
        let listExits = listLocal.filter { $0.id == id }
        return !listExits.isEmpty
    }
    
    // MARK: - Save movie to local
    private func saveMovieToLocal() {
        var list: [SavedInfo] = UserDataDefaults.shared.getListMovie()
        
        let movieInfo: SavedInfo = SavedInfo(id: self.movieDetailInfo.id,
                                             path: self.movieDetailInfo.poster_path ?? String.empty,
                                             name: self.movieDetailInfo.original_title)
        list.insert(movieInfo, at: 0)
        
        // Save
        UserDataDefaults.shared.setListMovie(list)
    }
    
    private func remove(_ id: Int) {
        var list: [SavedInfo] = UserDataDefaults.shared.getListMovie()
        
        var listIndex: [Int] = []
        
        for index in 0..<list.count where list[index].id == id {
            listIndex.append(index)
        }
        
        // Remove in local list
        for index in listIndex {
            list.remove(at: index)
        }
        
        // Save
        UserDataDefaults.shared.setListMovie(list)
    }
}

extension MovieDetailViewModel {
    struct Input {
        let loadingTrigger: Observable<Void>
        let selectedMovieTrigger: Observable<Int>
        let selectedActorTrigger: Observable<Int>
        let gotoYoutubeTrigger: Observable<String>
        let gotoShowTimeTrigger: Observable<Void>
        let gotoTrailerTrigger: Observable<Void>
        let gotoScreenShotTrigger: Observable<Int>
        let saveTrigger: Observable<Void>
        let removeTrigger: Observable<Void>
        let playTrigger: Observable<Void>
    }
    
    struct Output {
        let loadingEvent: Observable<Bool>
        let errorEvent: Observable<Error>
        let getDataEvent: Observable<MovieDetailInfo>
        let selectedMovieEvent: Observable<Void>
        let selectedActorEvent: Observable<Void>
        let gotoYoutubeEvent: Observable<Void>
        let gotoShowTimeEvent: Observable<Void>
        let gotoTrailerEvent: Observable<Void>
        let gotoScreenShotEvent: Observable<Void>
        let saveEvent: Observable<Void>
        let removeEvent: Observable<Void>
        let playTrigger: Observable<Void>
    }
}
