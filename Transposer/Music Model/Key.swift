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
	lazy var noteNames = notes.string
	lazy var keySig = notes.filter { $0.isSharp || $0.isFlat }.sorted {
		let first = self.value > 0 ? $1 : $0
		let second = first == $1 ? $0 : $1
		return Music.orderOfAccidentals.index(of: first)! > Music.orderOfAccidentals.index(of: second)!
	}
	
	subscript(degree: Int) -> Note {
		return notes[degree]
	}
	
	lazy var sharps = notes.filter{$0.isSharp}
	lazy var flats = notes.filter{$0.isFlat}
	
	lazy var value = notes.reduce(0) { $0 + (Music.accidentalSymbols[$1.name!.last!]?.rawValue ?? 0) }		
	
	init?(tonic: Note, pattern: ScalePattern) {
		guard let notes = notesInScale(tonic, pattern) else { return nil }
		self.notes = notes
	}
	
	convenience init?(_ scaleName: String) {
		let parts = scaleName.split(separator: " ").map { String($0) }
		if let pattern = Music.scalePatterns[parts[1]], let tonic = Note(parts[0]) {
			self.init(tonic: tonic, pattern: pattern)
			self.name = scaleName
		} else {
			return nil
		}
	}
	
	convenience init?(_ noteName: String, _ pattern: ScalePattern) {
		if let tonic = Note(noteName) {
			self.init(tonic: tonic, pattern: pattern)
		} else {
			return nil
		}
	}
	
	func notesInScale(_ tonic: Note, _ pattern: ScalePattern) -> [Note]? {
		var notes = [tonic]
		for degree in pattern where degree > 0 {
			let nextLetterNum = notes.last!.name.first!.unicodeScalars.first!.value + 1
			var nextLetter = String(describing: Unicode.Scalar(nextLetterNum)!)
			if nextLetter == "H" { nextLetter = "A" }
			
			let newNoteNum = Note.getNumWithinOctave(num: tonic.num + degree)
			let names = Music.noteNames[newNoteNum]
			if let newNoteName = names.first(where: {$0.hasPrefix(nextLetter)}), let newNote = Note(newNoteName) {
				if notes.contains(newNote) == false {
					notes.append(newNote)
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
