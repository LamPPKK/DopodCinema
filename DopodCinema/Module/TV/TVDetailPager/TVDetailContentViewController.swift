//
//  TVDetailContentViewController.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/12.
//

import UIKit
import RxSwift
import RxGesture

class TVDetailContentViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var generalView: UIView!
    @IBOutlet private weak var generalLabel: UILabel!
    @IBOutlet private weak var generalDot: UIImageView!
    @IBOutlet private weak var seasonView: UIView!
    @IBOutlet private weak var seasonLabel: UILabel!
    @IBOutlet private weak var seasonDot: UIImageView!
    @IBOutlet private weak var containerView: UIView!
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()

    private var tvGeneralVC: TVGeneralViewController!
    var tvDetailInfo: TVShowDetailInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: - Private functions
    private func setupUI() {
        self.view.backgroundColor = Constant.Color.colorEFEFEF
        
        containerView.corner(radius: 16)
        
        setActive(forLabel: generalLabel)
        setInactive(forLabel: seasonLabel)
        
        generalView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                self.tapToGeneral()
            })
            .disposed(by: disposeBag)
        
        seasonView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                
                self.tapToSeason()
            })
            .disposed(by: disposeBag)
        
        setupScreen()
    }
    
    private func setupScreen() {
        tvGeneralVC = TVGeneralViewController(nibName: "TVGeneralViewController", bundle: nil)
        tvGeneralVC.tvDetailInfo = tvDetailInfo
        tvGeneralVC.view.frame = containerView.bounds
        addChild(tvGeneralVC)
        containerView.addSubview(tvGeneralVC.view)
        tvGeneralVC.didMove(toParent: self)
    }
    
    // MARK: - Action
    private func tapToGeneral() {
        generalDot.isHidden = false
        setActive(forLabel: generalLabel)
        
        seasonDot.isHidden = true
        setInactive(forLabel: seasonLabel)
    }
    
    private func tapToSeason() {
        generalDot.isHidden = true
        setActive(forLabel: seasonLabel)
        
        seasonDot.isHidden = false
        setInactive(forLabel: generalLabel)
    }
    
    private func setActive(forLabel label: UILabel) {
        label.textColor = Constant.Color.color3D5BF6
        label.font = .fontPoppinsSemiBold(withSize: 16)
    }
    
    private func setInactive(forLabel label: UILabel) {
        label.textColor = Constant.Color.colorBFC6CC
        label.font = .fontPoppinsSemiBold(withSize: 16)
    }

}
