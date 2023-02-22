//
//  TVViewModel.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/19.
//

import Foundation

class TVViewModel: NSObject {
    func getSections() -> [DataSection] {
        var sections: [DataSection] = []
        sections.append(.top)
        sections.append(.headerCategory)
        sections.append(.category)
        sections.append(.headerPopular)
//        sections.append(.popular)
        sections.append(.headerNew)
        sections.append(.new)
        sections.append(.headerComing)
//        sections.append(.coming)
        sections.append(.headerActor)
//        sections.append(.actor)
        
        return sections
    }
}
