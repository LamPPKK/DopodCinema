//
//  HomeScreen.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/06.
//

import UIKit
import RxCocoa
import RxSwift
import RxGesture

class HomeScreen: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var tabbarView: UIView!
    @IBOutlet private weak var movieNavView: UIView!
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var movieDotImageView: UIImageView!
    @IBOutlet private weak var tvNavView: UIView!
    @IBOutlet private weak var tvImageView: UIImageView!
    @IBOutlet private weak var tvDotImageView: UIImageView!
    @IBOutlet private weak var favNavView: UIView!
    @IBOutlet private weak var favImageView: UIImageView!
    @IBOutlet private weak var favDotImageView: UIImageView!
    @IBOutlet private weak var discoveryNavView: UIView!
    @IBOutlet private weak var discoveryImageView: UIImageView!
    @IBOutlet private weak var discoveryDotImageView: UIImageView!
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private var homePageVC: HomePageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(hideTabbar), name: Notification.Name("hide_tabbar"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showTabbar), name: Notification.Name("show_tabbar"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(openShowTimeScreen), name: Notification.Name("Open_ShowTime"), object: nil)
        navigationController?.setNavigationBarHidden(true, animated: true)

        setupUI()
        setAction()
    }

    // MARK: - Private functions
    private func setupUI() {
        
        setupHomePageVC()
                
        tvDotImageView.isHidden = true
        favDotImageView.isHidden = true
        discoveryDotImageView.isHidden = true
    }
    
    private func setAction() {
        movieNavView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                self.handleTapMovie()
            })
            .disposed(by: disposeBag)
        
        tvNavView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                self.handleTapTV()
            })
            .disposed(by: disposeBag)
        
        favNavView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                self.handleTapFav()
            })
            .disposed(by: disposeBag)
        
        discoveryNavView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                self.handleTapDiscovery()
            })
            .disposed(by: disposeBag)
    }
    
    private func setupHomePageVC() {
        homePageVC = HomePageViewController()
        homePageVC.view.frame = containerView.bounds
        addChild(homePageVC)
        containerView.addSubview(homePageVC.view)
        homePageVC.didMove(toParent: self)
    }
    
    private func handleTapMovie() {
        homePageVC.moveToScreen(at: .kMovie)
        handleTap(isActiveMovie: true)
    }
    
    private func handleTapTV() {
        homePageVC.moveToScreen(at: .kTV)
        handleTap(isActiveTV: true)
    }
    
    private func handleTapFav() {
        homePageVC.moveToScreen(at: .kFavorite)
        handleTap(isActiveFav: true)
    }
    
    private func handleTapDiscovery() {
        homePageVC.moveToScreen(at: .kDiscovery)
        handleTap(isActiveDiscovery: true)
    }
    
    private func handleTap(isActiveMovie: Bool = false,
                           isActiveTV: Bool = false,
                           isActiveFav: Bool = false,
                           isActiveDiscovery: Bool = false) {
        movieImageView.image = UIImage(named: isActiveMovie ? "ic_home_active" : "ic_home_inactive")
        tvImageView.image = UIImage(named: isActiveTV ? "ic_play_active" : "ic_play_inactive")
        favImageView.image = UIImage(named: isActiveFav ? "ic_fav_active" : "ic_fav_inactive")
        discoveryImageView.image = UIImage(named: isActiveDiscovery ? "ic_discovery_active" : "ic_discovery_inactive")
        
        movieDotImageView.isHidden = !isActiveMovie
        tvDotImageView.isHidden = !isActiveTV
        favDotImageView.isHidden = !isActiveFav
        discoveryDotImageView.isHidden = !isActiveDiscovery
    }
}

extension HomeScreen {
    
    @objc
    private func hideTabbar() {
        tabbarView.isHidden = true
    }
    
    @objc
    private func showTabbar() {
        tabbarView.isHidden = false
    }
    
    @objc
    private func openShowTimeScreen() {
        handleTapDiscovery()
    }
}
