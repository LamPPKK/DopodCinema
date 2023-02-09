//
//  Then.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/02/09.
//

import Foundation
import CoreGraphics

public protocol Then {}

public extension Then {
    func then(_ block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}

extension NSObject: Then {}
extension CGPoint: Then {}
extension CGRect: Then {}
extension CGSize: Then {}
