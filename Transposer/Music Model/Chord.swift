//
//  Chord.swift
//  Transposer
//
//  Created by Jonathan Tuzman on 6/15/18.
//  Copyright © 2018 Jonathan Tuzman. All rights reserved.
//

import Foundation

typealias ChordPattern = [Int]

class Chord {
	var root: Note!
	var base: Note?
	var quality: ChordPattern!
	var extensions: String?
	
	lazy var symbol: String = {
		var name = root.name
		if let base = base?.name {
			name += "/\(base)"
		}
		return name
	}()
	
	init(root: Note, base: Note, quality: ChordPattern, extensions: String) {
		self.root = root
		self.base = base
		self.quality = quality
		self.extensions = extensions
	}
}
