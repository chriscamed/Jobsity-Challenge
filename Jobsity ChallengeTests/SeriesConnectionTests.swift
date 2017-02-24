//
//  Jobsity_ChallengeTests.swift
//  Jobsity ChallengeTests
//
//  Created by Camilo Medina on 2/18/17.
//  Copyright © 2017 Jobsity. All rights reserved.
//

import XCTest
@testable import Jobsity_Challenge

class SeriesConnectionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSeriesConnection() {
		let asyncExpectation = expectation(description: "longRunningFunction")
		SeriesConnection().listSeries(fromServiceURL: Constants.LIST_SHOWS_BY_PAGE + "\(1)") { data in
			XCTAssert(data is [Serie], "It's not a serie")
			XCTAssertFalse(data is Error, "It's an error")
			XCTAssert(data != nil, "It's nil")
			asyncExpectation.fulfill()
		}
		
		self.waitForExpectations(timeout: 10) { error in
			
			XCTAssertNil(error, "Something went horribly wrong")
			//XCAssertEqual(testUser.orders.count, 10)
			
		}
    }
	
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
