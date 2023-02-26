//
//  UIFont+Extension.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/14.
//

import UIKit

extension UIFont {
    
    private static func fontDefault(fontSize: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue", size: fontSize)!
    }
    
    static func fontPoppinsRegular(withSize size: CGFloat)  -> UIFont {
        return UIFont(name: "Poppins-Regular", size: size) ?? fontDefault(fontSize: size)
    }
    
    static func fontPoppinsBold(withSize size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Bold", size: size) ?? fontDefault(fontSize: size)
    }
    
    static func fontPoppinsMedium(withSize size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Medium", size: size) ?? fontDefault(fontSize: size)
    }
    
    static func fontPoppinsSemiBold(withSize size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-SemiBold", size: size) ?? fontDefault(fontSize: size)
    }
    
    static func fontInterRegular(withSize size: CGFloat) -> UIFont {
        return UIFont(name: "Inter-Regular", size: size) ?? fontDefault(fontSize: size)
    }
}
