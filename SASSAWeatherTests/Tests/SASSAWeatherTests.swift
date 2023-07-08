//
//  SASSAWeatherTests.swift
//  SASSAWeatherTests
//
//  Created by Thulani Mtetwa on 2023/07/07.
//

import XCTest
@testable import SASSAWeather
enum APIResponseError: Error {
    case badUsername
    case badPassword
    case request
}
final class SASSAWeatherTests: XCTestCase {
    
    var expectation: XCTestExpectation!
    let apiURL = URL(string: "https://run.mocky.io/v3/1fd068d7-cbb2-4ceb-b697-da7fcc1c520b")!
    var session: URLSession!
    
    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolMock.self]
        session = URLSession.init(configuration: configuration)
        expectation = expectation(description: "Expectation")
    }
    
    func testSuccessful() {
        
        SASSAWeatherNetworkMock().getWeather()
        let json = """
{
   "forecasts":[
      {
         "date":"2020-11-05T22:00:00.000+0000",
         "temp":20.0,
         "humidity":30,
         "windSpeed":300,
         "safe":true
      }
   ],
   "lastUpdated": "2020-11-07T22:00:00.000+0000",
   "weatherStation": "NASA Mars North Weather Station"
}
"""
        
        let data = json.data(using: .utf8)
        
        URLProtocolMock.requestHandler = { request in
            guard let url = request.url, url == self.apiURL else {
                throw APIResponseError.request
            }
            
            let response = HTTPURLResponse(url: self.apiURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        
        NetworkManager.sharedInstance.getWeatherDetails(session, using: { response in
            switch response {
            case .success(let success):
                let object = try? JSONDecoder().decode(Weather.self, from: success.data)
                XCTAssertNotNil(object)
            case .failure(let failure):
                XCTFail("Error was not expected: \(failure)")
            }
            self.expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1.0)
    }
    
    override class func tearDown() {
        super.tearDown()
    }
}

final class SASSAWeatherNetworkMock: TestDataGenerator {
    func getWeather() {
        dump(loadJSON(filename: "weather_response", type: Weather.self))
    }
}
