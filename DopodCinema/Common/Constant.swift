//
//  Constant.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/09.
//

import UIKit

struct Constant {
    
    static let HEIGHT_NAV: CGFloat = 56
    static let BOTTOM_SAFE_AREA: CGFloat = 34

    // MARK: - COLOR
    struct Color {
        static let colorEFEFEF: UIColor = UIColor(hexString: "#FAFAFA") ?? UIColor()
        static let color3D5BF6: UIColor = UIColor(hexString: "#3D5BF6") ?? UIColor()
        static let color9CA4AB: UIColor = UIColor(hexString: "#9CA4AB") ?? UIColor()
        static let color97999B: UIColor = UIColor(hexString: "#97999B") ?? UIColor()
        static let colorE3E9ED: UIColor = UIColor(hexString: "#E3E9ED") ?? UIColor()
    }
    
    // MARK: - ENCRYPT
    struct Encrypt {
        static let SECRET: String = "qZTaO5q5dXbx2H93"
        static let IV: String = "rvXIufiBtBorrq4w"
    }
}
