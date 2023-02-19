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
    var subHeaderView: BaseHeaderSubView?
    
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
    
    func setupSubHeader(with title: String) {
        if subHeaderView == nil {
            subHeaderView = BaseHeaderSubView.instanceFromNib()
        }
        
        if let headerView = subHeaderView {
            _ = headerView.then {
                $0.delegate = self
                $0.moveTo(parentViewController: self)
                $0.setupHeader(withTitle: title)
                
            }
            
            view.addSubview(headerView)
            view.bringSubviewToFront(headerView)
        }
    }
}

extension BaseViewController: BaseHeaderViewDelegate {
    
    func didMoveToSetting() {
        let settingViewController = SettingViewController(nibName: "SettingViewController", bundle: nil)
        settingViewController.viewModel = SettingViewModel()
        settingViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(settingViewController, animated: true)
    }
}

extension BaseViewController: BaseHeaderSubViewDelegate {
    func didBackToViewController() {
        self.navigationController?.popViewController(animated: true)
    }
}
