//
//  LargeStringTranspoTests.swift
//  TransposerTests
//
//  Created by Jonathan Tuzman on 7/8/18.
//  Copyright © 2018 Jonathan Tuzman. All rights reserved.
//

import XCTest
@testable import Transposer

class LargeStringTranspoTests: XCTestCase {
	
	func testWordWise() {
		struct Strings {
		static let largeString = """
Chorus: C F G7 | Bb C | Em/G
Verse: A...G (A, Bb)
Because you know I'm all about that bass.
"""
		static let transposedString = """
Chorus: G C D7 | F G | Bm/D
Verse: E...D (E, F)
Because you know I'm all about that bass.
"""
		static let transposedLines = ["Chorus: G C D7 | F G | Bm/D", "Verse: E...D (E, F)", "Because you know I'm all about that bass."]
		}
		
		let song = Song(Strings.largeString)
		
		let result = song.transposed(fromString: "C", toString: "G")!
		XCTAssertEqual(song.text, Strings.largeString)
		XCTAssertEqual(song.lines.count, 3)
		
		XCTAssertEqual(result.lines[0], Strings.transposedLines[0])
		XCTAssertEqual(result.text, Strings.transposedString)
	}
	
}
