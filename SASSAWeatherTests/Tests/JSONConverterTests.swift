//
//  JSONConverterTests.swift
//  SASSAWeatherTests
//
//  Created by Thulani Mtetwa on 2023/07/08.
//

import XCTest
@testable import SASSAWeather

final class JSONConverterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }

    func testDecodingSuccessful() {
        //Given
        guard let path = Bundle(for: type(of: self)).url(forResource: "weather_response", withExtension: "json") else {
            XCTFail("Failed to load weather_response json")
            return
        }
        do {
            let data = try Data(contentsOf: path)
            
            //When
            let result: Weather? = try JSONConverter.decode(data)
            
            //Then
            XCTAssertNotNil(result)
        } catch {
            XCTFail("an unexpected error")
        }
    }
    
    func testDecodingThrowsAnError() throws {
        //Given
        let data = Data()
        do {
            //When
            let _: Weather? = try JSONConverter.decode(data)
        } catch {
            //Then
            XCTAssertEqual(error as? NetworkError, NetworkError.invalidResponse)
        }
    }
    
    override func tearDown() {
        super.tearDown()
    }

}
