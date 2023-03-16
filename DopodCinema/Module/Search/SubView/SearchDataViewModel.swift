//
//  SearchDataViewModel.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/15.
//

import Foundation

class SearchDataViewModel {
    
    private var searchObjects: [SearchObject]
    
    init(searchObjects: [SearchObject]) {
        self.searchObjects = searchObjects
    }
    
    func getSearchObjects() -> [SearchObject] {
        self.searchObjects
    }
    
}
