//
//  TabRouterProtocol.swift
//  CandySpace
//
//  Created by Arnlee Vizcayno on 4/22/26.
//

import Foundation
internal import Combine

protocol TabRouterProtocol: ObservableObject {
    var tabs: [TabType] { get }
    var selectedIndex: Int { get }

    func switchTab(_ tab: TabType)
}

final class TabRouter: TabRouterProtocol {
    let tabs: [TabType] = [
        .cards,
        .profile,
    ]
    @Published var selectedIndex: Int = 0

    func switchTab(_ tab: TabType) {
        selectedIndex = tab.id
    }
}
