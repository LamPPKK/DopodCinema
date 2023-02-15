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
    
    static func fontSFProTextMedium(withSize size: CGFloat)  -> UIFont {
        return UIFont(name: "SFProText-Medium", size: size) ?? fontDefault(fontSize: size)
    }
    
    static func fontSFProTextLight(withSize size: CGFloat) -> UIFont {
        return UIFont(name: "SFProText-Light", size: size) ?? fontDefault(fontSize: size)
    }
    
    static func fontSFProTextBold(withSize size: CGFloat) -> UIFont {
        return UIFont(name: "SFProText-Bold", size: size) ?? fontDefault(fontSize: size)
    }
    
    static func fontSFProTextRegular(withSize size: CGFloat) -> UIFont {
        return UIFont(name: "SFProText-Regular", size: size) ?? fontDefault(fontSize: size)
    }
    
    static func fontSFProTextSemibold(withSize size: CGFloat) -> UIFont {
        return UIFont(name: "SFProText-Semibold", size: size) ?? fontDefault(fontSize: size)
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
    
    static func fontSFUIDisplaySemibold(withSize size: CGFloat) -> UIFont {
        return UIFont(name: "SFUIDisplay-Semibold", size: size) ?? fontDefault(fontSize: size)
    }
    
    static func fontSFProTextItalic(withSize size: CGFloat) -> UIFont {
        return UIFont(name: "SFProText-Italic", size: size) ?? fontDefault(fontSize: size)
    }
    
    static func fontInterRegular(withSize size: CGFloat) -> UIFont {
        return UIFont(name: "Inter-Regular", size: size) ?? fontDefault(fontSize: size)
    }
}
