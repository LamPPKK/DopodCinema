//
//  FavoriteAlertView.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/03/20.
//

import UIKit

class FavoriteAlertView: UIView {
        
    lazy private var contentView: UIView = {
        return initView(.clear)
    }()
    
    lazy private var alertImageView: UIImageView = {
        return initImageView()
    }()
    
    lazy private var notificationLabel: UILabel = {
        return initLabel("Added to favorites.")
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        addSubview(contentView)
        
        contentView.addSubview(alertImageView)
        contentView.addSubview(notificationLabel)
        
        // MARK: - CONSTRAINTS
        NSLayoutConstraint.activate([
            alertImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            alertImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            alertImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            alertImageView.trailingAnchor.constraint(equalTo: notificationLabel.leadingAnchor, constant: -11)
        ])
        
        // MARK: - CONSTRAINTS
        NSLayoutConstraint.activate([
            notificationLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            notificationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0)
        ])
        
        // MARK: - CONSTRAINTS
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -19),
            contentView.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        self.backgroundColor = Constant.Color.color3D5BF6
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) {
                self.frame = CGRect(x: self.frame.origin.x,
                                    y: self.frame.origin.y - Constant.HEIGHT_NAV,
                                    width: self.frame.width,
                                    height: self.frame.height)
            } completion: { _ in
                self.removeFromSuperview()
            }
        }
    }
    
}

extension FavoriteAlertView {
    
    // MARK: - INIT VIEW
    private func initView(_ backgroundColor: UIColor = .clear, radius: CGFloat? = nil) -> UIView {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.clipsToBounds = true
        v.backgroundColor = backgroundColor
        if let radius = radius {
            v.layer.cornerRadius = radius
        }
        return v
    }
    
    // MARK: - INIT LABEL
    private func initLabel(_ text: String) -> UILabel {
        let lb = UILabel()
        lb.text = text
        lb.font = .fontPoppinsMedium(withSize: 14)
        lb.textColor = .white
        lb.textAlignment = .center
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }
    
    // MARK: - INIT IMAGEVIEW
    private func initImageView() -> UIImageView {
        let iv = UIImageView()
        iv.image = UIImage(named: "ic_tick")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }
}
