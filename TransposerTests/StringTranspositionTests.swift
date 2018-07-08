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
	
	func testContainsBoth() {
		XCTAssertEqual("C(#5)".isMusic, .probably) // contains, but doesn't start with, parens
		XCTAssertEqual("(Great".isMusic, .maybe) // Starts with open parens, contains no close. Should evaluate the section after the parens.
		XCTAssertEqual("(Hey".isMusic, .defNot) // same as above
		XCTAssertEqual("F#)".isMusic, .probably) // Ends with close parens, no open. Should evaluate the section before the parens.
		XCTAssertEqual("hey) ".isMusic, .defNot) // same as above
		XCTAssertEqual("(Chord)".isMusic, .maybe) // Starts with open, ends with close. Evaluate w/o parens.
	}
	
	func testSymbolsInChords() {
		let maybe1 = "A..."
		let prob1 = "C7"
		let prob2 = "D#"
		XCTAssertEqual(maybe1.isMusic, .probably)
		XCTAssertEqual(prob1.isMusic, .probably)
		XCTAssertEqual(prob2.isMusic, .probably)
		
		XCTAssertEqual("Cool!".isMusic, .defNot)
	}
	
	func testStringIsPartScore() {
		let probSym = "||:"
		let maybeSym = "Chorus"
		let probNotSym = "Verse"
		let maybeChord = "Cm"
		let probChord = "C#"
		let probWord = "Absolutely"
		XCTAssertEqual(maybeChord.isMusic, .maybe)
		XCTAssertEqual(probWord.isMusic, .maybe)
		XCTAssertEqual(probChord.isMusic, .probably)
		XCTAssertEqual(probSym.isMusic, .probably)
		XCTAssertEqual(maybeSym.isMusic, .maybe)
		XCTAssertEqual(probNotSym.isMusic, .defNot)
	}

	func testStringDivision() {
		let components = simpleTestString.split(separator:" ")
		Xtest(components.count, 8)
		
		let c_to_g = "G C D7 | F G | Bm/D"
		
		let result = simpleTestString.transpose(fromString:"C", toString:"G")
		
		Xtest(result, c_to_g)
		
	}
	
}
