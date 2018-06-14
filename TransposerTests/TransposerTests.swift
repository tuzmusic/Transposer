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
	}
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testOrderOfAccidentals() {
		let accsInOrder = Music.circleOfFifthsKeys
			.map { Music.newAcc3(in: $0)?.name! ?? "" }
			.joined(separator: " ")
		XCTAssertEqual(accsInOrder, TestConstants.orderOfAccidentals)
		
		let eMaj = Key("E major")!
		let dflatMaj = Key("Db major")!
		
		let sharpsInEMaj = eMaj.keySig
		let sharpsInEMajString = sharpsInEMaj.string
		var correctOrder = "F# C# G# D#"
		XCTAssertEqual(sharpsInEMajString, correctOrder)
		
		let flatsInDb = dflatMaj.keySig
		let flatsInDbString = flatsInDb.string
		correctOrder = "Bb Eb Ab Db Gb"
		XCTAssertEqual(flatsInDbString, correctOrder)
	}
	
	func testFailableNotes() {
		let badNote = Note("X")
		XCTAssert(badNote==nil)
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
		
		let fsmaj = Key("F# major")!
		result = fs.transpose(from: cmaj, to: fsmaj)
		XCTAssertEqual(result, Note("B#")!)
		
		let csmaj = Key("C# major")!
		result = fs.transpose(from: cmaj, to: csmaj)
		XCTAssertEqual(result, Note("G")!)
	}
}
