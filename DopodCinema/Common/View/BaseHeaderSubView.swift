//
//  BaseHeaderSubView.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/19.
//

import UIKit

protocol BaseHeaderSubViewDelegate: NSObjectProtocol {
    func didBackToViewController()
    func didToFavorite()
}

class BaseHeaderSubView: UIView {

    // MARK: - IBOutlet
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var saveButton: UIButton!
    
    // MARK: - Property
    private static let nibName: String = "BaseHeaderSubView"
    private var topConstraint: NSLayoutConstraint!
    private var heightConstraint: NSLayoutConstraint!
    var isSave: Bool = false
    
    weak var delegate: BaseHeaderSubViewDelegate?
    
    class func instanceFromNib() -> BaseHeaderSubView {
        return UINib(nibName: nibName, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! BaseHeaderSubView
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func moveTo(parentViewController: UIViewController) {
        let width: CGFloat = UIScreen.main.bounds.width
        _ = self.then {
            $0.frame = CGRect(x: 0, y: 0, width: width, height: Constant.HEIGHT_NAV)
            $0.removeFromSuperview()
        }
        parentViewController.view.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false

        _ = parentViewController.view.then {
            // Constraint - Top
            self.topConstraint = NSLayoutConstraint(item: self,
                                                    attribute: .top,
                                                    relatedBy: .equal,
                                                    toItem: parentViewController.topLayoutGuide,
                                                    attribute: .bottom,
                                                    multiplier: 1,
                                                    constant: 0)
            $0.addConstraint(self.topConstraint)

            // Constraint - Right
            $0.addConstraint(NSLayoutConstraint(item: self,
                                                attribute: .trailing,
                                                relatedBy: .equal,
                                                toItem: parentViewController.view,
                                                attribute: .trailing,
                                                multiplier: 1,
                                                constant: 0))
            // Constraint - Left
            $0.addConstraint(NSLayoutConstraint(item: self,
                                                attribute: .leading,
                                                relatedBy: .equal,
                                                toItem: parentViewController.view,
                                                attribute: .leading,
                                                multiplier: 1,
                                                constant: 0))
            
            // Constraint - Height
            self.heightConstraint = NSLayoutConstraint(item: self,
                                                       attribute: .height,
                                                       relatedBy: .equal,
                                                       toItem: nil,
                                                       attribute: .notAnAttribute,
                                                       multiplier: 1,
                                                       constant: Constant.HEIGHT_NAV)
            $0.addConstraint(self.heightConstraint)
            
            // Constraint - Width
            $0.addConstraint(NSLayoutConstraint(item: self,
                                                attribute: .width,
                                                relatedBy: .equal,
                                                toItem: nil,
                                                attribute: .notAnAttribute,
                                                multiplier: 1,
                                                constant: width))
            
            $0.bringSubviewToFront(self)
        }
    }
    
    private func setupUI() {
        self.backgroundColor = .clear
        titleLabel.textColor = .black
        titleLabel.font = UIFont.fontPoppinsBold(withSize: 16)
        backButton.setImage(UIImage(named: "ic_back")?.withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.tintColor = Constant.Color.color2B2F31
    }
    
    func setupHeader(withTitle title: String,
                     isDetail: Bool,
                     isSave: Bool,
                     isBackWhite: Bool) {
        setupUI()
        titleLabel.text = title
        saveButton.isHidden = !isDetail
        backButton.tintColor = isBackWhite ? .white : Constant.Color.color2B2F31
        self.isSave = isSave
        setupFavouriteIcon()
    }
    
    private func setupFavouriteIcon() {
        let saveImage = isSave ? UIImage(named: "ic_save_active") : UIImage(named: "ic_save_inactive")
        saveButton.setImage(saveImage, for: .normal)
    }
    
    @IBAction func didBackToViewController() {
        delegate?.didBackToViewController()
    }
    
    @IBAction func didSave() {
        isSave = !isSave
        setupFavouriteIcon()
        delegate?.didToFavorite()
    }
}
