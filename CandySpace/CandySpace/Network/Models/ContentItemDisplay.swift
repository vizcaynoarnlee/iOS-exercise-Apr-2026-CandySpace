//
//  ContentItemDisplay.swift
//  CandySpace
//
//  Created by Arnlee Vizcayno on 4/22/26.
//

import Foundation

struct BrandSummaryDisplay: Sendable, Equatable {
    let title: String
    let imageURLString: String?
}

struct ContentItemDisplay: Sendable, Equatable {
    let id: String
    let imageURLString: String?
    let badgeText: String?
    let tierText: String?

    let title: String?
    let subtitle: String?
    let strapline: String?
    let synopsis: String?
    let badges: [String]
    let tiers: [String]
    let broadcastDateTime: String?
    let latestBroadcastDateTime: String?
    let duration: String?
    let brandSummary: BrandSummaryDisplay?
}

