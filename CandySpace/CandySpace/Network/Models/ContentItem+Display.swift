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
                tierText: item.tier.first
            )

        case let .episode(item):
            return ContentItemDisplay(
                id: item.id,
                imageURLString: item.imageUrl,
                badgeText: item.badges.first,
                tierText: item.tier.first
            )

        case let .series(item):
            return ContentItemDisplay(
                id: item.id,
                imageURLString: item.imageUrl,
                badgeText: item.badges.first,
                tierText: item.tier.first
            )

        case let .film(item):
            return ContentItemDisplay(
                id: item.id,
                imageURLString: item.imageUrl,
                badgeText: item.badges.first,
                tierText: item.tier.first
            )

        case let .page(item):
            return ContentItemDisplay(
                id: item.id ?? "page-unknown",
                imageURLString: item.imageUrl,
                badgeText: nil,
                tierText: nil
            )

        case let .newsCategoryPageSpot(item):
            return ContentItemDisplay(
                id: item.id ?? "newscategorypagespot-unknown",
                imageURLString: nil,
                badgeText: nil,
                tierText: nil
            )

        case let .unknown(item):
            return ContentItemDisplay(
                id: item.id ?? "unknown",
                imageURLString: nil,
                badgeText: nil,
                tierText: nil
            )
        }
    }
}

