//
//  MovieViewModel.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/13.
//

import RxSwift
import RxCocoa

enum DataSection {
    case top
    case headerCategory
    case category
    case headerPopular
    case popular
    case times
    case headerNew
    case new
    case headerComing
    case coming
    case headerActor
    case actor
}

class MovieViewModel: NSObject {
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    
    func getSections() -> [DataSection] {
        var sections: [DataSection] = []
        sections.append(.top)
        sections.append(.headerCategory)
        sections.append(.category)
        sections.append(.headerPopular)
        sections.append(.popular)
        sections.append(.times)
        sections.append(.headerNew)
        sections.append(.new)
        sections.append(.headerComing)
        sections.append(.coming)
        sections.append(.headerActor)
        sections.append(.actor)
        
        return sections
    }
}
