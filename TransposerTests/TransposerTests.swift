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
	
//	func testChordSymbols() {
//		var result: Chord
//		let cmaj = Chord(root: Note("C")!, quality: maj)
//		result = Chord("Cmaj")!
//		XCTAssertEqual(result, cmaj)
//	}
	
	func testTranspositionSpellings() {
		var result: Note
		let cmaj = Key("C")!
		let abmaj = Key("Ab")!
		
		// b7 degree
		let bb = Note("Bb")!
		result = bb.transpose(from: cmaj, to: abmaj)
		XCTAssertEqual(result, Note("Gb")!)
		
		// #2 degree - F# in Fmajor
		let cs = Note("C#")!
		let fmaj = Key("F major")!
		result = cs.transpose(from: cmaj, to: fmaj) // error is here
		XCTAssertEqual(result, Note("F#")!)
		
		// Bb in D major? (b6 degree) -- equidistant! oh no!
		let ab = Note("Ab")!
		let dmaj = Key("D major")!
		result = ab.transpose(from: cmaj, to: dmaj)
		XCTAssertEqual(result, Note("Bb")!)
		
		// #4 degree - where one note is a natural
		let fs = Note("F#")!
		let fsmaj = Key("F# major")!
		result = fs.transpose(from: cmaj, to: fsmaj)
		XCTAssertEqual(result, Note("B#")!)
	}

	func testCircleOfFifths() {
		let names = "Cb Gb Db Ab Eb Bb F C G D A E B F# C#"
		XCTAssertEqual(names, Music.circleOfFifthsNames)
	}
	
   func testOrderOfAccidentals() {
		let accsInOrder = Music.circleOfFifths
			.map { Music.newAcc3(in: $0)?.name ?? "" }
			.joined(separator: " ")
		XCTAssertEqual(accsInOrder, TestConstants.orderOfAccidentals)
	}
	
	func testSortedKeySig() {
		let eMaj = Key("E major")!
		let dflatMaj = Key("Db major")!
		
		let sharpsInEMaj = eMaj.sortedKeySig
		let sharpsInEMajString = sharpsInEMaj.string
		var correctOrder = "F# C# G# D#"
		XCTAssertEqual(sharpsInEMajString, correctOrder)
		
		let flatsInDb = dflatMaj.sortedKeySig
		let flatsInDbString = flatsInDb.string
		correctOrder = "Bb Eb Ab Db Gb"
		XCTAssertEqual(flatsInDbString, correctOrder)
	}
	
	func testFailableNotes() {
		let badNote = Note("X")
		XCTAssert(badNote==nil)
	}
	
	func testFailableKey() {
		let badKey = Key("D#")
		XCTAssertEqual(badKey, nil)
	}
	
	func testKeySubscript() {
		let c = Note("C")!
		let abmaj = Key("Ab major")!
		let result = abmaj[2]
		XCTAssert(result==c)
	}
	
	func testNoteTranspositionWithinKey() {
		var result: Note
		
		// note diatonic to source key
		let c = Note("C")!
		let cmaj = Key("C major")!
		let abmaj = Key("Ab major")!
		result = c.transpose(from: cmaj, to: abmaj)
		let ab = Note("Ab")
		XCTAssert(result==ab)
		
		// note non-diatonic to source key
		let bb = Note("Bb")!
		let gb = Note("Gb")!
		result = bb.transpose(from: cmaj, to: abmaj)
		
		let count = Music.noteNames[result.num].count
		XCTAssert(count>1)
		XCTAssertEqual(result, gb)
		
		let f = Note("F")!
		let gmaj = Key("G major")!
		result = bb.transpose(from: cmaj, to: gmaj)
		XCTAssertEqual(result, f)
		
		let fs = Note("F#")!
		result = fs.transpose(from: cmaj, to: gmaj)
		XCTAssertEqual(result, Note("C#")!)
		result = fs.transpose(from: cmaj, to: abmaj)
		XCTAssertEqual(result, Note("D")!)
		
		let csmaj = Key("C# major")!
		result = fs.transpose(from: cmaj, to: csmaj)
		XCTAssertEqual(result, Note("G")!)
	}
	
}

