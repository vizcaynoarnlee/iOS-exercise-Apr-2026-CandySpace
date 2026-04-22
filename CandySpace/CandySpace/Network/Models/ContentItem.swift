//
//  ContentItem.swift
//  CandySpace
//
//  Created by Arnlee Vizcayno on 4/22/26.
//

import Foundation

enum ContentItem: Codable {
    case brand(BrandItem)
    case episode(EpisodeItem)
    case series(SeriesItem)
    case film(FilmItem)
    case page(PageItem)
    case newsCategoryPageSpot(NewsCategoryPageSpotItem)
    case unknown(UnknownItem)

    private enum CodingKeys: String, CodingKey {
        case type
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decodeIfPresent(String.self, forKey: .type)

        switch type {
        case "brand":
            self = .brand(try BrandItem(from: decoder))
        case "episode":
            self = .episode(try EpisodeItem(from: decoder))
        case "series":
            self = .series(try SeriesItem(from: decoder))
        case "film":
            self = .film(try FilmItem(from: decoder))
        case "page":
            self = .page(try PageItem(from: decoder))
        case "newscategorypagespot":
            self = .newsCategoryPageSpot(try NewsCategoryPageSpotItem(from: decoder))
        default:
            self = .unknown(try UnknownItem(from: decoder))
        }
    }

    func encode(to encoder: Encoder) throws {
        switch self {
        case let .brand(value):
            try value.encode(to: encoder)
        case let .episode(value):
            try value.encode(to: encoder)
        case let .series(value):
            try value.encode(to: encoder)
        case let .film(value):
            try value.encode(to: encoder)
        case let .page(value):
            try value.encode(to: encoder)
        case let .newsCategoryPageSpot(value):
            try value.encode(to: encoder)
        case let .unknown(value):
            try value.encode(to: encoder)
        }
    }
}

// MARK: - Item Models

struct BrandItem: Codable {
    let id: String
    let type: String
    let title: String
    let strapline: String?
    let imageUrl: String?
    let categories: [String]?
    let genres: [String]?
    let subgenres: [String]?
    let badges: [String]
    let accessibility: AccessibilityInfo
    let tier: [String]
    let contentOwner: String?
    let synopsis: String?
    let latestBroadcastDateTime: String?
}

struct EpisodeItem: Codable {
    let id: String
    let type: String
    let title: String
    let strapline: String?
    let imageUrl: String?
    let badges: [String]
    let broadcastDateTime: String?
    let episodeNumber: Int?
    let duration: String?
    let brand: BrandSummary?
    let tier: [String]
    let synopsis: String?
    let accessibility: AccessibilityInfo
}

struct SeriesItem: Codable {
    let id: String
    let type: String
    let seriesNumber: Int?
    let title: String
    let strapline: String?
    let imageUrl: String?
    let badges: [String]
    let productionYear: Int?
    let brand: BrandSummary?
    let tier: [String]
    let accessibility: AccessibilityInfo
    let synopsis: String?
}

struct FilmItem: Codable {
    let id: String
    let type: String
    let title: String
    let strapline: String?
    let imageUrl: String?
    let badges: [String]
    let broadcastDateTime: String?
    let episodeNumber: Int?
    let duration: String?
    let brand: BrandSummary?
    let tier: [String]
    let synopsis: String?
    let accessibility: AccessibilityInfo
}

struct PageItem: Codable {
    let id: String?
    let type: String
    let title: String
    let subtitle: String?
    let strapline: String?
    let imageUrl: String?
    let adServed: Bool?
    let category: String?
}

struct NewsCategoryPageSpotItem: Codable {
    let id: String?
    let type: String
    let raw: RawItem?
}

struct UnknownItem: Codable {
    let id: String?
    let type: String?
}

// MARK: - Shared Supporting Models

struct AccessibilityInfo: Codable {
    let subtitled: Bool
    let audioDescribed: Bool
    let signed: Bool
}

struct BrandSummary: Codable {
    let id: String
    let title: String
    let imageUrl: String?
    let categories: [String]?
    let genres: [String]?
    let subgenres: [String]?
    let synopsis: String?
}

struct RawItem: Codable {
    let itemType: String?
}
