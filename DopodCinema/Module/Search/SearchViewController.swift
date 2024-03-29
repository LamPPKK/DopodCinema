//
//  SearchViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/15.
//

import UIKit
import RxGesture

class SearchViewController: BaseViewController<SearchViewModel> {

    // MARK: - IBOutlets
    @IBOutlet private weak var topConstraint: NSLayoutConstraint!
    @IBOutlet private weak var searchView: UIView!
    @IBOutlet private weak var searchTf: UITextField!
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
    var searchPagerView: SearchPagerViewController!
    
    private var searchString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bindAction()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        containerView.roundCorners(corners: [.topLeft, .topRight], radius: 16)
    }
    
    // MARK: - Private functions
    private func setupUI() {
        topConstraint.constant = Constant.HEIGHT_NAV
        setupSubHeader(with: "")
        
        searchView.corner(radius: 16)
        searchView.dropShadow(offSet: CGSize(width: 0, height: 4),
                              radius: 16)
        
        searchTf.becomeFirstResponder()
        searchTf.delegate = self
        searchTf.returnKeyType = .search
        searchTf.font = .fontInterRegular(withSize: 14)
        searchTf.textColor = Constant.Color.color97999B
                
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
        searchPagerView = SearchPagerViewController()
        searchPagerView.delegatePager = self
        searchPagerView.view.frame = containerView.bounds
        addChild(searchPagerView)
        containerView.addSubview(searchPagerView.view)
        searchPagerView.didMove(toParent: self)
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
                self.moveToScreen(.kMovie)
            })
            .disposed(by: disposeBag)
        
        tvView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                self.moveToScreen(.kTV)
            })
            .disposed(by: disposeBag)
        
        actorView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.moveToScreen(.kActor)
            })
            .disposed(by: disposeBag)
    }
    
    private func moveToScreen(_ tag: SearchPagerTag) {
        switch tag {
        case .kMovie:
            self.movieDot.isHidden = false
            self.tvDot.isHidden = true
            self.actorDot.isHidden = true
            self.setActive(forLabel: self.movielLabel)
            self.setInactive(forLabel: self.tvLabel)
            self.setInactive(forLabel: self.actorLabel)
            
        case .kTV:
            self.movieDot.isHidden = true
            self.tvDot.isHidden = false
            self.actorDot.isHidden = true
            self.setInactive(forLabel: self.movielLabel)
            self.setActive(forLabel: self.tvLabel)
            self.setInactive(forLabel: self.actorLabel)
            
        case .kActor:
            self.movieDot.isHidden = true
            self.tvDot.isHidden = true
            self.actorDot.isHidden = false
            self.setInactive(forLabel: self.movielLabel)
            self.setInactive(forLabel: self.tvLabel)
            self.setActive(forLabel: self.actorLabel)
        }
        
        if searchPagerView != nil {
            searchPagerView.setupData(with: viewModel.getSearchObjects(isMovie: tag == .kMovie ? true : false),
                                      actors: viewModel.getSearchActors())
            searchPagerView.moveToScreen(at: tag)
            
            let searchDict: [String: String] = [
                "key_search": searchString
            ]
            
            NotificationCenter.default.post(name: Notification.Name("Did_change_list_search"), object: nil, userInfo: searchDict)
        }
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        searchString = textField.text ?? String.empty
        
        if searchString.isEmpty {
            textField.resignFirstResponder()
            return true
        }
        
        viewModel.searchAll(searchString, completion: {
            self.moveToScreen(.kMovie)
        })
        
        textField.resignFirstResponder()
        return true
    }
}

extension SearchViewController: SearchPagerViewDelegate {
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
}
