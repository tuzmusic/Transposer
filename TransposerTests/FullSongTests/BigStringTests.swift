//
//  BigStringTests.swift
//  TransposerTests
//
//  Created by Jonathan Tuzman on 7/17/18.
//  Copyright © 2018 Jonathan Tuzman. All rights reserved.
//

import XCTest
@testable import Transposer
class BigStringTests: XCTestCase {

	
	struct SongText {
		static let textInB = """
Roll To Me (up to ^8)

Intro: B2….
Verse:  	F#2, /A#-G#m7, B | F#2  /A#-G#m7,  C#7 |
		F#2, /A#-G#m7, B | F#2  G#m7-B2 |
Chorus: F#7  Bm  F#/A#  G#m7,   F#/A#  B  G#m7  C#7

Look around your world, pretty baby, Is it everything you'd hoped it'd be?
The wrong guy, the wrong situation, The right time to roll to me
Roll to me

And look into your heart, pretty baby, Is it aching with some nameless need?
Is there something wrong and you can't put your finger on it
Right then, roll to me

And I don't think I have ever seen a soul so in despair
So if you want to talk the night through guess who will be there?

So don't try to deny it, pretty baby, You've been down so long you can hardly see
When the engine's stalled and it won't stop raining, it's the
Right time to roll to me
Roll to me, Roll to me

And I don't think I have ever seen a soul so in despair
So if you want to talk the night through, Guess who will be there?

So look around your world, pretty baby, Is it everything you'd hoped it'd be?
The wrong guy, the wrong situation
F#           G#m       B      F#
The right time to roll to me
F#           G#m       B      F#
The right time to roll to me
F#           G#m       B      G#m7….(ooh!)
the right time to roll to me
"""
		
		static let textInE = """
Roll To Me (up to ^8)

Intro: E2….
Verse:  	B2, /D#-C#m7, E | B2  /D#-C#m7,  F#7 |
		B2, /D#-C#m7, E | B2  C#m7-E2 |
Chorus: B7  Em  B/D#  C#m7,   B/D#  E  C#m7  F#7

Look around your world, pretty baby, Is it everything you'd hoped it'd be?
The wrong guy, the wrong situation, The right time to roll to me
Roll to me

And look into your heart, pretty baby, Is it aching with some nameless need?
Is there something wrong and you can't put your finger on it
Right then, roll to me

And I don't think I have ever seen a soul so in despair
So if you want to talk the night through guess who will be there?

So don't try to deny it, pretty baby, You've been down so long you can hardly see
When the engine's stalled and it won't stop raining, it's the
Right time to roll to me
Roll to me, Roll to me

And I don't think I have ever seen a soul so in despair
So if you want to talk the night through, Guess who will be there?

So look around your world, pretty baby, Is it everything you'd hoped it'd be?
The wrong guy, the wrong situation
B           C#m       E      B
The right time to roll to me
B           C#m       E      B
The right time to roll to me
B           C#m       E      C#m7….(ooh!)
the right time to roll to me
"""
		
	}
	let rollToMe_B = Song(SongText.textInB)
	let rollToMe_E = Song(SongText.textInE)
	
	func pr(_ item: Any) { print("\n\(item)\n") }
	
	func testLineWithHyphens() {
		let line = "\t\tF#2, /A#-G#m7, B | F#2  G#m7-B2 |"
		let lineComponents = ["\t\t", "F#2,"," ","/A#","-","G#m7,"," ","B"," ","|"," ","F#2","  ","G#m7","-","B2"," ","|"]
		let transLine = "\t\tB2, /D#-C#m7, E | B2  C#m7-E2 |"
		XCTAssertEqual(line.separateComponentsFromWhitespace(), lineComponents)
		XCTAssertTrue(line.isMusicLine_byCount)
		XCTAssertTrue(transLine.isMusicLine_byCount)
		XCTAssertEqual(line, rollToMe_B[4])
		XCTAssertEqual(transLine, rollToMe_E[4])
		XCTAssertTrue(rollToMe_B.transposed(fromString: "B", toString: "E")![3].isMusicLine_byCount)
		XCTAssertTrue(rollToMe_B.transposed(fromString: "B", toString: "E")![4].isMusicLine_byCount)
	}
	
	func testVerseLine() {
		XCTAssertTrue("Verse:   F#2, /A#-G#m7, B | F#2  /A#-G#m7,  C#7 |".isMusicLine_byCount)
	}
	
	func testRollToMe() {
		let transUnison = rollToMe_B.transposed(fromString: "B", toString: "B")!
		let transSong = rollToMe_B.transposed(fromString: "B", toString: "E")!

		let origLine = rollToMe_B[3].transpose(fromString: "B", toString: "E")!
		let transLine = transSong[3]
		XCTAssertEqual(origLine, transLine)
		XCTAssertTrue(origLine.isMusicLine_byCount)
		XCTAssertTrue(transLine.isMusicLine_byCount)
//		XCTAssertEqual(transLine.replacingOccurrences(of: "\t", with: " "), "  B2, /D#-C#m7, E | B2  C#m7-E2 |")
//		XCTAssertEqual(rollToMe_E[4].replacingOccurrences(of: "\t", with: " "), "  B2, /D#-C#m7, E | B2  C#m7-E2 |")
		
		XCTAssertEqual(transSong, rollToMe_E)
		rollToMe_E.compare(to: transSong, includePasses: false)
//
//		XCTAssertEqual(rollToMe_B.lines.count, transUnison.lines.count)
//
//		XCTAssertEqual(transUnison.text, rollToMe_B.text)
//		XCTAssertEqual(transUnison, rollToMe_B)   // the final line is being duplicated in some weird way for some reason!!!
//
//		XCTAssertEqual(transSong.text, transSong.lines.joined())
//		XCTAssertEqual(rollToMe_B.text, rollToMe_B.lines.joined())
//		XCTAssertEqual(rollToMe_E.text, rollToMe_E.lines.joined())
//		XCTAssertEqual(transSong.text, rollToMe_E.text)

	}
	
	func testNonMusicCount() {
		let line = "Verse:\tB2, /D#-C#m7, E | B2  /D#-C#m7,  F#7 |"
		let components = line.separateComponentsFromWhitespace()
		let nonChords = components.filter {
			$0.filter{char in [" ","\t","\n","-"].contains(char)}.isEmpty && !$0.looksLikeMusic
		}
		XCTAssertEqual(components.count, 21)
		XCTAssertEqual(nonChords.count, 1)
		XCTAssertTrue(line.isMusicLine_byCount)
	}

}
