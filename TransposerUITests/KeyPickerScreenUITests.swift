//
//  KeyPickerScreenUITests.swift
//  TransposerUITests
//
//  Created by Jonathan Tuzman on 7/13/18.
//  Copyright © 2018 Jonathan Tuzman. All rights reserved.
//

import XCTest

class KeyPickerScreenUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
		
		
		let kCellsQuery = XCUIApplication().tables.cells.containing(.button, identifier:"K#")
		kCellsQuery.children(matching: .button).matching(identifier: "K#").element(boundBy: 15).tap()
		kCellsQuery.children(matching: .button).matching(identifier: "K#").element(boundBy: 0).tap()
		kCellsQuery.children(matching: .button).matching(identifier: "K#").element(boundBy: 1).tap()
		kCellsQuery.children(matching: .button).matching(identifier: "K#").element(boundBy: 2).tap()
		kCellsQuery.children(matching: .button).matching(identifier: "K#").element(boundBy: 3).tap()
		kCellsQuery.children(matching: .button).matching(identifier: "K#").element(boundBy: 4).tap()
		kCellsQuery.children(matching: .button).matching(identifier: "K#").element(boundBy: 5).tap()
		kCellsQuery.children(matching: .button).matching(identifier: "K#").element(boundBy: 6).tap()
		
		
//		fromButton[0].tap()
//		XCTAssertEqual(keyPickerVC.fromKey, Key("C"))

		// Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
