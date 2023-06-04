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
    var cinemaName: String
    var moviesCinema: [MovieCinema]
    
    private var cinemaHeaderView: CinemaHeaderViewController!
    private var cinemaDetailVC: CinemaDetailViewController!
    
    init(cinemaName: String,
         movies: [MovieCinema]) {
        self.cinemaName = cinemaName
        self.moviesCinema = movies
        
        super.init(nibName: "ScrollCinemaViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupScreen()
    }
    
    // MARK: - Private functions
    private func setupScreen() {
        cinemaHeaderView = CinemaHeaderViewController(nibName: "CinemaHeaderViewController", bundle: nil)
        cinemaHeaderView.viewModel = CinemaViewModel(cinemaName: cinemaName, moviesCinema: moviesCinema)
        headerViewController = cinemaHeaderView
        headerViewController?.parallaxHeader?.height = 550
        
        cinemaDetailVC = CinemaDetailViewController(nibName: "CinemaDetailViewController", bundle: nil)
        cinemaDetailVC.viewModel = CinemaViewModel(cinemaName: cinemaName, moviesCinema: moviesCinema)
        childViewController = cinemaDetailVC
    }
}
