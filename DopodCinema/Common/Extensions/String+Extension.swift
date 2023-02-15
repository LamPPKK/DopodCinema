//
//  String+Extension.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/15.
//

import UIKit

extension String {
    
    static let empty: String = ""
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}
