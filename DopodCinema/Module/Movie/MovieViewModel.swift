//
//  MovieViewModel.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/13.
//

import RxSwift
import RxCocoa

enum MovieSectionType {
    case top(movies: [MovieInfo])
    case headerCategory(title: String)
    case category(categories: [GenreInfo])
    case headerPopular(title: String)
    case popular(movies: [MovieInfo])
    case discoverWallpaper
    case times
    case headerNew(title: String)
    case new(movies: [MovieInfo])
    case headerComing(title: String)
    case coming(movies: [MovieInfo])
    case headerActor(title: String)
    case actor(actors: [ActorInfo])
}

enum CollectionViewTag: Int {
    case trailer = 900
    case screenshots = 901
    case starting = 902
    case similarmovies = 903
    case movies = 904
    case tvShows = 905
    case category = 906
    case date = 907
    case time = 908
}

class MovieViewModel: ViewModelType {
    
    // MARK: - Properties
    private let navigator: MovieNavigator
    private let movieServices: MovieServices
    private var categories: [GenreInfo] = []
    private var moviesPopular: [MovieInfo] = []
    private var moviesToprated: [MovieInfo] = []
    private var moviesUpcoming: [MovieInfo] = []
    private var moviesNowPlaying: [MovieInfo] = []
    private var actorsPopular: [ActorInfo] = []
        
    init(navigator: MovieNavigator,
         movieServices: MovieServices) {
        self.movieServices = movieServices
        self.navigator = navigator
    }
    
    func getSections() -> [MovieSectionType] {
        var sections: [MovieSectionType] = []
        
        if !moviesNowPlaying.isEmpty {
            sections.append(.top(movies: moviesNowPlaying))
        }
        
        if !categories.isEmpty {
            sections.append(.headerCategory(title: "Category"))
            sections.append(.category(categories: categories))
        }
        
        if !moviesPopular.isEmpty {
            sections.append(.headerPopular(title: "Top Popular Movies"))
            sections.append(.popular(movies: moviesPopular))
        }
        
        sections.append(.discoverWallpaper)
        sections.append(.times)
        
        if moviesNowPlaying.count > 5 {
            sections.append(.headerNew(title: "New movies"))
            sections.append(.new(movies: moviesNowPlaying))
        }
        
        if !moviesUpcoming.isEmpty {
            sections.append(.headerComing(title: "Up coming"))
            sections.append(.coming(movies: moviesUpcoming))
        }
        
        if !actorsPopular.isEmpty {
            sections.append(.headerActor(title: "Popular people"))
            sections.append(.actor(actors: actorsPopular))
        }
        
        return sections
    }
    
    func transform(input: Input) -> Output {
        let loading = ActivityIndicator()
        
        let getMoviesTopRateTrigger = self.movieServices.getMovieTopRate(at: 1).trackActivity(loading)
        let getMoviesNowPlayingTrigger = self.movieServices.getMovieNowPlaying(at: 1).trackActivity(loading)
        let getMoviesCommingTrigger = self.movieServices.getMovieUpComing(at: 1).trackActivity(loading)
        let getMoviesPopularTrigger = self.movieServices.getMoviePopular(at: 1).trackActivity(loading)
        let getMovieCategoriesTrigger = self.movieServices.getMovieCategories().trackActivity(loading)
        let getActorsTrigger = self.movieServices.getActors(at: 1).trackActivity(loading)
        
        let getDataEvent = Observable.zip(getMoviesTopRateTrigger,
                                          getMoviesPopularTrigger,
                                          getMoviesNowPlayingTrigger,
                                          getMoviesCommingTrigger,
                                          getMovieCategoriesTrigger,
                                          getActorsTrigger)
            .map { (topRate, popular, nowPlaying, upComming, category, actor) in
                return (topRate.results,
                        popular.results,
                        nowPlaying.results,
                        upComming.results,
                        category.genres,
                        actor.results)
            }
            .do { [weak self] (moviesToprate, moviesPopular, moviesNowPlaying, moviesComming, categories, actors) in
                guard let self = self else { return }
                
                self.moviesToprated = moviesToprate
                self.moviesPopular = moviesPopular
                self.moviesNowPlaying = moviesNowPlaying
                self.moviesUpcoming = moviesComming
                self.categories = categories
                self.saveCategories(categories)
                self.actorsPopular = actors
            }
        
        let selectedMovieEvent = input.selectedMovieTrigger
            .flatMapLatest { id in
                self.movieServices.getMovieDetail(id).trackActivity(loading)
            }
            .do(onNext: { [weak self] movieDetailInfo in
                guard let self = self else { return }
                self.navigator.gotoMovieDetail(movieDetailInfo)
            })
            .mapToVoid()
        
        let selectedActorEvent = input.selectedActorTrigger
            .flatMapLatest { id in
                self.movieServices.getActorDetail(id).trackActivity(loading)
            }
            .do(onNext: { [weak self] actorDetailInfo in
                guard let self = self else { return }
                self.navigator.gotoActorDetail(actorDetailInfo)
            })
            .mapToVoid()
               
        let seeAllCategoryEvent = input.seeAllCategoryTrigger
            .do(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.navigator.gotoCategory(with: self.categories)
            })
                        
