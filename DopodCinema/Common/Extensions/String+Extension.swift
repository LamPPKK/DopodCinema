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
    
    // MARK: - Example 1999-04-05 -> April 5, 1999
    func convertDateToMMMMDDYYYY() -> Self {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMMM d, YYYY"
        
        if let date = dateFormatterGet.date(from: self) {
            return dateFormatterPrint.string(from: date)
        } else {
            return String.empty
        }
    }
}
