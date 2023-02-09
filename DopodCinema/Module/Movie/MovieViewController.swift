//
//  MovieViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/07.
//

import UIKit

class MovieViewController: BaseViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var topConstrait: NSLayoutConstraint!
    @IBOutlet private weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupUI()
        print("MOvie")
    }
    
    // MARK: - Private function
    private func setupUI() {
        setupHeader(withTitle: "Movie")
    }
}
