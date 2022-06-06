//
//  ParkTest.swift
//  NationalParksTests
//
//  Created by Sean Grogg on 4/22/22.
//

import XCTest
@testable import NationalParks

class ParkTest: XCTestCase {


    func testParkDebugDescription(){
        //given
        let park = Park(named: "Badlands", description: "If looking for Goodlands, please keep looking.", imageURL: "https://cdn.aarp.net/content/dam/aarp/travel/Domestic/2020/07/1140-badlands-sunset.jpg", state: "SD")
        
        //when
        let actualValue = park.debugDescription
        
        //then
        
        let expectedValue = "Park(name: Badlands, description: If looking for Goodlands, please keep looking."
        
        XCTAssertEqual(actualValue, expectedValue)
    }

}
