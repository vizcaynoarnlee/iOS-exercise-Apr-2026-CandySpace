//
//  SectionRailViewModel.swift
//  CandySpace
//
//  Created by Arnlee Vizcayno on 4/22/26.
//

import Foundation

struct SectionRailViewModel: Sendable, Identifiable {
    let id: String
    let title: String
    let viewAllTitle: String
    let visibleItems: [ItemCardViewModel]
    let canViewAll: Bool
    let onViewAllTap: @Sendable () -> Void
}

