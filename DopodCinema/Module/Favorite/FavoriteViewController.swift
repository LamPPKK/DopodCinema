//
//  FavoriteViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/09.
//

import UIKit

class FavoriteViewController: BaseViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var topConstrait: NSLayoutConstraint!
    @IBOutlet private weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupUI()
        print("Favorite")
    }
    
    // MARK: - Private function
    private func setupUI() {
        setupHeader(withTitle: "Favorite")
    }
}
