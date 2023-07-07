//
//  API.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/22.
//

class API {
    
    static let shared = API()
    
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
    
    // MARK: - Get movie by Category ID
    func getMovies(at page: Int = 1,
                   categoryId: Int,
                   completion: @escaping ([MovieInfo]) -> Void,
                   error: @escaping (NetworkError) -> Void) {
        let parametters: [String: Any] = [
            "api_key": Constant.Network.API_KEY,
            "language": "en-US",
            "with_genres": categoryId,
            "page": page
        ]
        
        Network.get(URLPath.GET_MOVIES_BY_GENRE_ID,
                    parameters: parametters,
                    responseType: MovieContainerInfo.self,
                    completionHandler: { response in
            completion(response.results)
        }, errorHandler: error)
    }
    
    // MARK: - Get list tv show top rate
    func getTVShowsTopRate(at page: Int = 1,
                           completion: @escaping ([TVShowInfo]) -> Void,
                           error: @escaping (NetworkError) -> Void) {

        let parametters: [String: Any] = [
            "api_key": Constant.Network.API_KEY,
            "language": "en-US",
            "page": page
        ]

        Network.get(URLPath.TVShowPath.GET_TV_SHOW_TOPRATED,
                    parameters: parametters,
                    responseType: TVShowsTopRateInfo.self,
                    completionHandler: { response in
            completion(response.results)
        }, errorHandler: error)
    }
    
    // MARK: - Get list tv show popular
    func getTVShowsPopular(at page: Int = 1,
                           completion: @escaping ([TVShowInfo]) -> Void,
                           error: @escaping (NetworkError) -> Void) {

        let parametters: [String: Any] = [
            "api_key": Constant.Network.API_KEY,
            "language": "en-US",
            "page": page
        ]

        Network.get(URLPath.TVShowPath.GET_TV_SHOW_POPULAR,
                    parameters: parametters,
                    responseType: TVShowsPopularInfo.self,
                    completionHandler: { response in
            completion(response.results)
        }, errorHandler: error)
    }
    
    // MARK: - Get list tv show on the air
    func getTVShowOnAir(at page: Int = 1,
                        completion: @escaping ([TVShowInfo]) -> Void,
                        error: @escaping (NetworkError) -> Void) {
        
        let parametters: [String: Any] = [
            "api_key": Constant.Network.API_KEY,
            "language": "en-US",
            "page": page
        ]
        
        Network.get(URLPath.TVShowPath.GET_TV_SHOW_ON_AIR,
                    parameters: parametters,
                    responseType: TVShowsOnAirInfo.self,
                    completionHandler: { response in
            completion(response.results)
        }, errorHandler: error)
    }
    
