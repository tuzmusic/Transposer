//
//  KeyPickerScreenUITests.swift
//  TransposerUITests
//
//  Created by Jonathan Tuzman on 7/13/18.
//  Copyright © 2018 Jonathan Tuzman. All rights reserved.
//

import XCTest
@testable import Transposer

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
		
		let keyPickerVC = KeyPickerViewController()
		let tablesQuery = XCUIApplication().tables
		tablesQuery/*@START_MENU_TOKEN@*/.buttons["Cb"]/*[[".cells.buttons[\"Cb\"]",".buttons[\"Cb\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
		XCTAssertEqual(keyPickerVC.fromKey.name, "Cb")
		tablesQuery/*@START_MENU_TOKEN@*/.buttons["Gb"]/*[[".cells.buttons[\"Gb\"]",".buttons[\"Gb\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
		XCTAssertEqual(keyPickerVC.fromKey.name, "Gb")
		tablesQuery/*@START_MENU_TOKEN@*/.buttons["Db"]/*[[".cells.buttons[\"Db\"]",".buttons[\"Db\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
		XCTAssertEqual(keyPickerVC.fromKey.name, "Db")

		


		// Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
