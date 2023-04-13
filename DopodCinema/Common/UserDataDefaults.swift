//
//  UserDataDefaults.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/20.
//

import Foundation

class SavedInfo: NSObject, NSCoding {
    
    let id: Int
    let path: String
    let name: String
    
    init(id: Int, path: String, name: String = String.empty) {
        self.id = id
        self.path = path
        self.name = name
    }
    
    required convenience init?(coder: NSCoder) {
        let id = coder.decodeInteger(forKey: "id")
        let path = coder.decodeObject(forKey: "path") as! String
        let name = coder.decodeObject(forKey: "name") as! String
        self.init(id: id, path: path, name: name)
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(path, forKey: "path")
        coder.encode(name, forKey: "name")
    }
}

class SaveCategoryInfo: NSObject, NSCoding {
    let id: Int
    
    let name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    required convenience init?(coder: NSCoder) {
        let id = coder.decodeInteger(forKey: "id")
        let name = coder.decodeObject(forKey: "name") as! String
        
        self.init(id: id, name: name)
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(name, forKey: "name")
    }
}

class UserDataDefaults {
    
    static let shared = UserDataDefaults()
    
    static private let keySavedMovies: String = "keySavedMovies"
    static private let keySavedTVs: String = "keySavedTVs"
    static private let keySavedActors: String = "keySavedActors"
    static private let keySaveCategories: String = "keySavedCategories"
    
    // Movie
    func setListMovie(_ movies: [SavedInfo]) {
        setListFav(movies, key: UserDataDefaults.keySavedMovies)
    }
    
    func getListMovie() -> [SavedInfo] {
        return getListFav(UserDataDefaults.keySavedMovies)
    }
    
    // TV Show
    func setListTV(_ tvs: [SavedInfo]) {
        setListFav(tvs, key: UserDataDefaults.keySavedTVs)
    }
    
    func getListTV() -> [SavedInfo] {
        return getListFav(UserDataDefaults.keySavedTVs)
    }
    
    // Actor
    func setListActor(_ actors: [SavedInfo]) {
        setListFav(actors, key: UserDataDefaults.keySavedActors)
    }
    
    func getListActor() -> [SavedInfo] {
        return getListFav(UserDataDefaults.keySavedActors)
    }
    
    private func setListFav(_ list: [SavedInfo], key: String) {
        let encodeData: Data = NSKeyedArchiver.archivedData(withRootObject: list)
        UserDefaults.standard.set(encodeData, forKey: key)
    }
    
    private func getListFav(_ key: String) -> [SavedInfo] {
        if let decoded = UserDefaults.standard.data(forKey: key) {
            let list = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [SavedInfo]
            return list
        } else {
            return []
        }
    }
    
    func setCategories(_ categories: [SaveCategoryInfo]) {
        let encodeData: Data = NSKeyedArchiver.archivedData(withRootObject: categories)
        UserDefaults.standard.set(encodeData, forKey: UserDataDefaults.keySaveCategories)
    }
    
    func getCategories() -> [SaveCategoryInfo] {
        if let decoded = UserDefaults.standard.data(forKey: UserDataDefaults.keySaveCategories) {
            let list = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [SaveCategoryInfo]
            return list
        } else {
            return []
        }
    }
}
