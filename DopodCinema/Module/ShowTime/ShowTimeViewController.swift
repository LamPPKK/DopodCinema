//
//  ShowTimeViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/09.
//

import UIKit

class ShowTimeViewController: BaseViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var topConstrait: NSLayoutConstraint!
    @IBOutlet private weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupUI()
        print("Show time")
    }
    
    // MARK: - Private function
    private func setupUI() {
        setupHeader(withTitle: "Showtime")
    }

}
