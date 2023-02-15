//
//  BaseViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/09.
//

import UIKit

class BaseViewController<ViewModel>: UIViewController {
    
    // MARK: - Property
    var viewModel: ViewModel!
    var headerView: BaseHeaderView?
    
    private var isOfflineSearch: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        self.view.backgroundColor = Constant.Color.colorEFEFEF
    }
    
    
    // MARK: - SETUP HEADER
    func setupHeader(withTitle title: String,
                     titleColor: UIColor = .black) {
        if headerView == nil {
            headerView = BaseHeaderView.instanceFromNib()
        }
        
        if let headerView = headerView {
            _ = headerView.then {
                $0.delegate = self
                $0.moveTo(parentViewController: self)
                $0.setupHeader(withTitle: title,
                               titleColor: titleColor)
                
            }
            
            view.addSubview(headerView)
            view.bringSubviewToFront(headerView)
        }
    }
}

extension BaseViewController: BaseHeaderViewDelegate {
    
    func didMoveToSetting() {
        
    }
}

