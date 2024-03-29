//
//  YoutubeViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/04/26.
//

import UIKit

class YoutubeViewController: BaseViewController<BaseViewModel> {

    // MARK: - IBOutlets
    @IBOutlet private weak var topConstraint: NSLayoutConstraint!
    @IBOutlet private weak var youtubeView: YouTubePlayerView!
    
    init(key: String) {
        self.key = key
        super.init(nibName: "YoutubeViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    private var key: String
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        LoadingView.shared.startLoading()
        youtubeView.loadVideoID(key)
        youtubeView.delegate = self
    }

    // MARK: - Private functions
    private func setupUI() {
        topConstraint.constant = Constant.HEIGHT_NAV
        self.view.backgroundColor = .black
        setupSubHeader(with: .empty, isBackWhite: true)
    }
}

extension YoutubeViewController: YouTubePlayerDelegate {
    func playerReady(_ videoPlayer: YouTubePlayerView) {
        LoadingView.shared.endLoading()
    }
}
