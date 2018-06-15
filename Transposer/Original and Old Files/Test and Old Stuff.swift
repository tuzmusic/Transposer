//
//  Test and Old Stuff.swift
//  Transposer
//
//  Created by Jonathan Tuzman on 5/8/18.
//  Copyright © 2018 Jonathan Tuzman. All rights reserved.
//

import Foundation

func test<T: Equatable> (_ arg1: T, _ arg2: T) -> String {
	let resultString = """
	Test \(arg1 == arg2 ? "PASSED" : "FAILED").
	Expected: \(String(describing: arg2))
	Got: \(String(describing: arg1))
	"""
	return resultString
}
struct TestConstants {
	static let circleOfFifthsNames = "Cb Gb Db Ab Eb Bb F C G D A E B F# C#"
	static let orderOfAccidentals = "Fb Cb Gb Db Ab Eb Bb  F# C# G# D# A# E# B#"
}
func test<T: Equatable> (_ arg1: T?, _ arg2: T?) -> String {
	let resultString = """
	Test \(arg1 == arg2 ? "PASSED" : "FAILED").
	Expected: \(String(describing: arg2))
	Got: \(String(describing: arg1))
	"""
	return resultString
}

// TEST SETUP AREA
let eMaj = Key("E major")!
let dflatMaj = Key("Db major")!
let gMaj = Key("G major")!
let csMaj = Key("C# major")!
let testArray = [eMaj, dflatMaj, eMaj, csMaj, gMaj]
//Music.circleOfFifthsKeys.map({$0.value})
// TEST AREA
//test(testArray.map({$0.value}), [4, -5, 2, 7, 2])
//test(Music.newAcc(in: csMaj), Note("B#"))
//test(Music.circleOfFifths().map {Music.newAcc2(in: $0)?.name ?? ""}.joined(separator: " "), TestConstants.orderOfAccidentals)
//test(Music.newAcc(in: gMaj), Note("F#"))
//test(eMaj.sharpsNames, "F# C# G# D#")
//test(dflatMaj.flatsNames, "Bb Eb Ab Db Gb")
//test(Music.circleOfFifthsNames, TestConstants.circleOfFifthsNames)

/* TESTS LIST
✅ pre-9: list of sharps and flats for each key
✅ 9. derive circle of fifths/list of sharp/flat scales (for fun, basically)
10. get circle of fifths as a list of new sharp or flat for each key. i.e., put key signatures in order (currently a key's list of sharps/flats is in note order
10.a Sort by finding new accidental for key
✅ 10.a.a identify new accidental for key
10.a.b sort a key's accidentals in order of newest accidental
.... transpose enharmonically
- may have to be within a scale/key. except, for instance:
- F never transposes to a sharp key & B never transposes to a flat key.
- but, those are still diatonic within a major scale? or something?
- i think this may only be implemented in transposing a series of notes, within a certain key. i'll shut up now
*/
