//
//  MovieListViewModel.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/14.
//

import Foundation
import RxSwift
import RxCocoa

enum MovieType {
    case popular
    case new
    case upcoming
}

class MovieListViewModel: ViewModelType {
    
    // MARK: - Properties
    private var service: MovieServices
    private var navigator: MovieListNavigator
    private var title: String
    private var categories: [GenreInfo]
    private var type: MovieType
        
    init(navigator: MovieListNavigator,
         service: MovieServices,
         title: String,
         type: MovieType,
         categories: [GenreInfo]) {
        self.navigator = navigator
        self.service = service
        self.title = title
        self.categories = categories
        self.type = type
    }
    
    func getNavigationTitle() -> String {
        self.title
    }
    
    func getCategories() -> [GenreInfo] {
        self.categories
    }
    
    func gotoMovieDetail(with id: Int) {
        LoadingView.shared.startLoading()
        
        API.shared.getMovieDetail(with: id) { [weak self] movieDetailInfo in
            guard let self = self else { return }
            
            self.navigator.gotoMovieDetail(movieDetailInfo)
            LoadingView.shared.endLoading()
        } error: { error in
            LoadingView.shared.endLoading()
        }
    }
    
    func transform(input: Input) -> Output {
        let loading = ActivityIndicator()
        let error = ErrorTracker()
        
        let getDataTrigger = Observable.merge(input.loadDataTrigger,
                                       input.loadMoreTrigger)
        
        let getDataEvent = getDataTrigger
            .flatMapLatest({ pageIndex in
                switch self.type {
                case .popular:
                    return self.service.getMoviePopular(at: pageIndex)
                        .trackActivity(loading)
                        .trackError(error)
                    
                case .new:
                    return self.service.getMovieNowPlaying(at: pageIndex)
                        .trackActivity(loading)
                        .trackError(error)
                    
                case .upcoming:
                    return self.service.getMovieUpComing(at: pageIndex)
                        .trackActivity(loading)
                        .trackError(error)
                }
            })
            .map {
                $0.results
            }
        
        let selectedMovieEvent = input.selectedMovieTrigger
            .flatMapLatest { idMovie in
                self.service.getMovieDetail(idMovie)
                    .trackActivity(loading)
                    .trackError(error)
            }
            .do(onNext: { [weak self] movieDetailInfo in
                guard let self = self else { return }
                self.navigator.gotoMovieDetail(movieDetailInfo)
            })
            .mapToVoid()
        
        return .init(loadingEvent: loading.asObservable(),
                     getDataEvent: getDataEvent,
                     errorEvent: error.asObservable(),
                     selectedMovieEvent: selectedMovieEvent)
    }
}

extension MovieListViewModel {
    struct Input {
        let loadDataTrigger: Observable<Int>
        let loadMoreTrigger: Observable<Int>
        let selectedMovieTrigger: Observable<Int>
    }
    
    struct Output {
        let loadingEvent: Observable<Bool>
        let getDataEvent: Observable<[MovieInfo]>
        let errorEvent: Observable<Error>
        let selectedMovieEvent: Observable<Void>
    }
}
