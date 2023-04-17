//
//  ScrollShowTimeViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/18.
//

import UIKit
import MXParallaxHeader

class ScrollShowTimeViewController: MXScrollViewController {

    // MARK: - Properties
    var viewModel: HeaderShowTimeViewModel!
    private var headerView: HeaderShowTime!
    private var showTimeDetailViewController: ShowTimeDetailViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupScreen()
    }
    
    // MARK: - Private functions
    private func setupScreen() {
        headerView = HeaderShowTime(nibName: "HeaderShowTime", bundle: nil)
        headerView.viewModel  = self.viewModel
        headerViewController = headerView
        headerViewController?.parallaxHeader?.height = 450

        showTimeDetailViewController = ShowTimeDetailViewController(nibName: "ShowTimeDetailViewController", bundle: nil)
        showTimeDetailViewController.viewModel = ShowTimeDetailViewModel(movieName: viewModel.getMovieDetailInfo().original_title)
        childViewController = showTimeDetailViewController
    }
}
