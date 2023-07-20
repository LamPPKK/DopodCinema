//
//  SettingNavigator.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/07/20.
//

import UIKit

protocol SettingNavigator {
    func gotoPrivacyPolicy(_ title: String, url: String)
}

class DefaultSettingNavigator: SettingNavigator {
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func gotoPrivacyPolicy(_ title: String, url: String) {
        let wewViewController = WebViewScreen(title: title, url: url)
        wewViewController.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(wewViewController, animated: true)
    }
}

