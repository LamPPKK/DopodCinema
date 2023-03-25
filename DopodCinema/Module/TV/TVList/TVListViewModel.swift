//
//  TVListViewModel.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/25.
//

import Foundation

class TVListViewModel {
    // MARK: - Properties
    private var navigator: TVListNavigator
    private var title: String
    private var list: [TVShowInfo]
    private var categories: [GenreInfo]
    
    init(navigator: TVListNavigator,
         title: String,
         list: [TVShowInfo],
         categories: [GenreInfo]) {
        self.navigator = navigator
        self.title = title
        self.list = list
        self.categories = categories
    }
    
    func getNavigationTitle() -> String {
        self.title
    }
    
    func getTVList() -> [TVShowInfo] {
        self.list
    }
    
    func getCategories() -> [GenreInfo] {
        self.categories
    }
    
    func gotoTVDetail(with id: Int) {
        LoadingView.shared.startLoading()
        
        API.shared.getTVShowDetail(with: id) { [weak self] tvShowDetailInfo in
            guard let self = self else { return }
            
            self.navigator.gotoTVDetail(tvShowDetailInfo)
            LoadingView.shared.endLoading()
        } error: { error in
            LoadingView.shared.endLoading()
        }
    }
}
