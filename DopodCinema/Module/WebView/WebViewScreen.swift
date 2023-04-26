//
//  WebViewScreen.swift
//  Uxim
//
//  Created by The Ngoc on 2022/12/27.
//

import UIKit
import WebKit

class WebViewScreen: BaseViewController<WebViewModel> {

    // MARK: - IBOutlets
    @IBOutlet private weak var topConstraint: NSLayoutConstraint!
    @IBOutlet private weak var containerView: UIView!
    
    // MARK: - Property
    private var titleStr: String!
    private var url: String!
    
    init(title: String, url: String) {
        self.titleStr = title
        self.url = url
        super.init(nibName: "WebViewScreen", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let myURL = URL(string: url) {
            loadRequest(myURL)
        }
    }
    
    private func setupUI() {
        topConstraint.constant = Constant.HEIGHT_NAV
        setupSubHeader(with: titleStr)
    }
    
    private func loadRequest(_ url: URL) {
        LoadingView.shared.startLoading()

        let webView = WKWebView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: UIScreen.main.bounds.width,
                                              height: containerView.frame.height),
                                configuration: WKWebViewConfiguration())
        webView.navigationDelegate = self
        
        containerView.addSubview(webView)
        
        let myRequest = URLRequest(url: url)
        webView.load(myRequest)
    }
}

extension WebViewScreen: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        LoadingView.shared.endLoading()
    }
}
