//
//  SearchActorViewModel.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/16.
//

import Foundation

class SearchActorViewModel {
    // MARK: - Properties
    private var actorsSearch: [ActorInfo]
    
    init(actorsSearch: [ActorInfo]) {
        self.actorsSearch = actorsSearch
    }
    
    func getActorList() -> [ActorInfo] {
        self.actorsSearch
    }
}
