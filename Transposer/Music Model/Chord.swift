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
	var quality: ChordPattern
	var extensions: String?
	
	lazy var symbol: String = {
		var name = root.name
		if let base = base, base != root {
			name += "/\(base.name)"
		}
		name += quality.sym
		name += extensions ?? ""
		return name
	}()
	
	init(root: Note, base: Note, quality: ChordPattern, extensions: String?) {
		self.root = root
		self.base = base
		self.quality = quality
		self.extensions = extensions
	}
	
	
}
