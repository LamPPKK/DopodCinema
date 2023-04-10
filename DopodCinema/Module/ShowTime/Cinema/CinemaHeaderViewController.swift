//
//  CinemaHeaderViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/04/10.
//

import UIKit

class CinemaHeaderViewController: BaseViewController<CinemaViewModel> {

    // MARK: - IBOutlets
    @IBOutlet private weak var topConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: - Private functions
    private func setupUI() {
        setupSubHeader(with: .empty)
        topConstraint.constant = Constant.HEIGHT_NAV
    }
}
