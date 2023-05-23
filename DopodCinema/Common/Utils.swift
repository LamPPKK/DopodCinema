//
//  Utils.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/19.
//

import UIKit

struct Utils {
    
    // MARK: - Get URL from Poster Path
    static func getBackDropPath(_ path: String? = nil, size: BackDropSize = .w780) -> String  {
        return getURL(fromPath: path, size: size.rawValue)
    }
    
    // MARK: - Get URL from Poster Path
    static func getPosterPath(_ path: String? = nil, size: PosterSize = .w185) -> String  {
        return getURL(fromPath: path, size: size.rawValue)
    }
    
    // MARK: - Get URL from Profile Path
    static func getProfilePath(_ path: String? = nil, size: ProfileSize = .w185) -> String  {
        return getURL(fromPath: path, size: size.rawValue)
    }
    
    private static func getURL(fromPath path: String? = nil, size: String) -> String {
        if let path = path {
            return Constant.Network.IMAGES_BASE_URL + "/\(size)" + path
        } else {
            return String.empty
        }
    }
    
    static func getNameGenres(from ids: [Int],
                              genres: [GenreInfo],
                              separator: String) -> String {
        var listName: [String] = []
        for genre in genres {
            for id in ids where id == genre.id {
                listName.append(genre.name)
            }
        }
        return listName.joined(separator: separator)
    }
    
    static func getFirstNameCategory(from id: Int?,
                                     categories: [GenreInfo]) -> String {
        guard let id = id else {
            return .empty
        }
        
        var name: String = .empty
        for category in categories where id == category.id {
            name = category.name
        }
        
        return name
    }
    
    // MARK: - Get list genre name from list genre, After convert to String
    static func getGenresString(from genres: [GenreInfo], separator: String) -> String {
        let names: [String] = genres.map({ return $0.name })
        return names.joined(separator: separator)
    }
    
    static func getHourMin(from minutes: Int) -> (hour: Int, min: Int) {
        let hour: Int = minutes / 60
        let min: Int = minutes % 60
        return (hour, min)
    }
    
    static func open(with url: URL) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    static func isShowFull() -> Bool {
        let times = RemoteConfigManager.shared.double(forKey: .timeShowFull)
        let showDate = Date(timeIntervalSince1970: times)
        
        if showDate < Date() {
            return true
        } else {
            return false
        }
    }
}
