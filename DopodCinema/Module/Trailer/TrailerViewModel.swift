//
//  TrailerViewModel.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/04/07.
//

import Foundation
import RxSwift
import RxCocoa

class TrailerViewModel: ViewModelType {
    // MARK: - Properties
    private var listTrailer: [VideoInfo]
    private var navigator: TrailerNavigator
    
    init(listTrailer: [VideoInfo],
         navigator: TrailerNavigator) {
        self.listTrailer = listTrailer
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
        let getDataEvent = input.getDataTrigger
            .flatMapLatest { [weak self] _ in
                guard let self = self else { return Driver<[VideoInfo]>.empty() }
                return Driver.just(self.listTrailer)
            }
        
        let gotoYoutubeEvent = input.gotoYoutubeTrigger
            .do { [weak self] key in
                guard let self = self else { return }
                self.navigator.gotoYoutubeScreen(key)
            }
            .mapToVoid()
        
        return .init(getDataEvent: getDataEvent.asDriverOnErrorJustComplete(),
                     gotoYoutubeEvent: gotoYoutubeEvent.asDriverOnErrorJustComplete())
    }
}

extension TrailerViewModel {
    struct Input {
        let getDataTrigger: Observable<Void>
        let gotoYoutubeTrigger: Observable<String>
    }
    
    struct Output {
        let getDataEvent: Driver<[VideoInfo]>
        let gotoYoutubeEvent: Driver<Void>
    }
}

