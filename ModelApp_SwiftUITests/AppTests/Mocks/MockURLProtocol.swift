//
//  MockURLProtocol.swift
//  ModelApp_SwiftUITests
//
//  Created by Santhosh K on 06/03/26.
//

import Foundation


class MockURLProtocol : URLProtocol {
    
    static var mockData:Data?
    static var mockResponse:HTTPURLResponse?
    static var mockError:Error?
    
    // NEW: capture the request
      static var lastRequest: URLRequest?
    
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
         request
    }
    
    
    override func startLoading() {
        
        // Capture request
            MockURLProtocol.lastRequest = request
        
        if let error = MockURLProtocol.mockError {
            client?.urlProtocol(self, didFailWithError: error)
            return
        }
        
        if let response = MockURLProtocol.mockResponse {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        
        if let data = MockURLProtocol.mockData {
            client?.urlProtocol(self, didLoad: data)
        }
        
        client?.urlProtocolDidFinishLoading(self)
        
    }
    
    override func stopLoading() { }

    
    
}
