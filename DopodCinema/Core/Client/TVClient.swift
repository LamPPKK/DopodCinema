//
//  TVClient.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/07/10.
//

import Foundation
import RxSwift

protocol TVServices {
    func getTVShowsTopRate(at page: Int) -> Observable<TVShowContainerInfo>
    func getTVShowsPopular(at page: Int) -> Observable<TVShowContainerInfo>
    func getTVShowOnAir(at page: Int) -> Observable<TVShowContainerInfo>
    func getTVCategories() -> Observable<Genres>
    func getActors(at page: Int) -> Observable<ActorPopular>
    func getActorDetail(_ id: Int) -> Observable<ActorDetailInfo>
    func getTVShowDetail(_ id: Int) -> Observable<TVShowDetailInfo>
}

class TVClient: TVServices {
    
    func getTVShowsTopRate(at page: Int) -> Observable<TVShowContainerInfo> {
        APIClient.request(TVRouter.topRate(page: page))
    }
    
    func getTVShowsPopular(at page: Int) -> Observable<TVShowContainerInfo> {
        APIClient.request(TVRouter.popular(page: page))
    }
    
    func getTVShowOnAir(at page: Int) -> Observable<TVShowContainerInfo> {
        APIClient.request(TVRouter.onAir(page: page))
    }
    
    func getTVCategories() -> Observable<Genres> {
        APIClient.request(TVRouter.category)
    }
    
    func getActors(at page: Int) -> Observable<ActorPopular> {
        APIClient.request(ActorRouter.actor(page: page))
    }
    
    func getActorDetail(_ id: Int) -> Observable<ActorDetailInfo> {
        APIClient.request(ActorRouter.actorDetail(id: id))
    }
    
    func getTVShowDetail(_ id: Int) -> Observable<TVShowDetailInfo> {
        APIClient.request(TVRouter.detail(id: id))
    }
}
