//
//  FavoriteViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/09.
//

import UIKit

class FavoriteViewController: BaseViewController<FavoriteViewModel> {

    // MARK: - IBOutlets
    @IBOutlet private weak var topConstraint: NSLayoutConstraint!
    @IBOutlet private weak var movieView: UIView!
    @IBOutlet private weak var movielLabel: UILabel!
    @IBOutlet private weak var movieDot: UIImageView!
    @IBOutlet private weak var tvView: UIView!
    @IBOutlet private weak var tvLabel: UILabel!
    @IBOutlet private weak var tvDot: UIImageView!
    @IBOutlet private weak var actorView: UIView!
    @IBOutlet private weak var actorLabel: UILabel!
    @IBOutlet private weak var actorDot: UIImageView!
    @IBOutlet private weak var containerView: UIView!
    
    // MARK: - Properties
    var favoritePagerVC: FavoritePagerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bindAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.post(name: Notification.Name("show_tabbar"), object: nil)
    }
    
    // MARK: - Private function
    private func setupUI() {
        setupHeader(withTitle: "Favorite")
        topConstraint.constant = Constant.HEIGHT_NAV
        containerView.roundCorners(corners: [.topLeft, .topRight], radius: 16)
        
        setActive(forLabel: movielLabel)
        setInactive(forLabel: tvLabel)
        setInactive(forLabel: actorLabel)
        
        setupPager()
    }
    
    private func setActive(forLabel label: UILabel) {
        label.textColor = Constant.Color.color3D5BF6
        label.font = .fontPoppinsSemiBold(withSize: 16)
    }
    
    private func setInactive(forLabel label: UILabel) {
        label.textColor = Constant.Color.colorBFC6CC
        label.font = .fontPoppinsSemiBold(withSize: 16)
    }
    
    private func setupPager() {
        favoritePagerVC = FavoritePagerViewController()
        favoritePagerVC.view.frame = containerView.bounds
        favoritePagerVC.pagerDelegate = self
        addChild(favoritePagerVC)
        containerView.addSubview(favoritePagerVC.view)
        favoritePagerVC.didMove(toParent: self)
        self.movieDot.isHidden = false
        self.tvDot.isHidden = true
        self.actorDot.isHidden = true
        self.setActive(forLabel: self.movielLabel)
        self.setInactive(forLabel: self.tvLabel)
        self.setInactive(forLabel: self.actorLabel)
    }
    
    private func bindAction() {
        movieView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.movieDot.isHidden = false
                self.tvDot.isHidden = true
                self.actorDot.isHidden = true
                self.setActive(forLabel: self.movielLabel)
                self.setInactive(forLabel: self.tvLabel)
                self.setInactive(forLabel: self.actorLabel)
                self.moveToScreen(.kMovie)
            })
            .disposed(by: disposeBag)
        
        tvView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.movieDot.isHidden = true
                self.tvDot.isHidden = false
                self.actorDot.isHidden = true
                self.setInactive(forLabel: self.movielLabel)
                self.setActive(forLabel: self.tvLabel)
                self.setInactive(forLabel: self.actorLabel)
                self.moveToScreen(.kTV)
            })
            .disposed(by: disposeBag)
        
        actorView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.movieDot.isHidden = true
                self.tvDot.isHidden = true
                self.actorDot.isHidden = false
                self.setInactive(forLabel: self.movielLabel)
                self.setInactive(forLabel: self.tvLabel)
                self.setActive(forLabel: self.actorLabel)
                self.moveToScreen(.kActor)
            })
            .disposed(by: disposeBag)
    }
    
    private func moveToScreen(_ tag: SearchPagerTag) {
        if favoritePagerVC != nil {
            favoritePagerVC.moveToScreen(at: tag)
        }
    }
}

extension FavoriteViewController: FavoritePagerViewDelegate {
    func didSelectedObject(id: Int, isMovie: Bool) {
        if isMovie {
            viewModel.gotoMovieDetail(with: id)
        } else {
            viewModel.gotoTVDetail(with: id)
        }
    }
    
    func didSelectedActor(id: Int) {
        viewModel.gotoActorDetail(with: id)
    }
    
    func removeObject(_ type: SearchPagerTag, selectedObject: SavedInfo) {
        viewModel.gotoRemoveFavoritePopup(type, object: selectedObject)
    }
}
