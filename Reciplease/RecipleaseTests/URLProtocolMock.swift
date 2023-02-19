//
//  URLProtocolMock.swift
//  RecipleaseTests
//
//  Created by Marc-Antoine BAR on 2023-02-07.
//

import Foundation

final class URLProtocolMock: URLProtocol {
    // swiftlint:disable large_tuple
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse?, Data?, Error?))?
    override class func canInit(with request: URLRequest) -> Bool { true }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }
    override func startLoading() {
        guard let handler = URLProtocolMock.requestHandler else {
            fatalError("Handler is unavailable.")
        }
        do {
            let (response, data, error) = try handler(request)
            if let response {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            if let data {
                client?.urlProtocol(self, didLoad: data)
            }
            if let error {
                client?.urlProtocol(self, didFailWithError: error)
            }
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    override func stopLoading() { }
}
