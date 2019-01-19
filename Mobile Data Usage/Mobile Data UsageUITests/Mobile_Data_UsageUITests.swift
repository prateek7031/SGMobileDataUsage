//
//  Mobile_Data_UsageUITests.swift
//  Mobile Data UsageUITests
//
//  Created by Prateek on 19/1/19.
//  Copyright © 2019 Personal. All rights reserved.
//

import XCTest

class Mobile_Data_UsageUITests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testMobileDataContentLoaded() {
        let app = XCUIApplication()
        XCTAssertNotNil(app.tables.cells.count, "Mobile Data Loaded. Data Not Empty")
    }
    
    
    func testSampleMobileDataUnFold() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        let totalVolume2018TbaCellsQuery = tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Total Volume 2018 → TBA")/*[[".cells.containing(.staticText, identifier:\"2018\")",".cells.containing(.staticText, identifier:\"-\")",".cells.containing(.staticText, identifier:\"2.0025\")",".cells.containing(.staticText, identifier:\"18.4737\")",".cells.containing(.staticText, identifier:\"0.6947\")",".cells.containing(.staticText, identifier:\"16.4712\")",".cells.containing(.staticText, identifier:\"500\")",".cells.containing(.staticText, identifier:\"2.6972\")",".cells.containing(.staticText, identifier:\"Total Volume 2018 → TBA\")"],[[[-1,8],[-1,7],[-1,6],[-1,5],[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        totalVolume2018TbaCellsQuery.children(matching: .staticText).matching(identifier: "2018").element(boundBy: 1).tap()
        totalVolume2018TbaCellsQuery.children(matching: .staticText).matching(identifier: "2.6972").element(boundBy: 0).tap()
        
    }
    
    func testSampleMobileDataScroll() {
        let tablesQuery = XCUIApplication().tables
        let totalVolume2018TbaCellsQuery = tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Total Volume 2018 → TBA")/*[[".cells.containing(.staticText, identifier:\"2018\")",".cells.containing(.staticText, identifier:\"-\")",".cells.containing(.staticText, identifier:\"2.0025\")",".cells.containing(.staticText, identifier:\"18.4737\")",".cells.containing(.staticText, identifier:\"0.6947\")",".cells.containing(.staticText, identifier:\"16.4712\")",".cells.containing(.staticText, identifier:\"500\")",".cells.containing(.staticText, identifier:\"2.6972\")",".cells.containing(.staticText, identifier:\"Total Volume 2018 → TBA\")"],[[[-1,8],[-1,7],[-1,6],[-1,5],[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        totalVolume2018TbaCellsQuery.staticTexts["Total Volume"].swipeDown()
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Q2 ↓")/*[[".cells.containing(.staticText, identifier:\"2011\")",".cells.containing(.staticText, identifier:\"0.3642\")",".cells.containing(.staticText, identifier:\"0.3331\")",".cells.containing(.staticText, identifier:\"3.7138\")",".cells.containing(.staticText, identifier:\"-0.0855\")",".cells.containing(.staticText, identifier:\"3.3807\")",".cells.containing(.staticText, identifier:\"0.1292\")",".cells.containing(.staticText, identifier:\"3.4662\")",".cells.containing(.staticText, identifier:\"4.0780\")",".cells.containing(.staticText, identifier:\"Total Volume 2011 →  4.0780\")",".cells.containing(.staticText, identifier:\"0.7410\")",".cells.containing(.staticText, identifier:\"Q2 ↓\")"],[[[-1,11],[-1,10],[-1,9],[-1,8],[-1,7],[-1,6],[-1,5],[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .staticText).matching(identifier: "2011").element(boundBy: 1).swipeUp()
    }
    
}
