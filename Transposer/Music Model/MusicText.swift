//
//  MusicText.swift
//  Transposer
//
//  Created by Jonathan Tuzman on 7/7/18.
//  Copyright © 2018 Jonathan Tuzman. All rights reserved.
//

import Foundation

struct MusicText {
	static let probSymbols = ["|", "%", "...", "…", "||:", ":||", "||"]
	static let maybeSymbols = [","]
	static let probContainsSymbols = ["...", "…", "#"]
	static let defNotContainsSymbols = ["!", "?", "$"]
	static let probContainsBothSymbols = ["()"]
	static let ignoreAtStartSymbols: [Character] = ["[", "(", "/"]
	static let numbers = [1,2,3,4,5,6,7,8,9,0].map{String($0)}

	static let componentScores: [(strings: [String], isPart: IsMusic)] = [
		(probSymbols, .probably)
	]
	
	static let containsScores: [(strings: [String], isPart: IsMusic)] = [
		(maybeSymbols, .maybe),
		(probContainsSymbols, .probably),
		(numbers, .probably),
		(defNotContainsSymbols, .defNot)
		]
	static let containsBothScores: [(strings: [String], isPart: IsMusic)] = [
		(probContainsBothSymbols, .probably),
		]
	
	enum IsMusic: Int {
		case defNot = 0, probNot, maybe, probably, definitely
	}
}

extension String {
	
	var isMusic: MusicText.IsMusic {
		var heartStr = self
		
		// remove any leading and/or trailing parens
		if self.count > 1 {
			for textType in MusicText.containsBothScores {
				for string in textType.strings {
					if self.first == string.first { heartStr.removeFirst() }
					if self.last == string.last { heartStr.removeLast() }
				}
			}
		}
		
		// if this is only a symbol, that might tell us something
		for textType in MusicText.componentScores {
			if textType.strings.contains(heartStr) { return textType.isPart }
		}
		
		// if it's not a chord at all, it's definitely not music
		if Chord(heartStr) == nil { return .defNot }
				
		// so, it might be a chord. work with the original string and see how likely it is to actually be music
		
		// if it contains one of these symbols, that effects its likeliness to be music
		for textType in MusicText.containsScores {
			for symbol in textType.strings {
				if self.contains(symbol) { return textType.isPart }
			}
		}
		
		// if it contains both of these symbols, but isn't wrapped in them (which would cancel out their effect), that effects its score
		for textType in MusicText.containsBothScores {
			for string in textType.strings {
				if self.contains(string.first!) && self.contains(string.last!)
					&& !(self.first == string.first && self.last == string.last) {
					return textType.isPart
				}
			}
		}
		
		// if it doesn't contain any of these symbols, we don't know anything more about whether it's music.
		return .maybe
	}
	
	var isMusicLine: Bool {
		
		return true
		
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
}
