//
//  MusicText.swift
//  Transposer
//
//  Created by Jonathan Tuzman on 7/7/18.
//  Copyright © 2018 Jonathan Tuzman. All rights reserved.
//

import Foundation

struct MusicText {
	enum IsMusic: Int {
		case defNot = 0, probNot, maybe, probably, definitely
	}

	static let probSymbols = ["|", "%", "...", "…", "||:", ":||", "||"]
	static let maybeSymbols = [","]
	static let probContainsSymbols = ["...", "…", "#"]
	static let defNotContainsSymbols = ["!", "?", "$"]
	static let probContainsBothSymbols = ["()"]
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
	
	static let formTitles = ["Verse", "Chorus", "Intro", "Bridge", "Interlude"]
	static let formSeparators = [":"]
	
	static func evaluateComponentSymbols(in string: String) -> MusicText.IsMusic? {
		// if this is only a symbol, that might tell us something
		for textType in MusicText.componentScores {
			if textType.strings.contains(string) { return textType.isPart }
		}
		return nil
	}
	
	static func evaluateContainsSymbols(in string: String) -> MusicText.IsMusic? {
		// if it contains one of these symbols, that effects its likeliness to be music
		for textType in MusicText.containsScores {
			for symbol in textType.strings {
				if string.contains(symbol) { return textType.isPart }
			}
		}
		return nil
	}
	
	static func evaluateBothSymbols(in string: String) -> MusicText.IsMusic? {
		// if it contains both of these symbols, but isn't wrapped in them (which would cancel out their effect here), that effects its score
		// note: heartStr has any leading or trailing
		for textType in MusicText.containsBothScores {
			for string in textType.strings {
				if string.contains(string.first!) && string.contains(string.last!)
					&& !(string.first == string.first && string.last == string.last) {
					return textType.isPart
				}
			}
		}
		return nil
	}
	
}

extension String {
	var isMusic: MusicText.IsMusic {
		var heartStr = self
		
		removeLeadingOrTrailingParens(from: &heartStr)
		if let score = MusicText.evaluateComponentSymbols(in: heartStr) { return score }

		// if it's not a chord at all, it's definitely not music
		if Chord(heartStr) == nil { return .defNot }
				
		// So, it might be a chord. work with the original string and see how likely it is to actually be music
		if let score = MusicText.evaluateContainsSymbols(in: self) { return score }
		if let score = MusicText.evaluateBothSymbols(in: self) { return score }
		
		// if it doesn't contain any of these symbols, we don't know anything more about whether it's music.
		return .maybe
	}
	
	func removeLeadingOrTrailingParens(from string: inout String) {
		var string = string
		// remove any leading and/or trailing parens
		if string.count > 1 {
			for textType in MusicText.containsBothScores {
				for sym in textType.strings {
					if string.first == sym.first { string.removeFirst() }
					if string.last == sym.last { string.removeLast() }
				}
			}
		}
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
