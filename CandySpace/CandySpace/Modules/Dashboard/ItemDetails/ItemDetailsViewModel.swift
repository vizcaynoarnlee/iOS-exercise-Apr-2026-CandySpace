//
//  ItemDetailsViewModel.swift
//  CandySpace
//
//  Created by Arnlee Vizcayno on 4/22/26.
//

import Foundation
import CoreGraphics

enum ItemDetailsLayout: Sendable, Equatable {
    case posterLeading
    case heroTop
}

struct ItemDetailsViewModel: Sendable, Equatable, Identifiable {
    let id: String
    let imageURL: URL?
    let imageAspectRatio: CGFloat
    let layout: ItemDetailsLayout

    let title: String
    let subtitle: String?
    let strapline: String?
    let synopsis: String?
    let badges: [String]
    let tiers: [String]
    let dates: [String]
    let duration: String?
    let brandSummary: BrandSummaryDisplay?
}

