//
//  ScrollTVDetailViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/11.
//

import UIKit
import MXParallaxHeader

class ScrollTVDetailViewController: MXScrollViewController {

    // MARK: - Properties
    var viewModel: TVDetailViewModel!
    private var tvDetailViewController: TVDetailViewController!
    private var tvDetailPagerVC: TVDetailContentViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupScreen()
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
}

extension ScrollTVDetailViewController: TVDetailContentViewControllerDelegate, TVDetailViewControllerDelegate {
    func gotoYoutubeScreen(_ key: String) {
        viewModel.gotoYoutubeScreen(key)
    }
    
    func gotoScreenShot(_ index: Int) {
        viewModel.gotoScreenShot(at: index)
    }
    
    func gotoActorDetailScreen(_ id: Int) {
        viewModel.gotoActorDetail(id)
    }
    
    func gotoTVDetailScreen(_ id: Int) {
        viewModel.gotoTVDetail(id)
    }
    
    func gotoTrailerScreen() {
        viewModel.gotoTrailerScreen()
    }
    
    func showFullEpisode(_ linkInfo: LinkContainerInfo) {
        viewModel.showFullEpisode(linkInfo)
    }
}
