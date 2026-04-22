import Testing
@testable import CandySpace

private struct TestEndpoint: EndpointProtocol {
    let path: String
    let method: EndpointMethod
}

struct EndpointProtocolTests {
    @Test
    func defaultQueryAndBody_areNil() throws {
        let endpoint: TestEndpoint = TestEndpoint(path: "test", method: .GET)

        #expect(endpoint.urlQueryItems == nil)
        #expect(endpoint.jsonParameters == nil)
    }
}

