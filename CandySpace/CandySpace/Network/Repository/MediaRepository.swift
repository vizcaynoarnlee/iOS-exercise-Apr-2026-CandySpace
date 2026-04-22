//
//  MediaRepository.swift
//  CandySpace
//
//  Created by Arnlee Vizcayno on 4/22/26.
//

import Foundation

protocol MediaRepositoryProtocol: Sendable {
    func fetchMedia() async throws -> Media
}

final class MediaRepository: MediaRepositoryProtocol {
    private let apiClient: APIClientProtocol

    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }

    func fetchMedia() async throws -> Media {
        try await apiClient.get(endpoint: MediaRequestEndpoint.getMedia)
    }
}

