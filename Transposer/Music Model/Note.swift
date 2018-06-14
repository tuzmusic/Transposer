//
//  Note.swift
//  Transposer
//
//  Created by Jonathan Tuzman on 5/7/18.
//  Copyright © 2018 Jonathan Tuzman. All rights reserved.
//

import Foundation

class Note: Equatable, CustomStringConvertible {
	/* TO-DO:
	// 1. make initializers failable (too much work resolving resulting optionals throughout the rest of the code, for now)
	// 2. make name and num lazy so we don't have to compute each one every time a note is created (sometimes we don't need both)
	*/
	
	var name: String!
	
	func getNumFromName(_ name: String) -> Int? {
		for (index, names) in Music.noteNames.enumerated() {
			if names.index(of: name) != nil {
				return index
			}
		}
		return nil
	}
	
	var num: Int!
	
	func getNameFromNum(_ num: Int) -> String? {
		let adjNum = Note.getNumWithinOctave(num: num)
		if adjNum < Music.noteNames.count {
			return Music.noteNames[adjNum].first!
		}
		return nil
	}
	
	class func getNumWithinOctave(num: Int) -> Int {
		var adjNum = num
		while adjNum < 0 { adjNum += 12 }
		while adjNum >= 12 { adjNum -= 12 }
		return adjNum
	}
	
	init? (_ name: String) {
		guard let num = getNumFromName(name) else { return nil }
		self.num = num
		self.name = name
	}
	
	init (_ num: Int) {
		self.num = num
		self.name = getNameFromNum(num)
	}
	
	static func == (_ ls: Note, _ rs: Note) -> Bool {
		return ls.num == rs.num
	}
	
	lazy var isSharp = self.name.contains("#")
	
	lazy var isFlat = self.name.contains("b")
	
	lazy var description = "Note (name: \(self.name!), num: \(self.num!))"
	
	func transpose(_ steps: Int) -> Note {
		var num = self.num + steps
		num = Note.getNumWithinOctave(num: num)
		return Note(num)
	}

	func transpose(from sourceKey: Key, to destKey: Key) -> Note {
		// note diatonic to source key
		if let degree = sourceKey.notes.index(of: self) {
			return destKey[degree]
		}
		
		// note not diatonic to source key
		let tonic = sourceKey[0]
		let interval = abs(tonic.num - self.num)
		let newNote = destKey[0].transpose(interval)
		return newNote
	}
}
