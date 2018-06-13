//
//  TransposerTests.swift
//  TransposerTests
//
//  Created by Jonathan Tuzman on 6/13/18.
//  Copyright © 2018 Jonathan Tuzman. All rights reserved.
//

import XCTest
@testable import Transposer

class TransposerTests: XCTestCase {
    
	override func setUp() {
		super.setUp()
		let eMaj = Key("E major")!
		let dflatMaj = Key("Db major")!
		let gMaj = Key("G major")!
		let csMaj = Key("C# major")!
		let _ = [eMaj, dflatMaj, csMaj, gMaj]		
	}
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testOrderOfSharps() {
		let accsInOrder = Music.circleOfFifthsKeys
			.map { Music.newAcc3(in: $0)?.name! ?? "" }
			.joined(separator: " ")
		XCTAssertEqual(accsInOrder, TestConstants.orderOfAccidentals)
		
		let sharpsInEMajString = eMaj.keySig.map{$0.name}.joined(separator: " ")
		let expected = "F# C# G# D#"
		XCTAssertEqual(sharpsInEMajString, expected)
	}
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
