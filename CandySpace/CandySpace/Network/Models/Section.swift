//
//  Section.swift
//  CandySpace
//
//  Created by Arnlee Vizcayno on 4/22/26.
//

import Foundation

struct Section: Codable, Identifiable {
    let id: String
    let name: String
    let type: SectionType
    let priority: String?
    let displayType: String?
    let platformDisplayType: String?
    let destination: String?
    let collection: CollectionInfo
    let items: [ContentItem]
}

struct CollectionInfo: Codable {
    let id: String
    let title: String?
    let itemCount: Int
    let imageTreatment: String?
    let imageAspectRatio: ImageAspectRatio?
    let imageClass: String?
    let excludeTimeDependentTags: Bool
    let adServed: Bool
    let subsequentJourney: SubsequentJourney?
}

struct SubsequentJourney: Codable {
    let label: String
    let destinationUrl: String
    let name: String
}
