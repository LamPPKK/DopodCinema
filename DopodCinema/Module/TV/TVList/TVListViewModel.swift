//
//  TVListViewModel.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/25.
//

import UIKit
import RxSwift
import RxCocoa

enum TVShowType {
    case popular
    case onAir
    case topRate
}

class TVListViewModel: ViewModelType {
    // MARK: - Properties
    private var navigator: TVListNavigator
    private var title: String
    private var list: [TVShowInfo]
    private var categories: [GenreInfo]
    private var type: TVShowType
    private var services: TVServices
    
    init(navigator: TVListNavigator,
         title: String,
         type: TVShowType,
         list: [TVShowInfo],
         categories: [GenreInfo],
         services: TVServices = TVClient()) {
        self.navigator = navigator
        self.title = title
        self.type = type
        self.list = list
        self.categories = categories
        self.services = services
    }
    
    func getNavigationTitle() -> String {
        self.title
    }
    
    func getCategories() -> [GenreInfo] {
        self.categories
    }
    
    func transform(input: Input) -> Output {
        let loading = ActivityIndicator()
        let error = ErrorTracker()
        
        let getDataTrigger = Observable.merge(input.loadDataTrigger,
                                       input.loadMoreTrigger)
        
        let getDataEvent = getDataTrigger
            .flatMapLatest { pageIndex in
                switch self.type {
                case .popular:
                    return self.services.getTVShowsPopular(at: pageIndex)
                        .trackActivity(loading)
                        .trackError(error)
                    
                case .onAir:
                    return self.services.getTVShowOnAir(at: pageIndex)
                        .trackActivity(loading)
                        .trackError(error)
                    
                case .topRate:
                    return self.services.getTVShowsTopRate(at: pageIndex)
                        .trackActivity(loading)
                        .trackError(error)
                }
            }
            .map {
                $0.results
            }
        
        let selectedTVDetailEvent = input.selectedTVDetailTrigger
            .flatMap { idTV in
                self.services.getTVShowDetail(idTV)
                    .trackActivity(loading)
                    .trackError(error)
            }
            .do { [weak self] tvDetailInfo in
                guard let self = self else { return }
                self.navigator.gotoTVDetail(tvDetailInfo)
            }
            .mapToVoid()
        
        return .init(loadingEvent: loading.asDriver(),
                     getDataEvent: getDataEvent.asDriverOnErrorJustComplete(),
                     errorEvent: error.asDriver(),
                     selectedTVDetailEvent: selectedTVDetailEvent.asDriverOnErrorJustComplete())
    }
}

extension TVListViewModel {
    struct Input {
        let loadDataTrigger: Observable<Int>
        let loadMoreTrigger: Observable<Int>
        let selectedTVDetailTrigger: Observable<Int>
    }
    
    struct Output {
        let loadingEvent: Driver<Bool>
        let getDataEvent: Driver<[TVShowInfo]>
        let errorEvent: Driver<Error>
        let selectedTVDetailEvent: Driver<Void>
    }
}
