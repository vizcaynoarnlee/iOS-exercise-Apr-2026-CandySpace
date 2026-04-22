import Foundation
import Testing
@testable import CandySpace

private struct MediaEndpoint: EndpointProtocol {
    let path: String = "b/anything"
    let method: EndpointMethod = .GET
}

struct APIClientTests {
    @Test
    func get_decodesMedia() async throws {
        let configuration: URLSessionConfiguration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session: URLSession = URLSession(configuration: configuration)

        URLProtocolStub.stub = URLProtocolStub.Stub(
            data: MediaJSON.validMediaResponse.data(using: .utf8) ?? Data(),
            statusCode: 200,
            headers: ["Content-Type": "application/json"]
        )

        let client: APIClient = await APIClient(urlSession: session)
        let media: Media = try await client.get(endpoint: MediaEndpoint())

        await #expect(media.record.sections.count == 1)
        await #expect(media.record.sections.first?.id == "sec1")
        await #expect(media.record.sections.first?.collection.imageAspectRatio == .twoByThree)
    }
}

private enum MediaJSON {
    static let validMediaResponse: String = """
    {
      \"record\": {
        \"page\": { \"id\": \"page1\", \"name\": null, \"imageUrl\": null, \"adServed\": false },
        \"sections\": [
          {
            \"id\": \"sec1\",
            \"name\": \"Section\",
            \"type\": \"rail\",
            \"priority\": \"1\",
            \"displayType\": null,
            \"platformDisplayType\": null,
            \"destination\": null,
            \"collection\": {
              \"id\": \"col1\",
              \"title\": null,
              \"itemCount\": 0,
              \"imageTreatment\": null,
              \"imageAspectRatio\": \"2x3\",
              \"imageClass\": null,
              \"excludeTimeDependentTags\": false,
              \"adServed\": false,
              \"subsequentJourney\": null
            },
            \"items\": []
          }
        ]
      },
      \"metadata\": {
        \"id\": \"meta1\",
        \"private\": false,
        \"createdAt\": \"2026-04-22T00:00:00Z\",
        \"name\": \"fixture\"
      }
    }
    """
}

