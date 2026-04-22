//
//  SectionDetailsViewModel.swift
//  CandySpace
//
//  Created by Arnlee Vizcayno on 4/22/26.
//

import Foundation
import CoreGraphics

enum SectionDetailsLayout: Sendable, Equatable {
    case grid2Col
    case fullWidthRows
}

struct SectionDetailsViewModel: Sendable {
    let sectionId: String
    let title: String
    let layout: SectionDetailsLayout
    let items: [ItemCardViewModel]
}

