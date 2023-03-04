//
//  API.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/22.
//

class API {
    
    static let shared = API()
    
    // MARK: - Get movie toprated
    func getMoviesTopRated(completion: @escaping ([MovieInfo]) -> Void, error: @escaping (NetworkError) -> Void) {
        let parametters: [String: Any] = [
            "api_key": Constant.Network.API_KEY,
            "language": "en-US",
            "page": 1
        ]
        
        Network.get(URLPath.MoviesPath.GET_MOVIES_TOPRATED,
                    parameters: parametters,
                    responseType: MoviesTopRated.self,
                    completionHandler: { response in
            completion(response.results)
        }, errorHandler: error)
    }
    
    // MARK: - Get movie popular
    func getMoviesPopular(completion: @escaping ([MovieInfo]) -> Void, error: @escaping (NetworkError) -> Void) {
        let parametters: [String: Any] = [
            "api_key": Constant.Network.API_KEY,
            "language": "en-US",
            "page": 1
        ]
        
        Network.get(URLPath.MoviesPath.GET_MOVIES_POPULAR,
                    parameters: parametters,
                    responseType: MoviesPopular.self,
                    completionHandler: { response in
            completion(response.results)
        }, errorHandler: error)
    }
    
    // MARK: - Get movie now playing
    func getMoviesNowPlaying(completion: @escaping ([MovieInfo]) -> Void, error: @escaping (NetworkError) -> Void) {
        let parametters: [String: Any] = [
            "api_key": Constant.Network.API_KEY,
            "language": "en-US",
            "page": 1
        ]
        
        Network.get(URLPath.MoviesPath.GET_MOVIES_NOWPLAYING,
                    parameters: parametters,
                    responseType: MoviesNowPlaying.self,
                    completionHandler: { response in
            completion(response.results)
        }, errorHandler: error)
    }

    // MARK: - Get movie upcoming
    func getMoviesUpComing(completion: @escaping ([MovieInfo]) -> Void, error: @escaping (NetworkError) -> Void) {
        let parametters: [String: Any] = [
            "api_key": Constant.Network.API_KEY,
            "language": "en-US",
            "page": 1
        ]
        
        Network.get(URLPath.MoviesPath.GET_MOVIES_UPCOMING,
                    parameters: parametters,
                    responseType: MoviesUpComing.self,
                    completionHandler: { response in
            completion(response.results)
        }, errorHandler: error)
    }
    
    // MARK: - Get movie detail
    func getMovieDetail(with id: Int, completion: @escaping (MovieDetailInfo) -> Void, error: @escaping (NetworkError) -> Void) {
        let parametters: [String: Any] = [
            "api_key": Constant.Network.API_KEY,
            "append_to_response": "videos,credits,recommendations,reviews,images"
        ]

        Network.get(URLPath.MoviesPath.moviesPath + "/\(id)",
                    parameters: parametters,
                    responseType: MovieDetailInfo.self,
                    completionHandler: { response in
            completion(response)
        }, errorHandler: error)
    }
    
    // MARK: - Get list tv show top rate
//    func getTVShowsTopRate(completion: @escaping ([TVShowInfo]) -> Void, error: @escaping (NetworkError) -> Void) {
//
//        let parametters: [String: Any] = [
//            "api_key": Constant.Network.API_KEY,
//            "language": "en-US",
//            "page": 1
//        ]
//
//        Network.get(URLPath.TVShowPath.GET_TV_SHOW_TOPRATED,
//                    parameters: parametters,
//                    responseType: TVShowsTopRateInfo.self,
//                    completionHandler: { response in
//            completion(response.results)
//        }, errorHandler: error)
//    }
    
    // MARK: - Get list tv show popular
//    func getTVShowsPopular(completion: @escaping ([TVShowInfo]) -> Void, error: @escaping (NetworkError) -> Void) {
//
//        let parametters: [String: Any] = [
//            "api_key": Constant.Network.API_KEY,
//            "language": "en-US",
//            "page": 1
//        ]
//
//        Network.get(URLPath.TVShowPath.GET_TV_SHOW_POPULAR,
//                    parameters: parametters,
//                    responseType: TVShowsPopularInfo.self,
//                    completionHandler: { response in
//            completion(response.results)
//        }, errorHandler: error)
//    }
    
    // MARK: - Get tv detail
    /**
     - parameter id: id of tv
     - parameter language:
     - parameter api_key:
     - parameter append_to_response:
     */
//    func getTVShowDetail(withID id: Int, completion: @escaping (TVShowDetailInfo) -> Void, error: @escaping (NetworkError) -> Void) {
//        let parametters: [String: Any] = [
//            "api_key": Constant.Network.API_KEY,
//            "language": "en-US",
//            "append_to_response": "videos,credits,recommendations,images,reviews"
//        ]
//
//        Network.get(URLPath.TVShowPath.tvShowPath + "/\(id)",
//                    parameters: parametters,
//                    responseType: TVShowDetailInfo.self,
//                    completionHandler: { response in
//            completion(response)
//        }, errorHandler: error)
//    }
    
    // MARK: - Get actor detail
    func getActorDetail(with id: Int, completion: @escaping (ActorDetailInfo) -> Void, error: @escaping (NetworkError) -> Void) {
        let parametters: [String: Any] = [
            "api_key": Constant.Network.API_KEY,
            "append_to_response": "movie_credits,Cimages,tv_credits,images,recommendations"
        ]

        Network.get(URLPath.PersonPath.personPath + "/\(id)",
                    parameters: parametters,
                    responseType: ActorDetailInfo.self,
                    completionHandler: { response in
            completion(response)
        }, errorHandler: error)
    }
    
