import Foundation
@testable import CandySpace

final class MediaRepositoryStub: MediaRepositoryProtocol {
    private let media: Media

    init(media: Media) {
        self.media = media
    }

    func fetchMedia() async throws -> Media {
        media
    }
}

