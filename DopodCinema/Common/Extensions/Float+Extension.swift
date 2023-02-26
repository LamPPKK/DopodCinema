//
//  Float+Extension.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/26.
//

import Foundation

extension Float {
    func format(f: Int) -> String {
        return String(format: "%.\(f)f", self)
    }
}
