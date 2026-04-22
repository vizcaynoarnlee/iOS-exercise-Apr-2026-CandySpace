//
//  Untitled.swift
//  CandySpace
//
//  Created by Arnlee Vizcayno on 4/22/26.
//

import Foundation

struct Media: Codable {
    let record: Record
    let metadata: Metadata
}

struct Record: Codable {
    let page: PageInfo
    let sections: [Section]
}

struct Metadata: Codable {
    let id: String
    let `private`: Bool
    let createdAt: String
    let name: String
}

struct PageInfo: Codable {
    let id: String
    let name: String?
    let imageUrl: String?
    let adServed: Bool
}
