//
//  PomangamiOSTests.swift
//  PomangamiOSTests
//
//  Created by 최민섭 on 04/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import XCTest
@testable import PomangamiOS

class PomangamiOSTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
    
    func testReduceFunctionWithIndex() {
        let strings = "17000"
        let ss = strings.reversed().enumerated().reduce("") { (acc, curr) in
        return String(curr.element) + String(curr.offset%3 == 0 ? "," : "")  + String(acc)
        }
        
        print(String(ss.dropLast()))
    }
}
