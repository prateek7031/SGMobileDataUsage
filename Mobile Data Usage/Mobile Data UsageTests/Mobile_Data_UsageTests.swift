//
//  Mobile_Data_UsageTests.swift
//  Mobile Data UsageTests
//
//  Created by Prateek on 19/1/19.
//  Copyright © 2019 Personal. All rights reserved.
//

import XCTest

class Mobile_Data_UsageTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testGetMobileDataAPIInput() {
        let record1 = Record(fromDictionary: ["volume_of_mobile_data": "16.47121", "quarter": "2018-Q1", "_id": 55])
        let record2 = Record(fromDictionary: ["volume_of_mobile_data": "18.47368", "quarter": "2018-Q2", "_id": 56])
        
        
        let yRecord = YearRecord(fromRecord: record1)
        yRecord.addRecord(fromRecord: record2)
        
        XCTAssertEqual(yRecord.q1Total, "16.4712", "Total Volume Data : 16.4712")
        
    }
    
    func testMobileDataLoadQuickly() {
        measure {
            _ = API()
        }
    }
    
}
