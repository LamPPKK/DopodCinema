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
}

class MovieViewModel: ViewModelType {
    
    struct Input {
    }
    
    struct Output {
    }
    
    // MARK: - Properties
    private let navigator: MovieNavigator
    
    private var categories: [GenreInfo] = []
    private var moviesPopular: [MovieInfo] = []
    private var moviesToprated: [MovieInfo] = []
    private var moviesUpcoming: [MovieInfo] = []
    private var moviesNowPlaying: [MovieInfo] = []
    private var actorsPopular: [ActorInfo] = []
    
    init(navigator: MovieNavigator) {
        self.navigator = navigator
    }
    
    func getAllData(completion: @escaping () -> Void) {
        
        LoadingView.shared.startLoading()
        
        let group = DispatchGroup()
        
        // 1.
        group.enter()
        API.shared.getMoviesTopRated(completion: { [weak self] moviesToprate in
            guard let self = self else { return }
            
            self.moviesToprated = moviesToprate
            group.leave()
        }, error: { [weak self] error in
            guard let self = self else { return }
            
            group.leave()
        })
        
        // 2.
        group.enter()
        API.shared.getMoviesPopular(completion: { [weak self] moviesPopular in
            guard let self = self else { return }
            
            self.moviesPopular = moviesPopular
            group.leave()
        }, error: { [weak self] error in
            guard let self = self else { return }
            
            group.leave()
        })
        
        // 3.
        group.enter()
        API.shared.getMoviesUpComing(completion: { [weak self] moviesUpcoming in
            guard let self = self else { return }
            
            self.moviesUpcoming = moviesUpcoming
            group.leave()
        }, error: { [weak self] error in
            guard let self = self else { return }
            
            group.leave()
        })
        
        // 4.
        group.enter()
        API.shared.getActors(completion: { [weak self] actors in
            guard let self = self else { return }
            
            self.actorsPopular = actors
            group.leave()
        }, error: { [weak self] error in
            guard let self = self else { return }
            
            group.leave()
        })
        
        // 5.
        group.enter()
        API.shared.getMoviesNowPlaying(completion: { [weak self] moviesNowPlaying in
            guard  let self = self else { return }
            
            self.moviesNowPlaying = moviesNowPlaying
            group.leave()
        }, error: { [weak self] error in
            
            group.leave()
        })
        
        // 6.
        group.enter()
        API.shared.getListGenreMovie(completion: { [weak self] listGenre in
            guard let self = self else { return }
            
            self.categories = listGenre
            group.leave()
        } , error: { [weak self] error in
            
            group.leave()
        })
        
        group.notify(queue: .main) {
            LoadingView.shared.endLoading()
            completion()
        }
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
        return Output()
    }
    
    func getCategories() -> [GenreInfo] {
        categories
    }
    
    func showMovieDetailInfo(with id: Int) {
        LoadingView.shared.startLoading()
        
        API.shared.getMovieDetail(with: id) { [weak self] movieDetailInfo in
            guard let self = self else { return }
            
            self.navigator.gotoMovieDetail(movieDetailInfo)
            LoadingView.shared.endLoading()
        } error: { error in
            LoadingView.shared.endLoading()
        }
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
    
    func gotoCategory() {
        self.navigator.gotoCategory(with: categories)
    }
    
    func gotoCategory(with selectedIndex: Int, id: Int) {
        self.navigator.gotoCategory(with: selectedIndex, categories: categories, id: id)
    }
}