    // MARK: - Get tv detail
    func getTVShowDetail(with id: Int, completion: @escaping (TVShowDetailInfo) -> Void, error: @escaping (NetworkError) -> Void) {
        let parametters: [String: Any] = [
            "api_key": Constant.Network.API_KEY,
            "language": "en-US",
            "append_to_response": "videos,credits,recommendations,images,reviews"
        ]

        Network.get(URLPath.TVShowPath.tvShowPath + "/\(id)",
                    parameters: parametters,
                    responseType: TVShowDetailInfo.self,
                    completionHandler: { response in
            completion(response)
        }, errorHandler: error)
    }
    
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
    func getActors(at page: Int = 1,
                   completion: @escaping ([ActorInfo]) -> Void,
                   error: @escaping (NetworkError) -> Void) {
        let parametters: [String: Any] = [
            "api_key": Constant.Network.API_KEY,
            "language": "en-US",
            "page": page
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
    func getListGenreTV(completion: @escaping ([GenreInfo]) -> Void, error: @escaping (NetworkError) -> Void) {
        let parametters: [String: Any] = [
            "api_key": Constant.Network.API_KEY,
            "language": "en-US"
        ]

        Network.get(URLPath.GenrePath.GET_LIST_GENRE_TV,
                    parameters: parametters,
                    responseType: Genres.self,
                    completionHandler: { response in
            completion(response.genres)
        }, errorHandler: error)
    }
    
    func getTVShow(at page: Int = 1,
                   categoryId: Int,
                   completion: @escaping ([TVShowInfo]) -> Void,
                   error: @escaping (NetworkError) -> Void) {
        let parametters: [String: Any] = [
            "api_key": Constant.Network.API_KEY,
            "language": "en-US",
            "with_genres": categoryId,
            "page": page
        ]
        
        Network.get(URLPath.GET_TV_BY_GENRE_ID,
                    parameters: parametters,
                    responseType: TVGenreInfo.self,
                    completionHandler: { response in
            completion(response.results)
        }, errorHandler: error)
    }
    
    func getSeasonDetail(with id: Int, season: String, completion: @escaping (SeasonDetailInfo) -> Void, error: @escaping (NetworkError) -> Void) {
        let parametters: [String: Any] = [
            "api_key": Constant.Network.API_KEY,
            "language": "en-US",
            "append_to_response": "videos,credits,recommendations,images,reviews"
        ]
        
        var seasonValue: String = .empty
        if season.lowercased().contains("season") {
            let values = season.lowercased().components(separatedBy: "season ")
            if values.count > 1 {
                seasonValue = values[1]
            }
        } else {
            seasonValue = season
        }
        
        Network.get(URLPath.TVShowPath.tvShowPath + "/\(id)/season/\(seasonValue)",
                    parameters: parametters,
                    responseType: SeasonDetailInfo.self,
                    completionHandler: { response in
            completion(response)
        }, errorHandler: error)
    }
    
    // MARK: - SEARCH MOVIE
    func searchMovie(with query: String, completion: @escaping ([MovieInfo]) -> Void, error: @escaping (NetworkError) -> Void) {
        let parameters: [String: Any] = [
            "api_key": Constant.Network.API_KEY,
            "language": "en-US",
            "page": 1,
            "query": query
        ]
        
        Network.get(URLPath.SearchPath.SEARCH_MOVIE,
                    parameters: parameters,
                    responseType: MovieSearchInfo.self,
                    completionHandler: { response in
            completion(response.results)
        }, errorHandler: error)
    }
    
    // MARK: - SEARCH TV SHOW
    func searchTVShow(with query: String, completion: @escaping ([TVShowInfo]) -> Void, error: @escaping (NetworkError) -> Void) {
        let parameters: [String: Any] = [
            "api_key": Constant.Network.API_KEY,
            "language": "en-US",
            "page": 1,
            "query": query
        ]
        
        Network.get(URLPath.SearchPath.SEARCH_TVSHOW,
                    parameters: parameters,
                    responseType: TVSearchInfo.self,
                    completionHandler: { response in
            completion(response.results)
        }, errorHandler: error)
    }
    
    // MARK: - SEARCH PERSON
    func searchPerson(with query: String, completion: @escaping ([ActorInfo]) -> Void, error: @escaping (NetworkError) -> Void) {
        let parameters: [String: Any] = [
            "api_key": Constant.Network.API_KEY,
            "language": "en-US",
            "page": 1,
            "query": query
        ]
        
        Network.get(URLPath.SearchPath.SEARCH_PERSON,
                    parameters: parameters,
                    responseType: PersonSearchInfo.self,
                    completionHandler: { response in
            completion(response.results)
        }, errorHandler: error)
    }
    
    // MARK: - SHOW TIME
    func getShowTimes(with name: String, completion: @escaping (ShowTimesContainerInfo) -> Void, error: @escaping (NetworkError) -> Void) {
        let parametters: [String: Any] = [
            "appId": Constant.Network.APP_ID,
            "appKey": Constant.Network.APP_KEY,
            "movie": name
        ]

        // https://demo0481328.mockable.io/test
        Network.get(URLPath.GET_SHOW_TIME,
                    parameters: parametters,
                    responseType: ShowTimesContainerInfo.self,
                    completionHandler: { response in
            completion(response)
        }, errorHandler: error)
    }
    
    // MARK: - GET MOVIE IN CURRENT POSITION RADIUS = 10km2
    func getMovieTheaters(at location: Location, completion: @escaping ([MovieTheaterSearchInfo]) -> Void, error: @escaping (NetworkError) -> Void) {

        let parametters: [String: Any] = [
            "location": "\(location.lat),\(location.lng)",
            "radius": 10000,
            "types": "movie_theater",
            "key": RemoteConfigManager.shared.string(forKey: .mapKey)
        ]

        // https://demo0481328.mockable.io/map
        Network.get(URLPath.GET_MOVIE_THEATER,
                    parameters: parametters,
                    responseType: MovieTheaterSearchContainerInfo.self,
                    completionHandler: { response in
            completion(response.results)
        }, errorHandler: error)
    }

    // MARK: - GET SHOW TIME OF THEATER
    func getShowTimesCinema(with name: String,
                            completion: @escaping ([TimeInfo]) -> Void,
                            error: @escaping (NetworkError) -> Void) {
        let parametters: [String: Any] = [
            "appId": Constant.Network.APP_ID,
            "appKey": Constant.Network.APP_KEY,
            "cinema": name
        ]

        // https://demo0481328.mockable.io/test1
        Network.get(URLPath.GET_SHOW_TIME,
                    parameters: parametters,
                    responseType: CinemaTimeInfo.self,
                    completionHandler: { response in
            completion(response.showtimes)
        }, errorHandler: error)
    }

    // MARK: - GET LINK FULL
    func getLinkMovie(with name: String,
                      completion: @escaping (LinkContainerInfo) -> Void,
                      error: @escaping (NetworkError) -> Void) {
        let parametters: [String: Any] = [
            "appId": Constant.Network.APP_ID,
            "name": name
        ]

        Network.get(URLPath.PreviewPath.LINK_MOVIE,
                    parameters: parametters,
                    isEncrypte: true,
                    responseType: LinkContainerInfo.self,
                    completionHandler: { response in
            completion(response)
        }, errorHandler: error)
    }
    
    func getLinkTVShow(with tvShowName: String,
                       seasonName: String,
                       episode: Int,
                       completion: @escaping (LinkContainerInfo) -> Void,
                       error: @escaping (NetworkError) -> Void) {
        
        let parametters: [String: Any] = [
            "appId": Constant.Network.APP_ID,
            "name": tvShowName + " - " + seasonName,
            "episode": episode
        ]
        
        Network.get(URLPath.PreviewPath.LINK_TV,
                    parameters: parametters,
                    isEncrypte: true,
                    responseType: LinkContainerInfo.self,
                    completionHandler: { response in
            completion(response)
        }, errorHandler: error)
    }
    
    func getWallpaper(with id: WallpaperID,
                      page: Int = 1,
                      completion: @escaping ([Wallpaper]) -> Void,
                      error: @escaping (NetworkError) -> Void) {
        let parametters: [String: Any] = [
            "appId": Constant.Network.APP_ID,
            "appKey": Constant.Network.APP_KEY,
            "type": "phone",
            "method": "category",
            "id": id.rawValue,
            "page": page
        ]
        
        Network.get(URLPath.WallPaper.WALL_PAPER,
                    parameters: parametters,
                    responseType: WallpaperInfo.self,
                    completionHandler: { response in
            completion(response.wallpapers)
        }, errorHandler: error)
    }
}

enum WallpaperID: String {
    case movie = "20"
    case tv = "29"
    case actor = "7"
}
