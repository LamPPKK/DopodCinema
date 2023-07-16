//
//  ScrollTVDetailViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/11.
//

import UIKit
import MXParallaxHeader
import RxSwift
import RxCocoa

class ScrollTVDetailViewController: MXScrollViewController {

    // MARK: - Properties
    var viewModel: TVDetailViewModel!
    private var tvDetailViewController: TVDetailViewController!
    private var tvDetailPagerVC: TVDetailContentViewController!
    
    private let disposeBag = DisposeBag()
    private let gotoTrailerTrigger = PublishSubject<Void>()
    private let gotoScreenShotTrigger = PublishSubject<Int>()
    private let gotoYoutubeTrigger = PublishSubject<String>()
    private let gotoActorDetailTrigger = PublishSubject<Int>()
    private let gotoTVShowDetailTrigger = PublishSubject<Int>()
    private let showFullEpiscodeTrigger = PublishSubject<LinkContainerInfo>()
    private let gotoEpisodeOverViewTrigger = PublishSubject<EpiscodeInfo>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupScreen()
        bindViewModel()
    }
    
    // MARK: - Private functions
    private func setupScreen() {
        tvDetailViewController = TVDetailViewController(nibName: "TVDetailViewController", bundle: nil)
        tvDetailViewController.viewModel = self.viewModel
        tvDetailViewController.delegate = self
        headerViewController = tvDetailViewController
        headerViewController?.parallaxHeader?.height = (UIScreen.main.bounds.width / 0.75) + Constant.HEIGHT_NAV + 65
        
        tvDetailPagerVC = TVDetailContentViewController(nibName: "TVDetailContentViewController", bundle: nil)
        tvDetailPagerVC.delegate = self
        tvDetailPagerVC.tvDetailInfo = viewModel.getTVDetailInfo()
        childViewController = tvDetailPagerVC
    }
    
    private func bindViewModel() {
        let input = TVDetailViewModel.Input(gotoTrailerTrigger: gotoTrailerTrigger.asObserver(),
                                            gotoScreenShotTrigger: gotoScreenShotTrigger.asObserver(),
                                            gotoYoutubeTrigger: gotoYoutubeTrigger.asObserver(),
                                            gotoActorDetailTrigger: gotoActorDetailTrigger.asObserver(),
                                            gotoTVDetailTrigger: gotoTVShowDetailTrigger.asObserver(),
                                            showFullEpiscodeTrigger: showFullEpiscodeTrigger.asObserver(),
                                            gotoEpisodeOverViewTrigger: gotoEpisodeOverViewTrigger.asObserver())
        
        let output = viewModel.transform(input: input)
        
        output.loadingEvent
            .drive { isLoading in
                isLoading ? LoadingView.shared.startLoading() : LoadingView.shared.endLoading()
            }
            .disposed(by: disposeBag)
        
        output.allErrorEvent
            .drive { [weak self] _ in
                guard let self = self else { return }
                self.showAlert(with: "Notification",
                               msg: "The resource you requested could not be found.")
            }
            .disposed(by: disposeBag)
            
        
        [output.gotoScreenShotEvent,
         output.gotoTrailerEvent,
         output.gotoYoutubeEvent,
         output.gotoActorDetailEvent,
         output.gotoTVDetailEvent,
         output.showFullEpiscodeEvent,
         output.gotoEpisodeOverViewEvent]
            .forEach({ $0.drive().disposed(by: disposeBag) })
    }
}

extension ScrollTVDetailViewController: TVDetailContentViewControllerDelegate, TVDetailViewControllerDelegate {
    func gotoYoutubeScreen(_ key: String) {
        gotoYoutubeTrigger.onNext(key)
    }
    
    func gotoScreenShot(_ index: Int) {
        gotoScreenShotTrigger.onNext(index)
    }
    
    func gotoActorDetailScreen(_ id: Int) {
        gotoActorDetailTrigger.onNext(id)
    }
    
    func gotoTVDetailScreen(_ id: Int) {
        gotoTVShowDetailTrigger.onNext(id)
    }
    
    func gotoTrailerScreen() {
        gotoTrailerTrigger.onNext(())
    }
    
    func showFullEpisode(_ linkInfo: LinkContainerInfo) {
        showFullEpiscodeTrigger.onNext(linkInfo)
    }
    
    func showEpisodeOverView(_ episcodeInfo: EpiscodeInfo) {
        gotoEpisodeOverViewTrigger.onNext(episcodeInfo)
    }
}
