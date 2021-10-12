//
//  DataDecoderTests.swift
//  Just iOS AssignmentTests
//
//  Created by Ghalaab on 12/10/2021.
//

import XCTest
@testable import Just_iOS_Assignment

class DataDecoderTests: XCTestCase {

    func testDecoding_whenTheJsonIsValid() {
        let dataDecoder: DataDecoding = DataDecoder()
        
        let expectedRestaurants = [
            Restaurant(id: "0", name: "Test0", status: .open, sortingValues: [:]),
            Restaurant(id: "1", name: "Test1", status: .open, sortingValues: [:]),
            Restaurant(id: "2", name: "Test2", status: .open, sortingValues: [:]),
            Restaurant(id: "3", name: "Test3", status: .open, sortingValues: [:])
        ]
        
        var expectedData: Data!
        
        do {
            // converting expectedRestaurants into data then check if the decoder decode this data.
            expectedData = try JSONEncoder().encode(expectedRestaurants)
            let restaurants: [Restaurant] = try dataDecoder.decodeModel(from: expectedData)
            XCTAssertEqual(restaurants, expectedRestaurants)
        } catch  {
            XCTFail("Shouldn't have called")
        }
    }
    
    func testDecoding_whenTheJsonIsInvalid() {
        let dataDecoder: DataDecoding = DataDecoder()
        var expectedData: Data!
        
        do {
            expectedData = try JSONEncoder().encode(["any data":"021"])
        } catch  {
            XCTFail("Shouldn't have called")
        }
        do {
            let _: [Restaurant] = try dataDecoder.decodeModel(from: expectedData)
            XCTFail("Shouldn't have called")
        } catch{
            XCTAssert(true)
        }
    }

}
