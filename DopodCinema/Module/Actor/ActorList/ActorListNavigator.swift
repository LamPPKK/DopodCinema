//
//  ActorListNavigator.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/14.
//

import UIKit

protocol ActorListNavigator {
    func start(with title: String, actorList: [ActorInfo])
    func gotoActorDetail(_ actorDetailInfo: ActorDetailInfo)
}

class DefaultActorListNavigator: ActorListNavigator {
    // MARK: - Properties
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(with title: String, actorList: [ActorInfo]) {
        let viewModel = ActorListViewModel(navigator: self, navigationTitle: title, actorList: actorList)
        let actorListVC = ActorListViewController(nibName: "ActorListViewController", bundle: nil)
        actorListVC.viewModel = viewModel
        navigationController.pushViewController(actorListVC, animated: true)
    }
    
    func gotoActorDetail(_ actorDetailInfo: ActorDetailInfo) {
        let navigator = DefaultActorDetailNavigator(navigationController: navigationController)
        navigator.start(actorDetailInfo)
    }
}
