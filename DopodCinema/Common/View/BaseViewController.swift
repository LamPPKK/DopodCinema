//
//  BaseViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/09.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController<ViewModel>: UIViewController, BaseHeaderSubViewDelegate {
    
    // MARK: - Property
    let disposeBag = DisposeBag()
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
    
    func setupSubHeader(with title: String,
                        titleColor: UIColor = .black,
                        isDetail: Bool = false,
                        isSave: Bool = false,
                        isBackWhite: Bool = false) {
        NotificationCenter.default.post(name: Notification.Name("hide_tabbar"), object: nil)
        
        if subHeaderView == nil {
            subHeaderView = BaseHeaderSubView.instanceFromNib()
        }
        
        if let headerView = subHeaderView {
            _ = headerView.then {
                $0.delegate = self
                $0.moveTo(parentViewController: self)
                $0.setupHeader(withTitle: title,
                               titleColor: titleColor,
                               isDetail: isDetail,
                               isSave: isSave,
                               isBackWhite: isBackWhite)
                
            }
            
            view.addSubview(headerView)
            view.bringSubviewToFront(headerView)
        }
    }
    
    func didBackToViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    func didToFavorite() {
        guard let subHeaderView = subHeaderView else {
            return
        }
        
        if subHeaderView.isSave {
            let alert: FavoriteAlertView = FavoriteAlertView(frame: CGRect(x: 0,
                                                                           y: 0,
                                                                           width: UIScreen.main.bounds.width,
                                                                           height: 92))
            
            // Add animation
            let transition = CATransition()
            transition.duration = 0.3
            transition.timingFunction = CAMediaTimingFunction(name: .easeIn)
            transition.type = .moveIn
            transition.subtype = .fromBottom
            alert.layer.add(transition, forKey: nil)
            
            // Add to subview
            view.addSubview(alert)
            view.bringSubviewToFront(alert)
        }
    }
}

extension BaseViewController: BaseHeaderViewDelegate {
    
    func didMoveToSetting() {
        let navigator = DefaultSettingNavigator(navigationController: self.navigationController ?? UINavigationController())
        let settingViewController = SettingViewController(nibName: "SettingViewController", bundle: nil)
        settingViewController.viewModel = SettingViewModel(navigator: navigator)
        settingViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(settingViewController, animated: true)
    }
}

extension UIViewController {
    
    /// SHOW ALERT
    func showAlert(with title: String = .empty, msg: String = .empty) {
        let alertVC = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default)
        
        alertVC.addAction(okAction)
        self.present(alertVC, animated: true)
    }
}
