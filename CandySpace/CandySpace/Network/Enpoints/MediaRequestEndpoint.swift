//
//  MediaRequestEndpoint.swift
//  CandySpace
//
//  Created by Arnlee Vizcayno on 4/22/26.
//


import Foundation

enum MediaRequestEndpoint: EndpointProtocol {
    case getMedia
    
    var path: String {
        switch self {
        case .getMedia:
            return "b/69df608e36566621a8b675e1"
        }
    }
    
    var method: EndpointMethod {
        .GET
    }
}
