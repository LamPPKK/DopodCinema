//
//  MovieViewModel.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/13.
//

import RxSwift
import RxCocoa

enum DataSection {
    case top
    case headerCategory
    case category
    case headerPopular
    case popular (movies: [MovieInfo])
    case times
    case headerNew
    case new
    case headerComing
    case coming (movies: [MovieInfo])
    case headerActor
    case actor (actors: [ActorInfo])
}

class MovieViewModel: NSObject {
    
    // MARK: - Properties
    private var moviesPopular: [MovieInfo] = []
    private var moviesToprated: [MovieInfo] = []
    private var moviesUpcoming: [MovieInfo] = []
    private var actorsPopular: [ActorInfo] = []
    
    func getAllData(completion: @escaping () -> Void) {
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
        
        group.notify(queue: .main) {
            completion()
        }
    }
    
    func getSections() -> [DataSection] {
        var sections: [DataSection] = []
        sections.append(.top)
        sections.append(.headerCategory)
        sections.append(.category)
        
        if !moviesPopular.isEmpty {
            sections.append(.headerPopular)
            sections.append(.popular(movies: moviesPopular))
        }
        
        sections.append(.times)
        sections.append(.headerNew)
        sections.append(.new)
        
        if !moviesUpcoming.isEmpty {
            sections.append(.headerComing)
            sections.append(.coming(movies: moviesUpcoming))
        }
        
        if !actorsPopular.isEmpty {
            sections.append(.headerActor)
            sections.append(.actor(actors: actorsPopular))
        }
        
        return sections
    }
}
