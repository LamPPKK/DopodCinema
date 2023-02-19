//
//  Utils.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/19.
//

import UIKit

struct Utils {
    static func open(with url: URL) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
