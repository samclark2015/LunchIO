//
//  LunchIOTests.swift
//  LunchIOTests
//
//  Created by Sam Clark on 8/26/16.
//  Copyright © 2016 Sam Clark. All rights reserved.
//

import XCTest
@testable import LunchIO

class LunchIOTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
	
	func testLogin(){
		User.login(email: "slc2015@icloud.com", password: "12345") {
			(user, err) in
			if(err != nil){ XCTAssert(false, err as! String)} else {XCTAssert(true)}
		}
	}
    
}
