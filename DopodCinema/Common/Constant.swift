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
        static let color78828A: UIColor = UIColor(hexString: "#78828A") ?? UIColor()
        static let colorFACC15: UIColor = UIColor(hexString: "#FACC15") ?? UIColor()
        static let color2B2F31: UIColor = UIColor(hexString: "#2B2F31") ?? UIColor()
        static let color55595A: UIColor = UIColor(hexString: "#55595A") ?? UIColor()
    }
    
    // MARK: - ENCRYPT
    struct Encrypt {
        static let SECRET: String = "qZTaO5q5dXbx2H93"
        static let IV: String = "rvXIufiBtBorrq4w"
    }
    
    // MARK: - SETTING
    struct Setting {
        static let MY_APP_ID: String = "1662246739"
        static let URL_POLICY: String = "https://uximglobal.github.io/info/privacy.html"
        static let EMAIL_FEEDBACK: String = "frankblakeahz34735@gmail.com"
        static let SUBJECT_CONTENT: String = "Feedback: Uxim Box"
        static let BODY_CONTENT: String = .empty
    }
    
    // MARK: - NETWORK
    struct Network {
        static let HOST_URL: String = "https://api.themoviedb.org/3"
        static let HOST_LINK_URL: String = "https://thekight.link"
        static let APP_ID: String = "movie.test.app"
        static let APP_KEY: String = "48cd3fa30464885ff111de6a1a24a0069e65906aa8fcc3be2c357c622cee5fe3"
        static let API_KEY: String = "79ddd61a309a60e0e6c81f6043bc051b"
        static let IMAGES_BASE_URL = "https://image.tmdb.org/t/p/"
        static let MAP_KEY: String = "AIzaSyCuJs_7JjvSB_svpAuKaI2pbi_PTXy05x4"
        static let THUMBNAIL_YOUTUBE_URL = "https://img.youtube.com/vi/"
        static let THUMBNAIL_MAX_YOUTUBE = "/maxresdefault.jpg"
        static let SECRET: String = "qZTaO5q5dXbx2H93"
        static let IV: String = "rvXIufiBtBorrq4w"
    }
}
