//
//  DiscoverWallpaperNavigator.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/06/17.
//

import Foundation
import UIKit

protocol DiscoverWallpaperNavigator {
    func start()
    func gotoWallpaperPreview(_ url: String)
    func gotoSeeMoreWallpaper(_ wallpaperID: WallpaperID)
}

class DefaultDiscoverWallpaperNavigator: DiscoverWallpaperNavigator {
    // MARK: - Properties
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = DiscoverWallpaperViewModel(navigator: self)
        let viewController = DiscoverWallpaperViewController()
        viewController.viewModel = viewModel                                    
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func gotoWallpaperPreview(_ url: String) {
        let viewController = WallpaperPreviewViewController(url: url)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func gotoSeeMoreWallpaper(_ wallpaperID: WallpaperID) {
        let navigator = DefaultMoreWallpaperNavigator(navigationController: navigationController)
        navigator.start(wallpaperID)
    }
}
