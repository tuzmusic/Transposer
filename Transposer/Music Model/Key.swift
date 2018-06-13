//
//  Key.swift
//  Transposer
//
//  Created by Jonathan Tuzman on 5/7/18.
//  Copyright © 2018 Jonathan Tuzman. All rights reserved.
//

import Foundation

class Key: Equatable {
	typealias ScalePattern = [Int]
	var notes = [Note]()
	var name: String?
	lazy var noteNames = notes.map {$0.name!}.joined(separator: " ")
	lazy var keySig = notes.filter { $0.isSharp || $0.isFlat }
	lazy var sharps = notes.filter{$0.isSharp}
	lazy var flats = notes.filter{$0.isFlat}
	lazy var sharpsNames = sharps.map { $0.name }.joined(separator: " ")
	
	lazy var value = notes.reduce(0) { $0 + (Music.accidentalSymbols[$1.name!.last!]?.rawValue ?? 0) }
	
	func getKeySigValue() -> Int {
		var x = 0
		for note in notes {
			x += Music.accidentalSymbols[note.name!.last!]?.rawValue ?? 0
		}
		return x
	}
	
	init?(tonic: Note, pattern: ScalePattern) {
		if let notes = notesInScale(tonic, pattern) { self.notes = notes }
		else { return nil }
	}
	convenience init?(_ scaleName: String) {
		let parts = scaleName.split(separator: " ").map { String($0) }
		guard let pattern = Music.scalePatterns[parts[1]] else { return nil }
		self.init(tonic: Note(parts[0]), pattern: pattern)
		self.name = scaleName
	}
	convenience init?(_ noteName: String, _ pattern: ScalePattern) {
		self.init(tonic: Note(noteName), pattern: pattern)
	}
	func notesInScale(_ tonic: Note, _ pattern: ScalePattern) -> [Note]? {
		var notes = [tonic]
		for degree in pattern where degree > 0 {
			let nextLetterNum = notes.last!.name.first!.unicodeScalars.first!.value + 1
			var nextLetter = String(describing: Unicode.Scalar(nextLetterNum)!)
			if nextLetter == "H" { nextLetter = "A" }
			
			let newNoteNum = Note.getNumWithinOctave(num: tonic.num + degree)
			let names = Music.noteNames[newNoteNum]
			if let newNoteName = names.first(where: {$0.hasPrefix(nextLetter)}) {
				if notes.contains(Note(newNoteName)) == false {
					notes.append(Note(newNoteName))
				}
			} else {
				return nil
			}
		}
		return notes
	}
	static func == (_ ls: Key, _ rs: Key) -> Bool {
		return ls.noteNames == rs.noteNames
	}
}
