//
//  Chord.swift
//  Transposer
//
//  Created by Jonathan Tuzman on 6/15/18.
//  Copyright © 2018 Jonathan Tuzman. All rights reserved.
//

import Foundation

class Chord: CustomStringConvertible {
	
	var root: Note
	var base: Note?
	var extensions: String?
	
	var symbol: String {
		get {
			var name = root.name
			name += extensions ?? ""
			if let base = base, base != root {
				name += "/\(base.name)"
			}
			return name
		}
		set { }
	}
	
	lazy var description = self.symbol
	
	static func == (_ ls: Chord, _ rs: Chord) -> Bool {
		if ls.root != rs.root { return false }
		if ls.extensions != rs.extensions { return false }
		if let leftBase = ls.base {
			if let rightBase = rs.base {
				if leftBase != rightBase { return false } // if they both have base but they're different
			} else {
				if leftBase != ls.root { return false } // if only left has base and it is indeed altered
				else if let rightBase = rs.base, rightBase != rs.root { // if only right has base and it is indeed altered
					return false
				}
			}
		}
		return true
	}
	
	func sym() -> String {
		var name = root.name
		name += extensions ?? ""
		if let base = base, base != root {
			name += "/\(base.name)"
		}
		return name
	}
	
	init(root: Note, base: Note, extensions: String?) {
		self.root = root
		self.base = base
		self.extensions = extensions
	}
	
	init(root: Note) {
		self.root = root
		self.base = root
		self.extensions = nil
	}
	
	init?(_ string: String) {
		guard !string.isEmpty else { return nil }
		var symbol = string
		
		// assemble root
		var rootName = String(symbol.removeFirst())
		if let nextChar = symbol.first, Music.accidentalSymbols[nextChar] != nil {
			rootName += String(nextChar)
			symbol.removeFirst()
		}
		guard let root = Note(rootName) else { return nil }
		self.root = root
		
		if symbol.isEmpty  {
			self.base = root
			return
		}
		var components = symbol.split(separator: "/")
		if components.count > 1 {
			if let base = Note(String(components.last!)) {
				self.base = base
				_ = components.popLast()
			}
		}
		self.extensions = components.joined(separator: "/")
	}
	
}

extension Chord {
	// transposition
	
	func transpose(from sourceKey: Key, to destKey: Key) -> Chord {
		let newRoot = self.root.transpose(from: sourceKey, to: destKey)
		let newChord = Chord(root: newRoot)
		if let base = self.base {
			newChord.base = base.transpose(from: sourceKey, to: destKey)
		}
		if let description = self.extensions {
			newChord.extensions = description
		}
		return newChord
	}
	
}
