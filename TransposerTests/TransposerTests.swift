//
//  TransposerTests.swift
//  TransposerTests
//
//  Created by Jonathan Tuzman on 6/13/18.
//  Copyright © 2018 Jonathan Tuzman. All rights reserved.
//

import XCTest
@testable import Transposer

extension XCTestCase {
	func Xtest<T: Equatable>(_ exp1: T, _ exp2: T) {
		XCTAssertEqual(exp1, exp2, "\(exp1) ≠ \(exp2)")
	}
}

class TransposerTests: XCTestCase {
		
	func testChordEquality() {
		let c = Note("C")!
		let chord1 = Chord("C")
		let chord2 = Chord(root: c)
		Xtest(chord1, chord2)
		let chord3 = Chord(root: c, base: c, extensions: nil)
		Xtest(chord2, chord3)
		
		let diffChord1 = Chord("Cm")
		XCTAssertFalse(diffChord1==chord3)
		let diffChord2 = Chord(root: Note("F")!)
		XCTAssertFalse(diffChord2==chord3)
	}
	
	func testChordTransposition() {
		let cmaj = Key("C")!
		let gmaj = Key("G")!
		//let bbmaj = Key("Bb")!
		let simpleChord = Chord("C")!
		
		XCTAssertEqual(simpleChord.transpose(from: gmaj, to: cmaj).symbol, "F") // IV
		Xtest(simpleChord.transpose(from: cmaj, to: gmaj).symbol, "G") // I

		var result: Chord
		let complexChord = Chord("Cmaj7/E")!
		result = complexChord.transpose(from: cmaj, to: gmaj) // I
		XCTAssertEqual(result.symbol, "Gmaj7/B")
		result = complexChord.transpose(from: gmaj, to: cmaj) // IV
		XCTAssertEqual(result.symbol, "Fmaj7/A")
		
		let complexChordWithAccs = Chord("C#maj7/Eb")!
		result = complexChordWithAccs.transpose(from: cmaj, to: gmaj)
		XCTAssertEqual(result.symbol, "G#maj7/Bb")
		result = complexChordWithAccs.transpose(from: gmaj, to: cmaj)
		XCTAssertEqual(result.symbol, "F#maj7/Ab")
		
		
	}
	
	func testChordSymbols() {
		var symbol: String
		let c = Note("C")!
		var cmaj = Chord(root: c, base: c, extensions: nil)
		symbol = "C"
		XCTAssertEqual(symbol, cmaj.symbol)

		// test init with root and quality only
		cmaj = Chord(root: c)
		XCTAssertEqual(symbol, cmaj.symbol)

		// test symbol initializers
		
		let simpleChord = Chord("Eb")
		XCTAssertEqual(simpleChord?.root.name, "Eb")
		XCTAssertEqual(simpleChord?.base?.name, "Eb")
		
		let complexChord = Chord("Cmaj7/E")
		XCTAssertEqual(complexChord?.root.name, "C")
		XCTAssertEqual(complexChord?.base?.name, "E")
		XCTAssertEqual(complexChord?.symbol, "Cmaj7/E")

		let complexChordWithAccs = Chord("C#maj7/Eb")
		XCTAssertEqual(complexChordWithAccs?.root.name, "C#")
		XCTAssertEqual(complexChordWithAccs?.base?.name, "Eb")
		XCTAssertEqual(complexChordWithAccs?.symbol, "C#maj7/Eb")
		
		let chord69 = Chord("D6/9/G")
		XCTAssertEqual(chord69?.root.name, "D")
		XCTAssertEqual(chord69?.base?.name, "G")
		XCTAssertEqual(chord69?.extensions, "6/9")
		XCTAssertEqual(chord69?.symbol, "D6/9/G")
	}
	
	func testDiatonicTransposition() {
		var result: Note
		let bmaj = Key("B")!
		let ebmaj = Key("Eb")!
		
		result = Note("D#")!.transpose(from: bmaj, to: ebmaj)
		XCTAssertEqual(result.name, "G")
		
		result = Note("A#")!.transpose(from: bmaj, to: ebmaj)
		XCTAssertEqual(result.name, "D")
		
		result = Note("E")!.transpose(from: bmaj, to: ebmaj)
		XCTAssertEqual(result.name, "Ab")
	}
	
	func testTranspositionSpellings() {
		var result: Note
		let cmaj = Key("C")!
		let abmaj = Key("Ab")!
		
		// b7 degree
		let bb = Note("Bb")!
		result = bb.transpose(from: cmaj, to: abmaj)
		XCTAssertEqual(result, Note("Gb")!)
		
		// #1 degree - F# in Fmajor
		let cs = Note("C#")!
		let fmaj = Key("F major")!
		result = cs.transpose(from: cmaj, to: fmaj)
		XCTAssertEqual(result, Note("F#")!)
		
		// b2 degree - Db from C to F
		let db = Note("Db")!
		result = db.transpose(from: cmaj, to: fmaj)
		XCTAssertEqual(result, Note("Gb")!)
		
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

	func testTransposeSpellingFromComplexKey() {
		var result: Note
		let bmaj = Key("B")!
		let ebmaj = Key("Eb")!
		
		let eb = Note("Eb")! // b4
		result = eb.transpose(from: bmaj, to: ebmaj)
		XCTAssertEqual(result.name, "G") // should be Abb, but should default to G
		
		result = Note("A")!.transpose(from: bmaj, to: ebmaj)
		XCTAssertEqual(result.name, "Db")
		
		result = Note("C")!.transpose(from: bmaj, to: ebmaj)
		XCTAssertEqual(result.name, "Fb")
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

