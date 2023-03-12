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
        headerViewController = tvDetailViewController
        headerViewController?.parallaxHeader?.height = (UIScreen.main.bounds.width / 0.75) + Constant.HEIGHT_NAV + 65
        
        tvDetailPagerVC = TVDetailContentViewController(nibName: "TVDetailContentViewController", bundle: nil)
        tvDetailPagerVC.tvDetailInfo = viewModel.getTVDetailInfo()
        childViewController = tvDetailPagerVC
    }
}
