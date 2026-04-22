import Testing
@testable import CandySpace

struct MediaRequestEndpointTests {
    @Test
    func getMedia_hasExpectedPathAndMethod() throws {
        let endpoint: MediaRequestEndpoint = .getMedia

        #expect(endpoint.method == .GET)
        #expect(endpoint.path == "b/69df608e36566621a8b675e1")
    }
}

