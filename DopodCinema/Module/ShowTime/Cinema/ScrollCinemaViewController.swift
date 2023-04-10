//
//  ScrollCinemaViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/04/10.
//

import UIKit
import MXParallaxHeader

class ScrollCinemaViewController: MXScrollViewController {
    
    // MARK: - Properties
    private var cinemaHeaderView: CinemaHeaderViewController!
    private var tvDetailPagerVC: TVDetailContentViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupScreen()
    }
    
    // MARK: - Private functions
    private func setupScreen() {
        cinemaHeaderView = CinemaHeaderViewController(nibName: "CinemaHeaderViewController", bundle: nil)
        headerViewController = cinemaHeaderView
        headerViewController?.parallaxHeader?.height = (UIScreen.main.bounds.width / 0.75) + Constant.HEIGHT_NAV + 65
    }
}
