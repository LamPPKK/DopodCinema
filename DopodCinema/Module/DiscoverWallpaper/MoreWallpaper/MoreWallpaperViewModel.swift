//
//  MoreWallpaperViewModel.swift
//  DopodCinema
//
//  Created by The Ngoc on 20/06/2023.
//

import Foundation
import UIKit

class MoreWallpaperViewModel {
    // MARK: - Properties
    private var navigator: MoreWallpaperNavigator
    private var id: WallpaperID
    private var wallpapers: [Wallpaper] = []
    
    init(navigator: MoreWallpaperNavigator,
         id: WallpaperID) {
        self.navigator = navigator
        self.id = id
    }
    
    func getData(completion: @escaping () -> Void) {
        LoadingView.shared.startLoading()
        
        getWallpaper(id) {
            LoadingView.shared.endLoading()
            completion()
        }
    }
    
    private func getWallpaper(_ id: WallpaperID,
                              page: Int = 1,
                              completion: @escaping () -> Void) {
        API.shared.getWallpaper(with: id,
                                page: page,
                                completion: { [weak self] wallpapers in
            guard let self = self else { return }
            self.wallpapers = wallpapers
            completion()
        }, error: { _ in
            completion()
        })
    }
    
    func getWallpapers(at page: Int, completion: @escaping (Bool) -> Void) {
        API.shared.getWallpaper(with: self.id,
                                page: page,
                                completion: { [weak self] wallpapers in
            guard let self = self else { return }
            self.wallpapers.append(contentsOf: wallpapers)
            completion(true)
        }, error: { error in
            if let topVC = UIApplication.getTopViewController() {
                topVC.showAlert(msg: error.localizedDescription)
            }
            completion(false)
        })
    }
    
    func getWallpapers() -> [Wallpaper] {
        self.wallpapers
    }
    
    func gotoWallpaperPreview(_ url: String) {
        self.navigator.gotoWallpaperPreview(url)
    }
}
