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
	
	func separateComponents(in string: String) -> [String] {
		let separators = [" ", "\t"]
		let allCharacters = Array(string).map{String($0)}
		var components = [String]()
		var currentComponent: String = ""
		
		for character in allCharacters {
			guard !currentComponent.isEmpty else { currentComponent = character; continue}
			if separators.contains(character) { // if this character is a separator
				if currentComponent.hasSuffix(character) {  // if we're in a string of the same separator, continue the string
					currentComponent += character
				} else { // if we've been in a string of letters (or anything else) but now we have a separator, store the current component and start a new one
					components.append(currentComponent)
					currentComponent = character
				}
			} else { // if this character is not a separator (and the component is not empty)...
				if let last = currentComponent.last, separators.contains(String(last)) {  // if this is a new string, after a separator
					components.append(currentComponent)
					currentComponent = character
				} else {
					currentComponent += character
				}
			}
		}
		components.append(currentComponent) // tack on the final component.
		return components
	}
	
//	func testSmallerComponents() {
//		XCTAssertEqual("Hello there".separateComponents().count, 3)
//		XCTAssertEqual("\t\tHello".separateComponents().count, 2)
//		XCTAssertEqual("    Hello \t\t".separateComponents().count, 4)
//	}
	
	
	
	let simpleTestString = "C F G7 | Bb C | Em/G"
	let gmaj = Key("G")!
	let cmaj = Key("C")!
	
	func testSlashStart() {
		let str = "/A#"
		XCTAssertTrue(str.looksLikeMusic)
		XCTAssertTrue(str.isMusicLine_byCount)
	}
	
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
		XCTAssertEqual("Chorus".isMusic, .defNot)
		XCTAssertEqual("Chorus".looksLikeMusic, false)
	}
	
	func testStringIsPartScore() {
		let probSym = "||:"
		let form = "Chorus"
		let probNotSym = "Verse"
		let maybeChord = "Cm"
		let probChord = "C#"
		let probWord = "Absolutely"
		XCTAssertEqual(maybeChord.isMusic, .maybe)
		XCTAssertEqual(probWord.isMusic, .maybe)
		XCTAssertEqual(probChord.isMusic, .probably)
		XCTAssertEqual(probSym.isMusic, .probably)
		XCTAssertEqual(form.isMusic, .defNot)
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
