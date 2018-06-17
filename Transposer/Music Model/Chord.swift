//
//  Chord.swift
//  Transposer
//
//  Created by Jonathan Tuzman on 6/15/18.
//  Copyright © 2018 Jonathan Tuzman. All rights reserved.
//

import Foundation

extension Music {
	struct ChordPattern {
		var name: String
		var pattern: [Int]
		var sym: String
		var shortSym: String
	}
}

typealias ChordPattern = Music.ChordPattern

class Chord {
	
	static let maj = ChordPattern(name: "major", pattern: [0,2,4], sym: "maj", shortSym: "M")
	
	var root: Note
	var base: Note?
	var quality: ChordPattern?
	var extensions: String?
	
	lazy var symbol: String = {
		var name = root.name
		name += quality?.sym ?? ""
		name += extensions ?? ""
		if let base = base, base != root {
			name += "/\(base.name)"
		}
		return name
	}()
	
	init(root: Note, base: Note, quality: ChordPattern, extensions: String?) {
		self.root = root
		self.base = base
		self.quality = quality
		self.extensions = extensions
	}
	
	init(root: Note, quality: ChordPattern) {
		self.root = root
		self.base = root
		self.quality = quality
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
		var newChord = self
		newChord.root = self.root.transpose(from: sourceKey, to: destKey)
		if let base = self.base {
			newChord.base = base.transpose(from: sourceKey, to: destKey)
		}
		if let quality = self.quality {
			newChord.quality = quality
		}
		if let description = self.extensions {
			newChord.extensions = description
		}
		return newChord
	}
		
}
