//
//  TabType.swift
//  CandySpace
//
//  Created by Arnlee Vizcayno on 4/22/26.
//

import Foundation

enum TabType: Int, Identifiable {
    case cards = 0
    case profile

    var id: Int {
        rawValue
    }

    var title: String {
        switch self {
        case .cards:
            return String(localized: "Dashboard")
        case .profile:
            return String(localized: "Profile")
        }
    }

    var systemImage: String {
        return "square.stack"
    }
}
