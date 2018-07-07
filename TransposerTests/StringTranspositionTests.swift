//
//  StringTranspositionTests.swift
//  TransposerTests
//
//  Created by Jonathan Tuzman on 6/17/18.
//  Copyright © 2018 Jonathan Tuzman. All rights reserved.
//

import XCTest
@testable import Transposer

class StringTranspositionTests: XCTestCase {

	let simpleTestString = "C F G7 | Bb C | Em/G"
	let gmaj = Key("G")!
	let cmaj = Key("C")!

	func testStringDivision() {
		let components = simpleTestString.split(separator:" ")
		Xtest(components.count, 8)
		
		let c_to_g = "G C D7 | F G | Bm/D"
		
		let result = simpleTestString.transpose(fromString:"C", toString:"G")
		
		Xtest(result, c_to_g)
		
	}
	
}
