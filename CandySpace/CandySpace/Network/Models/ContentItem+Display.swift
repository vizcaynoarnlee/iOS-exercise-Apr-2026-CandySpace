//
//  ContentItem+Display.swift
//  CandySpace
//
//  Created by Arnlee Vizcayno on 4/22/26.
//

import Foundation

extension ContentItem {
    var display: ContentItemDisplay {
        switch self {
        case let .brand(item):
            return ContentItemDisplay(
                id: item.id,
                imageURLString: item.imageUrl,
                badgeText: item.badges.first,
                tierText: item.tier.first,
                title: item.title,
                subtitle: nil,
                strapline: item.strapline,
                synopsis: item.synopsis,
                badges: item.badges,
                tiers: item.tier,
                broadcastDateTime: nil,
                latestBroadcastDateTime: item.latestBroadcastDateTime,
                duration: nil,
                brandSummary: nil
            )

        case let .episode(item):
            let subtitle: String? = item.episodeNumber.map { String(localized: "Episode \($0)") }
            return ContentItemDisplay(
                id: item.id,
                imageURLString: item.imageUrl,
                badgeText: item.badges.first,
                tierText: item.tier.first,
                title: item.title,
                subtitle: subtitle,
                strapline: item.strapline,
                synopsis: item.synopsis,
                badges: item.badges,
                tiers: item.tier,
                broadcastDateTime: item.broadcastDateTime,
                latestBroadcastDateTime: nil,
                duration: item.duration,
                brandSummary: item.brand.map { BrandSummaryDisplay(title: $0.title, imageURLString: $0.imageUrl) }
            )

        case let .series(item):
            let subtitle: String? = item.seriesNumber.map { String(localized: "Series \($0)") }
            return ContentItemDisplay(
                id: item.id,
                imageURLString: item.imageUrl,
                badgeText: item.badges.first,
                tierText: item.tier.first,
                title: item.title,
                subtitle: subtitle,
                strapline: item.strapline,
                synopsis: item.synopsis,
                badges: item.badges,
                tiers: item.tier,
                broadcastDateTime: nil,
                latestBroadcastDateTime: nil,
                duration: nil,
                brandSummary: item.brand.map { BrandSummaryDisplay(title: $0.title, imageURLString: $0.imageUrl) }
            )

        case let .film(item):
            let subtitle: String? = item.episodeNumber.map { String(localized: "Episode \($0)") }
            return ContentItemDisplay(
                id: item.id,
                imageURLString: item.imageUrl,
                badgeText: item.badges.first,
                tierText: item.tier.first,
                title: item.title,
                subtitle: subtitle,
                strapline: item.strapline,
                synopsis: item.synopsis,
                badges: item.badges,
                tiers: item.tier,
                broadcastDateTime: item.broadcastDateTime,
                latestBroadcastDateTime: nil,
                duration: item.duration,
                brandSummary: item.brand.map { BrandSummaryDisplay(title: $0.title, imageURLString: $0.imageUrl) }
            )

        case let .page(item):
            return ContentItemDisplay(
                id: item.id ?? "page-unknown",
                imageURLString: item.imageUrl,
                badgeText: nil,
                tierText: nil,
                title: item.title,
                subtitle: item.subtitle,
                strapline: item.strapline,
                synopsis: nil,
                badges: [],
                tiers: [],
                broadcastDateTime: nil,
                latestBroadcastDateTime: nil,
                duration: nil,
                brandSummary: nil
            )

        case let .newsCategoryPageSpot(item):
            return ContentItemDisplay(
                id: item.id ?? "newscategorypagespot-unknown",
                imageURLString: nil,
                badgeText: nil,
                tierText: nil,
                title: nil,
                subtitle: nil,
                strapline: nil,
                synopsis: nil,
                badges: [],
                tiers: [],
                broadcastDateTime: nil,
                latestBroadcastDateTime: nil,
                duration: nil,
                brandSummary: nil
            )

        case let .unknown(item):
            return ContentItemDisplay(
                id: item.id ?? "unknown",
                imageURLString: nil,
                badgeText: nil,
                tierText: nil,
                title: nil,
                subtitle: nil,
                strapline: nil,
                synopsis: nil,
                badges: [],
                tiers: [],
                broadcastDateTime: nil,
                latestBroadcastDateTime: nil,
                duration: nil,
                brandSummary: nil
            )
        }
    }
}

