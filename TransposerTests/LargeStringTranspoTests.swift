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
	}
	
	let songInC = Song(Strings.largeString)
	lazy var songInG = songInC.transposed(fromString: "C", toString: "G")!
	let transposedSong = Song(Strings.transposedString)
	
	func testLine2() { // All the punctuation in line two should mess us up.
//		let line2Components = songInC[1].components(separatedBy: " ")
//		XCTAssertEqual(line2Components.map{$0.looksLikeMusic}, [false, true, true, true])
		XCTAssertEqual("A...G".transpose(fromString: "C", toString: "G"), "E...D")
		XCTAssertEqual(songInG[1], transposedSong[1])
		XCTAssertEqual(songInG.text, transposedSong.text)
	}
	
	func testLines() {
		XCTAssertEqual(songInC[0].isMusicLine_byCount, true)
		XCTAssertEqual(songInC[1].isMusicLine_byCount, true)
		XCTAssertEqual(songInC[2].isMusicLine_byCount, false)
		XCTAssertEqual(songInG[0], transposedSong[0])
		XCTAssertEqual(songInG, transposedSong)
		XCTAssertEqual(songInC[0], "Chorus: C F G7 | Bb C | Em/G") // test line subscript
	}
	
	func testWordWise() {
		
		XCTAssertEqual(songInC.text, Strings.largeString)
		XCTAssertEqual(songInC.lines.count, 3)
		
		XCTAssertEqual(songInG[0], transposedSong[0])
		XCTAssertEqual(songInG.text, Strings.transposedString)
	}
	
}
