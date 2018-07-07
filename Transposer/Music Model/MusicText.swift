//
//  MusicText.swift
//  Transposer
//
//  Created by Jonathan Tuzman on 6/17/18.
//  Copyright © 2018 Jonathan Tuzman. All rights reserved.
//

import Foundation

typealias MusicText = String
typealias MusicTextComponents = String
typealias MusicLine = [MusicTextComponents]

class Song {
	
	var lines = MusicLine()
	var text = MusicText() {
		didSet {
			self.lines = text.split(separator: "\n").map {String($0)}
		}
	}
	
	func transpose(from sourceKey: Key, to destKey: Key) -> String {
		var newText = ""
		for line in self.lines {
			if line.isMusic {
				newText.append(line.transpose(from: sourceKey, to: destKey) + "\n")
			} else {
				newText.append(line + "\n")
			}
		}
		return newText
	}
	
}

extension MusicText {
	
	var isMusic: Bool {

		let numberOfChordsForLineToBeMusic = 3
		
		let components = self.split(separator: " ").map{String($0)}
		var chords = MusicLine()
		for component in components {
			if Chord(component) != nil {
				chords.append(component)
			}
		}
		
		if chords.count >= numberOfChordsForLineToBeMusic {
			return true
		}
		return false
	}
	
	func transpose(from sourceKey: Key, to destKey: Key) -> String {
		let newString = self
		var newComponents = MusicLine()
		
		for component in newString.split(separator: " ").map({String($0)}) {
			if let chord = Chord(component) {
				let newChord = chord.transpose(from: sourceKey, to: destKey)
				newComponents.append(newChord.symbol)
			} else {
				newComponents.append(component)
			}
		}
		
		return newComponents.joined(separator: " ")
	}
	
	func transpose(fromString sourceKey: String, toString destKey: String) -> String? {
		guard let source = Key(sourceKey), let dest = Key(destKey) else { return nil }
		return self.transpose(from: source, to: dest)
	}

}
