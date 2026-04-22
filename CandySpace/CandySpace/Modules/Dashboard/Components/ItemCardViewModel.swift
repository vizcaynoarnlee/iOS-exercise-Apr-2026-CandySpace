//
//  ItemCardViewModel.swift
//  CandySpace
//
//  Created by Arnlee Vizcayno on 4/22/26.
//

import Foundation
import CoreGraphics

struct ItemCardViewModel: Sendable, Identifiable {
    let id: String
    let imageURL: URL?
    let badgeText: String?
    let tierText: String?
    let aspectRatio: CGFloat
    let accessibilityLabel: String?
    let onTap: @Sendable () -> Void
}

