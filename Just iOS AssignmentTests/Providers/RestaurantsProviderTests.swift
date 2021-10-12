//
//  RestaurantsProviderTests.swift
//  Just iOS AssignmentTests
//
//  Created by Ghalaab on 12/10/2021.
//

import XCTest
@testable import Just_iOS_Assignment

class RestaurantsProviderTests: XCTestCase {
    
    func testRestaurantsData_whenTheJsonFileIsNotEmpty() {
        let provider: RestaurantsProviding = RestaurantsProvider(
            resourceName: "testRestaurants", bundle: Bundle(for: DataDecoderTests.self))
        XCTAssertTrue(provider.restaurants().count == 3)
    }
    
    func testRestaurantsData_whenTheJsonFileIsEmpty() {
        let provider: RestaurantsProviding = RestaurantsProvider(
            resourceName: "emptyRestaurants", bundle: Bundle(for: DataDecoderTests.self))
        XCTAssertTrue(provider.restaurants().isEmpty)
    }
    
    func test_whenJsonResourceIsNotExist() {
        let provider: RestaurantsProviding = RestaurantsProvider(
            resourceName: "notExistFile", bundle: Bundle(for: DataDecoderTests.self))
        XCTAssertTrue(provider.restaurants().isEmpty)
    }
    
    func testProvider_whenDecodingFailed() {
        let provider: RestaurantsProviding = RestaurantsProvider(
            dataDecoder: FailedDataDecoderMock(),
            resourceName: "testRestaurants",
            bundle: Bundle(for: DataDecoderTests.self))
        XCTAssertTrue(provider.restaurants().isEmpty)
    }
}

private struct FailedDataDecoderMock: DataDecoding {
    func decodeModel<C: Decodable>(from data: Data) throws -> C {
        throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: ""))
    }
}
