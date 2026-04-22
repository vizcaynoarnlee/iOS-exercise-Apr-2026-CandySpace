import Foundation
@testable import CandySpace

final class APIClientSpy: APIClientProtocol {
    let baseURLString: String = "https://example.com/"

    private(set) var getEndpoints: [EndpointProtocol] = []
    private let media: Media

    init(media: Media) {
        self.media = media
    }

    func get<T>(endpoint: EndpointProtocol) async throws -> T where T: Codable {
        getEndpoints.append(endpoint)

        guard let value: T = media as? T else {
            throw APIClientError.invalidJsonDecoding
        }
        return value
    }

    func getArray<T>(endpoint: EndpointProtocol) async throws -> [T] where T: Codable {
        getEndpoints.append(endpoint)
        return []
    }
}

