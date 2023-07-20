//
//  SettingViewModel.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/19.
//

import Foundation
import RxSwift
import RxCocoa

class SettingViewModel: ViewModelType {
    
    private var navigator: SettingNavigator
    private let urlShareApp: String = "https://itunes.apple.com/us/app/myapp/id\(Constant.Setting.MY_APP_ID)?ls=1&mt=8"
    
    init(navigator: SettingNavigator) {
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
        let gotoPrivacyPolicyEvent = input.gotoPrivacyPolicyTrigger
            .do { [weak self] (title, url) in
                guard let self = self else { return }
                
                self.navigator.gotoPrivacyPolicy(title, url: url)
            }
            .mapToVoid()
        
        let gotoShareAppEvent = input.gotoShareAppTrigger
            .flatMap { _ in
                Observable.just(self.urlShareApp)
            }
        
        return .init(gotoPrivacyPolicyEvent: gotoPrivacyPolicyEvent.asDriverOnErrorJustComplete(),
                     gotoShareAppEvent: gotoShareAppEvent.asDriverOnErrorJustComplete())
    }
}

extension SettingViewModel {
    struct Input {
        let gotoPrivacyPolicyTrigger: Observable<(title: String, url: String)>
        let gotoShareAppTrigger: Observable<Void>
    }
    
    struct Output {
        let gotoPrivacyPolicyEvent: Driver<Void>
        let gotoShareAppEvent: Driver<String>
    }
}
