//
//  MoreWallpaperNavigator.swift
//  DopodCinema
//
//  Created by The Ngoc on 20/06/2023.
//

import UIKit

protocol MoreWallpaperNavigator {
    func start(_ wallpaperID: WallpaperID)
    func gotoWallpaperPreview(_ url: String)
}

class DefaultMoreWallpaperNavigator: MoreWallpaperNavigator {
    
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(_ wallpaperID: WallpaperID) {
        let viewModel = MoreWallpaperViewModel(navigator: self, id: wallpaperID)
        let viewController = MoreWallpaperViewController()
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func gotoWallpaperPreview(_ url: String) {
        let viewController = WallpaperPreviewViewController(url: url)
        navigationController.pushViewController(viewController, animated: true)
    }
}