    // MARK: - Get actors
    func getActors(completion: @escaping ([ActorInfo]) -> Void, error: @escaping (NetworkError) -> Void) {
        let parametters: [String: Any] = [
            "api_key": Constant.Network.API_KEY,
            "language": "en-US",
            "page": 1
        ]

        Network.get(URLPath.PersonPath.GET_PERSONS_POPULAR,
                    parameters: parametters,
                    responseType: ActorPopular.self,
                    completionHandler: { response in
            completion(response.results)
        }, errorHandler: error)
    }
    
    // MARK: - Get list genre movie
    func getListGenreMovie(completion: @escaping ([GenreInfo]) -> Void, error: @escaping (NetworkError) -> Void) {
        let parametters: [String: Any] = [
            "api_key": Constant.Network.API_KEY,
            "language": "en-US"
        ]

        Network.get(URLPath.GenrePath.GET_LIST_GENRE_MOVIE,
                    parameters: parametters,
                    responseType: Genres.self,
                    completionHandler: { response in
            completion(response.genres)
        }, errorHandler: error)
    }
    
    // MARK: - Get list genre tv
    /**
     - parameter api_key:
     - parameter language:
     */
//    func getListGenreTV(completion: @escaping ([GenreInfo]) -> Void, error: @escaping (NetworkError) -> Void) {
//        let parametters: [String: Any] = [
//            "api_key": Constant.Network.API_KEY,
//            "language": "en-US"
//        ]
//
//        Network.get(URLPath.GenrePath.GET_LIST_GENRE_TV,
//                    parameters: parametters,
//                    responseType: Genres.self,
//                    completionHandler: { response in
//            completion(response.genres)
//        }, errorHandler: error)
//    }
    
    // MARK: - SHOW TIME
    /**
     - parameter appId:
     - parameter appKey:
     - parameter movie:
     */
//    func getShowTimes(withMovieName name: String, completion: @escaping (ShowTimesContainerInfo) -> Void, error: @escaping (NetworkError) -> Void) {
//        let parametters: [String: Any] = [
//            "appId": Constant.APP_ID,
//            "appKey": Constant.APP_KEY,
//            "movie": name
//        ]
//
//        // https://demo0481328.mockable.io/test
//        Network.get(URLPath.GET_SHOW_TIME,
//                    parameters: parametters,
//                    responseType: ShowTimesContainerInfo.self,
//                    completionHandler: { response in
//            completion(response)
//        }, errorHandler: error)
//    }
    
    // MARK: - GET MOVIE IN CURRENT POSITION RADIUS = 10km2
    
//    func getMovieTheaters(at location: Location, completion: @escaping ([MovieTheaterSearchInfo]) -> Void, error: @escaping (NetworkError) -> Void) {
//
//        let parametters: [String: Any] = [
//            "location": "\(location.lat),\(location.lng)",
//            "radius": 10000,
//            "types": "movie_theater",
//            "key": Constant.MAP_KEY
//        ]
//
//        // https://demo0481328.mockable.io/map
//        Network.get(URLPath.GET_MOVIE_THEATER,
//                    parameters: parametters,
//                    responseType: MovieTheaterSearchContainerInfo.self,
//                    completionHandler: { response in
//            completion(response.results)
//        }, errorHandler: error)
//    }
//
    // MARK: - GET SHOW TIME OF THEATER
//    func getShowTimesCinema(with name: String, completion: @escaping ([TimeInfo]) -> Void, error: @escaping (NetworkError) -> Void) {
//        let parametters: [String: Any] = [
//            "appId": Constant.APP_ID,
//            "appKey": Constant.APP_KEY,
//            "cinema": name
//        ]
//
//        Network.get(URLPath.GET_SHOW_TIME,
//                    parameters: parametters,
//                    responseType: CinemaTimeInfo.self,
//                    completionHandler: { response in
//            completion(response.showtimes)
//        }, errorHandler: error)
//    }

    // MARK: - GET LINK FULL
//    func getLinkMovie(withName name: String, completion: @escaping (LinkContainerInfo) -> Void, error: @escaping (NetworkError) -> Void) {
//        let parametters: [String: Any] = [
//            "appId": Constant.APP_ID,
//            "name": name
//        ]
//
//        Network.get(URLPath.PreviewPath.LINK_MOVIE,
//                    parameters: parametters,
//                    isEncrypte: true,
//                    responseType: LinkContainerInfo.self,
//                    completionHandler: { response in
//            completion(response)
//        }, errorHandler: error)
//    }
    
//    func getLinkTVShow(with tvShowName: String,
//                       seasonName: String,
//                       episode: Int,
//                       completion: @escaping (LinkContainerInfo) -> Void,
//                       error: @escaping (NetworkError) -> Void) {
//        
//        let parametters: [String: Any] = [
//            "appId": Constant.APP_ID,
//            "name": tvShowName + " - " + seasonName,
//            "episode": episode
//        ]
//        
//        Network.get(URLPath.PreviewPath.LINK_TV,
//                    parameters: parametters,
//                    isEncrypte: true,
//                    responseType: LinkContainerInfo.self,
//                    completionHandler: { response in
//            completion(response)
//        }, errorHandler: error)
//    }
}

