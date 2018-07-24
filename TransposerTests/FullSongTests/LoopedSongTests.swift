//
//  LoopedSongTests.swift
//  TransposerTests
//
//  Created by Jonathan Tuzman on 7/23/18.
//  Copyright © 2018 Jonathan Tuzman. All rights reserved.
//

import XCTest
@testable import Transposer

class LoopedSongTests: XCTestCase {
	struct SongBundle {
		var entireText: String
		var songText: String
		var expectedText: String
		var sourceKeyStr: String
		var destKeyStr: String
	}
	
	let bundles = [SongBundle]()
	
	func testSongs() {
		let bundles = testSongTitles.map { bundle(for: $0) }
		for bundle in bundles {
			guard let bundle = bundle else { continue }
			let song = Song(bundle.songText)
			let expectedSong = Song(bundle.expectedText)
			
			let unisonTransposedSong = song.transposed(fromString: bundle.sourceKeyStr, toString: bundle.sourceKeyStr)
			let transposedSong = song.transposed(fromString: bundle.sourceKeyStr, toString: bundle.destKeyStr)!
			
			XCTAssertEqual(bundle.songText, song.lines.joined()) 			// test line division in song
			XCTAssertEqual(unisonTransposedSong, song) // test component division in lines
			XCTAssertEqual(transposedSong, expectedSong) // test transposition
			expectedSong.compare(to: transposedSong)
		}
	}
	
	var testSongTitles = ["Roll To Me"]
	
	func getTextFor(_ title: String) -> String? {
		guard let path = Bundle.main.path(forResource: title, ofType: "txt"),
			let fullText = try? String(contentsOfFile: path) else { return nil }
		
		return fullText
	}
	
	func bundle(for filename: String) -> SongBundle? {
		guard let string = getTextFor(filename) else {
			print("Could not get text from '\(filename)'")
			return nil
		}
		let pattern = "SOURCEKEY:([A-Z])\\s+((.|\\n)*)DESTKEY:([A-Z])\\s+((.|\\n)*)"
		var entireText, sourceKey, songText, destKey, expectedText: String!
		do {
			let regex = try NSRegularExpression(pattern: pattern)
			if let match = regex.firstMatch(in: string, range: NSRange(string.startIndex..<string.endIndex, in: string)) {
				entireText = String(string[Range(match.range, in: string)!]) // prints the entire match ignoring the captured groups
				sourceKey = String(string[Range(match.range(at:1), in: string)!])
				songText = String(string[Range(match.range(at:2), in: string)!])
				destKey = String(string[Range(match.range(at:4), in: string)!])
				expectedText = String(string[Range(match.range(at:5), in: string)!])
			} else {
				print("Not Found")
			}
		} catch {
			print("Regex Error:", error)
		}
		return SongBundle(entireText: entireText, songText: songText, expectedText: expectedText, sourceKeyStr: sourceKey, destKeyStr: destKey)
	}
	
	func matches(for regex: String, in text: String) -> [String] {
		
		do {
			let regex = try NSRegularExpression(pattern: regex)
			let results = regex.matches(in: text,
												 range: NSRange(text.startIndex..., in: text))
			return results.map {
				String(text[Range($0.range, in: text)!])
			}
		} catch let error {
			print("invalid regex: \(error.localizedDescription)")
			return []
		}
	}

	func capturedMatches(for regex: String, in text: String) -> [String] {
		
		do {
			let regex = try NSRegularExpression(pattern: regex)
			let results = regex.matches(in: text,
												 range: NSRange(text.startIndex..., in: text))
			return results.map {
				String(text[Range($0.range(at: results.index(of: $0)!), in: text)!])
			}
		} catch let error {
			print("invalid regex: \(error.localizedDescription)")
			return []
		}
	}
	
	func _bundle(for filename: String) -> SongBundle? {
		guard let text = getTextFor(filename) else {
		print("Could not get text from '\(filename)'")
			return nil
		}
		
		let allComponents = text.components(separatedBy: "KEY:")
		let origTextComponents = allComponents[1].split(separator: "\n", maxSplits: 1, omittingEmptySubsequences: false).map{String($0)}
		let sourceKey = origTextComponents[0]
		let origText = origTextComponents[1].replacingOccurrences(of: "DEST", with: "")
		let destTextComponents = allComponents[2].split(separator: "\n", maxSplits: 1, omittingEmptySubsequences: false).map{String($0)}
		let destKey = destTextComponents[0]
		let expectedText = destTextComponents[1]
		
		return SongBundle(entireText: text, songText: origText, expectedText: expectedText, sourceKeyStr: sourceKey, destKeyStr: destKey)
	}
	
	func testSeparationWithInitialComponents() {
		let text = getTextFor("Roll To Me")!
		let allComponents = text.components(separatedBy: "KEY:")
		let origTextComponents = allComponents[1].split(separator: "\n", maxSplits: 1, omittingEmptySubsequences: false).map{String($0)}
		let sourceKey = origTextComponents[0]
		let origText = origTextComponents[1].replacingOccurrences(of: "DEST", with: "")
		let destTextComponents = allComponents[2].split(separator: "\n", maxSplits: 1, omittingEmptySubsequences: false)
		let destKey = destTextComponents[0]
		let expectedText = destTextComponents[1]
		
		XCTAssertEqual(sourceKey, "B")
		XCTAssertEqual(destKey, "E")
		XCTAssertTrue(origText.hasPrefix("Roll To Me"))
		XCTAssertTrue(expectedText.hasPrefix("Roll To Me"))
	}
	
	func testRegEx() {
		var text = getTextFor("Roll To Me")!
		XCTAssertTrue(text.contains("Look around your world"))
		XCTAssertTrue(text.contains("SOURCEKEY;"))
		var expression = "SOURCEKEY:([A-Z])(?s.)DESTKEY:([A-Z])(?s.)"
		expression = "(?<=SOURCEKEY:).+"//[A-Z]+"//(?<=DESTKEY:)[A-Z]+"
		expression = "SOURCEKEY:([A-Z])\\s+((.|\\n)*)DESTKEY:([A-Z])\\s+((.|\\n)*)"
//		let matchesArray = matches(for: "SOURCEKEY:([A-Z])", in: text)
//		text = "SOURCEKEY:A B C"
		let matchesArray = matches(for: expression, in: text)
		let capturedArray = capturedMatches(for: expression, in: text)
		XCTAssertEqual(matchesArray.count, 1)
		
	}
	
	func testBundleCaller() {
		var text = ""
		
			let bundleText = """
		SOURCEKEY:B
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
		
		DESTKEY:E
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
		let path = Bundle.main.path(forResource: "Roll To Me", ofType: "txt")!
		do 	{
			text = try String(contentsOfFile: path)
		} catch { }
		XCTAssertEqual(text, bundleText)
	}
}
