//
//  UIView+Extension.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/09.
//

import UIKit

extension UIView {
    
    func dropShadow(opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
//        layer.shouldRasterize = true
//        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func corner(radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    // For add layer in background
    func addBlackGradientLayerInForeground(frame: CGRect, colors:[UIColor]) {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = colors.map { $0.cgColor }
        self.layer.addSublayer(gradient)
    }
    
    // For insert layer in background
    func insertGradient(frame: CGRect, colors: [UIColor]) {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = colors.map{ $0.cgColor }
        self.layer.insertSublayer(gradient, at: 0)
    }
}
