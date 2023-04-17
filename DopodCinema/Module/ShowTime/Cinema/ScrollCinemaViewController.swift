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
    var moviesCinema: [MovieCinema] = []
    
    private var cinemaHeaderView: CinemaHeaderViewController!
    private var cinemaDetailVC: CinemaDetailViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupScreen()
    }
    
    // MARK: - Private functions
    private func setupScreen() {
        cinemaHeaderView = CinemaHeaderViewController(nibName: "CinemaHeaderViewController", bundle: nil)
        cinemaHeaderView.viewModel = CinemaViewModel(moviesCinema: moviesCinema)
        headerViewController = cinemaHeaderView
        headerViewController?.parallaxHeader?.height = 550
        
        cinemaDetailVC = CinemaDetailViewController(nibName: "CinemaDetailViewController", bundle: nil)
        cinemaDetailVC.viewModel = CinemaViewModel(moviesCinema: moviesCinema)
        childViewController = cinemaDetailVC
    }
}
