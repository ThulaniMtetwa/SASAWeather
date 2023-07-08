//
//  SASSAWeatherTests.swift
//  SASSAWeatherTests
//
//  Created by Thulani Mtetwa on 2023/07/07.
//

import XCTest
@testable import SASSAWeather

final class SASSAWeatherTests: XCTestCase {
    
    var expectation: XCTestExpectation!
    let apiURL = URL(string: "https://run.mocky.io/v3/1fd068d7-cbb2-4ceb-b697-da7fcc1c520b")!
    var session: URLSession!
    var systemUnderTest: APIRequestProtocol!
    
    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolMock.self]
        session = URLSession.init(configuration: configuration)
        expectation = expectation(description: "Expectation")
        systemUnderTest =  NetworkManager()
    }
    
    func testSuccessfulServerResponse() throws {
        //Given
        guard let path = Bundle(for: type(of: self)).url(forResource: "weather_response", withExtension: "json") else {
            XCTFail("Failed to load weather_response json")
            return
        }
        
        do {
            let data = try Data(contentsOf: path)
            
            URLProtocolMock.requestHandler = { request in
                guard let url = request.url, url == self.apiURL else {
                    throw NetworkError.invalidURL
                }
                
                let response = HTTPURLResponse(url: self.apiURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
                return (response, data)
            }
        } catch {
            XCTFail("weather_response data contents of method throw an unexpected error")
        }
        
        //When
        systemUnderTest.getWeatherDetails(session, using: { response in
            switch response {
            case .success(let success):
                //Then
                XCTAssertNotNil(success)
            case .failure(let failure):
                XCTFail("Error was not expected: \(failure)")
            }
            self.expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testUnexpectedErrorFailureResponse() {
        //Given
        let data = Data()
        URLProtocolMock.requestHandler = { request in
          let response = HTTPURLResponse(url: self.apiURL, statusCode: 500, httpVersion: nil, headerFields: nil)!
          return (response, data)
        }
        
        //When
        systemUnderTest.getWeatherDetails(session, using: { response in
          switch response {
          case .success(_):
            XCTFail("Success response was not expected.")
          case .failure(let error):
            guard let error = error as? NetworkError else {
              XCTFail("Incorrect error received.")
              self.expectation.fulfill()
              return
            }
            //Then
            XCTAssertEqual(error, NetworkError.unexpectedStatusCode, "Fails if status code is not between 200 and 300.")
          }
          self.expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1.0)
      }
    
    override class func tearDown() {
        super.tearDown()
    }
}