        let selectedCategoryEvent = input.selectedCategoryTrigger
            .do(onNext: { [weak self] (selectedIndex, idCategory) in
                guard let self = self else { return }
                self.navigator.gotoCategory(with: selectedIndex,
                                            categories: self.categories,
                                            id: idCategory)
            })
            .mapToVoid()
                
        let gotoMovieListEvent = input.gotoMovieListTrigger
            .do { [weak self] (title, movieType) in
                guard let self = self else { return }
                self.navigator.gotoMovieList(with: title,
                                             type: movieType,
                                             categories: self.categories)
            }
            .mapToVoid()
        
        let gotoActorListEvent = input.gotoActorListTrigger
            .do(onNext: { [weak self] title in
                guard let self = self else { return }
                self.navigator.gotoActorList(with: title,
                                             actorList: self.actorsPopular)
            })
            .mapToVoid()
                
        let gotoSearchEvent = input.gotoSearchTrigger
            .do(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.navigator.gotoSearch()
            })
        
        let gotoDiscoveryEvent = input.gotoDiscoveryWallPaperTrigger
            .do { [weak self] _ in
                guard let self = self else { return }
                self.navigator.gotoDiscoverWallpaper()
            }
                    
        return .init(loadingEvent: loading.asObservable(),
                     getDataEvent: getDataEvent,
                     gotoSearchEvent: gotoSearchEvent,
                     selectedMovieEvent: selectedMovieEvent,
                     selectedActorEvent: selectedActorEvent,
                     seeAllCategoryEvent: seeAllCategoryEvent,
                     selectedCategoryEvent: selectedCategoryEvent,
                     gotoMovieListEvent: gotoMovieListEvent,
                     gotoActorListEvent: gotoActorListEvent,
                     gotoDiscoveryWallPaperEvent: gotoDiscoveryEvent)
    }
    
    func getCategories() -> [GenreInfo] {
        categories
    }
    
    func getMoviesPopular() -> [MovieInfo] {
        self.moviesPopular
    }
    
    func getMoviesToprate() -> [MovieInfo] {
        self.moviesToprated
    }
    
    func getMoviesComing() -> [MovieInfo] {
        self.moviesUpcoming
    }
    
    func getMoviesNew() -> [MovieInfo] {
        self.moviesNowPlaying
    }
    
    func getActors() -> [ActorInfo] {
        self.actorsPopular
    }
    
    func saveCategories(_ categories: [GenreInfo]) {
        let listSaveCategory = categories.map {
            return SaveCategoryInfo(id: $0.id, name: $0.name)
        }
        
        UserDataDefaults.shared.setCategories(listSaveCategory)
    }
}

extension MovieViewModel {
    struct Input {
        let gotoSearchTrigger: Observable<Void>
        let selectedMovieTrigger: Observable<Int>
        let selectedActorTrigger: Observable<Int>
        let seeAllCategoryTrigger: Observable<Void>
        let selectedCategoryTrigger: Observable<(selectedIndex: Int, idCategory: Int)>
        let gotoMovieListTrigger: Observable<(title: String, type: MovieType)>
        let gotoActorListTrigger: Observable<String>
        let gotoDiscoveryWallPaperTrigger: Observable<Void>
    }
    
    struct Output {
        let loadingEvent: Observable<Bool>
        let getDataEvent: Observable<([MovieInfo], [MovieInfo], [MovieInfo], [MovieInfo], [GenreInfo], [ActorInfo])>
        let gotoSearchEvent: Observable<Void>
        let selectedMovieEvent: Observable<Void>
        let selectedActorEvent: Observable<Void>
        let seeAllCategoryEvent: Observable<Void>
        let selectedCategoryEvent: Observable<Void>
        let gotoMovieListEvent: Observable<Void>
        let gotoActorListEvent: Observable<Void>
        let gotoDiscoveryWallPaperEvent: Observable<Void>
    }
}
