//
//  TransposerUITests.swift
//  TransposerUITests
//
//  Created by Jonathan Tuzman on 6/13/18.
//  Copyright © 2018 Jonathan Tuzman. All rights reserved.
//

import XCTest

class TransposerUITests: XCTestCase {
	
	var app: XCUIApplication!
	
	override func setUp() {
		super.setUp()
		
		// Put setup code here. This method is called before the invocation of each test method in the class.
		
		// In UI tests it is usually best to stop immediately when a failure occurs.
		continueAfterFailure = false
		// UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
		app = XCUIApplication()
		app.launch()
		
		// In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
		
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	func testTransposeButton() {

		let tablesQuery = app.tables
		let transposeButton = tablesQuery/*@START_MENU_TOKEN@*/.buttons["Transpose"]/*[[".cells.buttons[\"Transpose\"]",".buttons[\"Transpose\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
		//let sourceView = XCUIApplication().tables.children(matching: .cell).element(boundBy: 0).children(matching: .textView).element
		let destView = XCUIApplication().tables.children(matching: .cell).element(boundBy: 2).children(matching: .textView).element

		//let input = "C F G7 | Bb C | Em/G"
		let expected = "G C D7 | F G | Bm/D"	
		
		transposeButton.tap()
		
		XCTAssertEqual(expected, destView.value as? String)
		
	}
	
	func testExample() {
		// Use recording to get started writing UI tests.
		// Use XCTAssert and related functions to verify your tests produce the correct results.
		
	}
	
}
