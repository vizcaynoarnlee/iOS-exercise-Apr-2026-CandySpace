//
//  ViewState.swift
//  CandySpace
//
//  Created by Arnlee Vizcayno on 4/22/26.
//


import Foundation

enum ViewState: Equatable {
    case initial
    case loading
    case loaded
    case error(Error)

    static func == (lhs: ViewState, rhs: ViewState) -> Bool {
        switch (lhs, rhs) {
        case (.initial, .initial), (.loading, .loading), (.loaded, .loaded):
            return true

        // Compare error description if necessary
        case (.error(_), .error(_)):
            return true

        default:
            return false
        }
    }
}
