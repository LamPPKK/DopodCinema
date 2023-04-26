//
//  WatchHeaderView.swift
//  Uxim
//
//  Created by The Ngoc on 2023/01/18.
//

import UIKit
import SDWebImage

class WatchHeaderView: BaseViewController<BaseViewModel> {

    // MARK: - IBOutlets
    @IBOutlet private weak var posterMovie: UIImageView!
    @IBOutlet private weak var heightOfView: NSLayoutConstraint!
    
    init(posterPath: String) {
        self.posterPath = posterPath
        super.init(nibName: "WatchHeaderView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Property
    private var posterPath: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        fillData()
    }

    // MARK: - Private functions
    private func setupUI() {
        setupSubHeader(with: .empty)
        
        heightOfView.constant = UIScreen.main.bounds.width / 0.8
    }
    
    private func fillData() {
        if let url = URL(string: Utils.getPosterPath(self.posterPath, size: .w500)) {
            posterMovie.sd_setImage(with: url, placeholderImage: UIImage(named: "ic_movie"))
        } else {
            posterMovie.image = UIImage(named: "ic_movie")
        }
    }
}

