//
//  DashboardRoute.swift
//  CandySpace
//
//  Created by Arnlee Vizcayno on 4/22/26.
//

import Foundation

enum DashboardRoute: Hashable {
    case sectionDetails(SectionDetailsRoute)
    case itemDetails(ItemDetailsRoute)
}

struct SectionDetailsRoute: Hashable {
    let sectionId: String
}

struct ItemDetailsRoute: Hashable {
    let sectionId: String
    let itemId: String
}

