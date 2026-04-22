//
//  ImageAspectRatio+CGFloat.swift
//  CandySpace
//
//  Created by Arnlee Vizcayno on 4/22/26.
//

import Foundation
import CoreGraphics

extension ImageAspectRatio {
    var cgFloatValue: CGFloat {
        switch self {
        case .twoByThree:
            return 2.0 / 3.0
        case .sixteenByNine:
            return 16.0 / 9.0
        }
    }
}

