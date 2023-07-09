//
//  MovieClient.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/07/06.
//

import Foundation
import RxSwift

protocol MovieServices {
    func getMovieTopRate(at page: Int) -> Observable<MovieContainerInfo>
    func getMovieUpComing(at page: Int) -> Observable<MovieContainerInfo>
    func getMovieNowPlaying(at page: Int) -> Observable<MovieContainerInfo>
    func getMoviePopular(at page: Int) -> Observable<MovieContainerInfo>
    func getMovieCategories() -> Observable<Genres>
    func getActors(at page: Int) -> Observable<ActorPopular>
    func getActorDetail(_ id: Int) -> Observable<ActorDetailInfo>
    func getMovieDetail(_ id: Int) -> Observable<MovieDetailInfo>
    func getLinkMovie(_ name: String) -> Observable<LinkContainerInfo>
}

class MovieClient: MovieServices {
    
    func getMovieTopRate(at page: Int) -> Observable<MovieContainerInfo> {
        movieRequest(router: .topRate(page: page))
    }
    
    func getMovieUpComing(at page: Int) -> Observable<MovieContainerInfo> {
        movieRequest(router: .comming(page: page))
    }
    
    func getMovieNowPlaying(at page: Int) -> Observable<MovieContainerInfo> {
        movieRequest(router: .nowplaying(page: page))
    }
    
    func getMoviePopular(at page: Int) -> Observable<MovieContainerInfo> {
        movieRequest(router: .popular(page: page))
    }
    
    func getMovieCategories() -> Observable<Genres> {
        movieRequest(router: .category)
    }
    
    func getActors(at page: Int) -> Observable<ActorPopular> {
        APIClient.request(ActorRouter.actor(page: page))
    }
    
    func getActorDetail(_ id: Int) -> Observable<ActorDetailInfo> {
        APIClient.request(ActorRouter.actorDetail(id: id))
    }
    
    func getMovieDetail(_ id: Int) -> Observable<MovieDetailInfo> {
        movieRequest(router: .detail(id: id))
    }
    
    func getLinkMovie(_ name: String) -> Observable<LinkContainerInfo> {
        APIClient.requestEncrypt(MovieRouter.link(name: name))
    }
    
    private func movieRequest<T: Codable>(router: MovieRouter) -> Observable<T> {
        APIClient.request(router)
    }
}
