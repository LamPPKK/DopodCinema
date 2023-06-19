//
//  URLPath.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/22.
//

import Foundation

struct URLPath {
    
    // MARK: - MOVIES
    struct MoviesPath {
        static let moviesPath: String = Constant.Network.HOST_URL + "/movie"
        static let GET_MOVIES_NOWPLAYING = moviesPath + "/now_playing"
        static let GET_MOVIES_TOPRATED = moviesPath + "/top_rated"
        static let GET_MOVIES_POPULAR = moviesPath + "/popular"
        static let GET_MOVIES_UPCOMING = moviesPath + "/upcoming"
    }
    
    struct PersonPath {
        static let personPath: String = Constant.Network.HOST_URL + "/person"
        static let GET_PERSONS_POPULAR = personPath + "/popular"
    }
    
    struct GenrePath {
        private static let genrePath: String = Constant.Network.HOST_URL + "/genre"
        static let GET_LIST_GENRE_MOVIE = genrePath + "/movie/list"
        static let GET_LIST_GENRE_TV = genrePath + "/tv/list"
    }
    
    static let GET_MOVIES_BY_GENRE_ID: String = Constant.Network.HOST_URL + "/discover/movie"
    static let GET_TV_BY_GENRE_ID: String = Constant.Network.HOST_URL + "/discover/tv"
    
    // MARK: - TVSHOWS
    struct TVShowPath {
        static let tvShowPath: String = Constant.Network.HOST_URL + "/tv"
        static let GET_TV_SHOW_ON_AIR = tvShowPath + "/on_the_air"
        static let GET_TV_SHOW_TOPRATED = tvShowPath + "/top_rated"
        static let GET_TV_SHOW_POPULAR = tvShowPath + "/popular"
        static let GET_TV_SHOW_AIRINGTODAY = tvShowPath + "/airing_today"
    }
    
    // MARK: - SEARCH
    struct SearchPath {
        private static let searchPath: String = Constant.Network.HOST_URL + "/search"
        static let SEARCH_MOVIE = searchPath + "/movie"
        static let SEARCH_TVSHOW = searchPath + "/tv"
        static let SEARCH_PERSON = searchPath + "/person"
    }
    
    // MARK: - SHOW TIME
    static let GET_SHOW_TIME: String = Constant.Network.HOST_LINK_URL + "/api/service/showtimes"
    
    // MARK: - GET MOVIE THEATER
    static let GET_MOVIE_THEATER = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"

    // MARK: - PREVIEW LINK
    struct PreviewPath {
        private static let previewPath: String = Constant.Network.HOST_LINK_URL + "/encrypt"
        static let LINK_MOVIE = previewPath + "/movie"
        static let LINK_TV = previewPath + "/series"
    }
    
    // MARK: - Wall Paper
    struct WallPaper {
        static let WALL_PAPER = Constant.Network.HOST_LINK_URL + "/api/service/wallpaper"
    }
}

