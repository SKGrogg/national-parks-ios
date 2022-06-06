//
//  ParkServiceTests.swift
//  NationalParksTests
//
//  Created by Sean Grogg on 4/22/22.
//

import XCTest
@testable import NationalParks

class ParkServiceTests: XCTestCase {
    
    var systemUnderTest: ParkService!

    override func setUp() {
        self.systemUnderTest = ParkService()
    }

    override func tearDown() {
        
        self.systemUnderTest = nil
    }
    
    func testAPI_returnsSuccessfulResult() {
        //given
        var parks: [Park]!
        var error: Error?
        
        let promise = expectation(description: "Completion handler is invoked")
        
        //when
        self.systemUnderTest.getParks(completion: { data, shouldntHappen in
            parks = data
            error = shouldntHappen
            promise.fulfill()
        })
        wait(for: [promise], timeout: 5)
        
        
        //then
        XCTAssertNotNil(parks)
        XCTAssertNil(error)
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
