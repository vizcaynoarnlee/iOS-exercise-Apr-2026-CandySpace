import Testing
@testable import CandySpace

struct MediaRepositoryTests {
    @Test
    func fetchMedia_usesGetMediaEndpoint() async throws {
        let section: Section = Section(
            id: "sec1",
            name: "Section",
            type: .rail,
            priority: "1",
            displayType: nil,
            platformDisplayType: nil,
            destination: nil,
            collection: TestFixtures.collectionInfo(aspectRatio: .twoByThree, itemCount: 0),
            items: []
        )
        let expectedMedia: Media = TestFixtures.media(sections: [section])

        let apiClient: APIClientSpy = APIClientSpy(media: expectedMedia)
        let repository: MediaRepository = MediaRepository(apiClient: apiClient)

        let media: Media = try await repository.fetchMedia()

        #expect(media.record.sections.first?.id == "sec1")
        #expect(apiClient.getEndpoints.count == 1)
        #expect((apiClient.getEndpoints.first as? MediaRequestEndpoint) == .getMedia)
    }
}

