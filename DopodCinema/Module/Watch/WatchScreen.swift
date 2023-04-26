//
//  WatchScreen.swift
//  Uxim
//
//  Created by The Ngoc on 2023/01/18.
//

import UIKit
import MXParallaxHeader

class WatchScreen: MXScrollViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var topConstraint: NSLayoutConstraint!
    
    // MARK: - Property
    private var watchHeaderView: WatchHeaderView!
    private var watchLinkScreen: WatchLinkScreen!
    
    private var posterPath: String
    private var linkContainerInfo: LinkContainerInfo
    
    init(posterPath: String,
         linkContainerInfo: LinkContainerInfo) {
        self.posterPath = posterPath
        self.linkContainerInfo = linkContainerInfo
        
        super.init(nibName: "WatchScreen", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Private functions
    private func setupUI() {
        self.view.backgroundColor = .black
        topConstraint.constant = Constant.HEIGHT_NAV
        
        watchHeaderView = WatchHeaderView(posterPath: self.posterPath)
        headerViewController = watchHeaderView
        headerViewController?.parallaxHeader?.height = UIScreen.main.bounds.width / 0.8
        
        watchLinkScreen = WatchLinkScreen(data: linkContainerInfo)
        childViewController = watchLinkScreen
    }
}
