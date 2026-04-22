import Foundation
@testable import CandySpace

final class URLProtocolStub: URLProtocol {
    struct Stub {
        let data: Data
        let statusCode: Int
        let headers: [String: String]
    }

    static var stub: Stub?

    override class func canInit(with request: URLRequest) -> Bool {
        true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {
        guard let stub = URLProtocolStub.stub else {
            client?.urlProtocol(self, didFailWithError: URLError(.badServerResponse))
            return
        }

        guard let url = request.url ?? URL(string: "https://example.com/") else {
            client?.urlProtocol(self, didFailWithError: URLError(.badURL))
            return
        }
        let response: HTTPURLResponse? = HTTPURLResponse(
            url: url,
            statusCode: stub.statusCode,
            httpVersion: "HTTP/1.1",
            headerFields: stub.headers
        )

        if let response {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        client?.urlProtocol(self, didLoad: stub.data)
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}
}

