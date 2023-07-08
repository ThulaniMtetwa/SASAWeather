//
//  WeatherRepositoryTests.swift
//  SASSAWeatherTests
//
//  Created by Thulani Mtetwa on 2023/07/08.
//

import XCTest
@testable import SASSAWeather

final class WeatherRepositoryTests: XCTestCase {

    var systemUnderTest: WeatherRepositoryProtocol!
    
    override func setUp() {
        super.setUp()
        systemUnderTest = WeatherRepository(apiService: APIRequestProtocolMock())
    }
    
    override func tearDown() {
        super.tearDown()
    }
}
