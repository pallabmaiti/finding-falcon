//
//  ServerMock.swift
//  FindingFalconeTests
//
//  Created by Pallab Maiti on 14/03/24.
//

import Foundation

class URLProtocolMock: URLProtocol {
    var serverMock: ServerMock?
    
    override init(request: URLRequest, cachedResponse: CachedURLResponse?, client: URLProtocolClient?) {
        serverMock = ServerMock.instance
        super.init(request: request, cachedResponse: cachedResponse, client: client)
    }
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let response = serverMock?.response {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        
        if let data = serverMock?.data {
            client?.urlProtocol(self, didLoad: data)
        }
        
        if let error = serverMock?.error {
            client?.urlProtocol(self, didFailWithError: error)
        }
        
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
        
    }
}

class ServerMock {
    let response: HTTPURLResponse?
    let data: Data?
    let error: NSError?
    static var instance: ServerMock?
    
    enum ServerResult {
        case success(response: HTTPURLResponse, data: Data = .mockAny())
        case failure(error: NSError)
    }
    
    init(serverResult: ServerResult) {
        switch serverResult {
        case .success(let response, let data):
            self.response = response
            self.data = data
            self.error = nil
        case .failure(let error):
            self.response = nil
            self.data = nil
            self.error = error
        }
        Self.instance = self
    }
    
    func getInterceptedURLSession(delegate: URLSessionDelegate? = nil) -> URLSession {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolMock.self]
        return URLSession(configuration: configuration, delegate: delegate, delegateQueue: nil)
    }
}
