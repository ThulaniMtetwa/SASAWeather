//
//  URLProtocolMock.swift
//  SASSAWeatherTests
//
//  Created by Thulani Mtetwa on 2023/07/07.
//

import Foundation

class URLProtocolMock: URLProtocol {
    
    typealias MockResponseData = (HTTPURLResponse, Data?)
    
    static var requestHandler: ((URLRequest) throws -> MockResponseData)?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        
        guard let handler = URLProtocolMock.requestHandler else {
            fatalError("Request handler is unavailable or nil.")
          }
        
        do {
           let (response, data) = try handler(request)
           
           client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
           
           if let data = data {
             client?.urlProtocol(self, didLoad: data)
           }
           
           client?.urlProtocolDidFinishLoading(self)
         } catch {
           client?.urlProtocol(self, didFailWithError: error)
         }
    }
    
    override func stopLoading() {
        
    }
}
