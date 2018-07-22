//
//  MusicText.swift
//  Transposer
//
//  Created by Jonathan Tuzman on 6/17/18.
//  Copyright © 2018 Jonathan Tuzman. All rights reserved.
//

import Foundation

extension MusicText {
	static func musicalComponents(from string: String) -> [String] {
		var components = [String]()
		let start = string.startIndex
		var currentComponent = ""
		var i = 0
		repeat {
			let index = string.index(start, offsetBy: i)
			var char = String(string[index])
			
			if Music.allNotes.contains(char) {
				// Save the previous characters and reset currentComponent
				components.append(currentComponent)
				currentComponent = ""
				
				// If this isn't last character, check the next character to see if it's part of the note name.
				if index != string.index(before: string.endIndex) {
					let nextIndex = string.index(index, offsetBy: 1)
					let nextChar = string[nextIndex]
					if Music.accidentalSymbols.keys.contains(nextChar) {
						char += String(nextChar)
						i += 1
					}
				}
				components.append(char)
			} else {
				currentComponent += char
			}
			i += 1
		} while i < string.count
		
		components.append(currentComponent) // add final component
		return components
	}
}

extension String {
	
	func transpose(from sourceKey: Key, to destKey: Key) -> String {

		let components = self.separateComponentsFromWhitespace()
		var newComponents = MusicLine()
		for component in components {
			if component.looksLikeMusic {
				var newSubComponent = ""
				for subComponent in MusicText.musicalComponents(from: component) {
					if let transposedNote = Note(subComponent)?.transpose(from: sourceKey, to: destKey) {
						newSubComponent += transposedNote.name
					}  else {
						newSubComponent += subComponent
					}
				}
				newComponents.append(newSubComponent)
			} else {
				newComponents.append(component)
			}
		}
		
		return newComponents.joined()
	}
	
	func transpose(fromString sourceKey: String, toString destKey: String) -> String? {
		guard let source = Key(sourceKey), let dest = Key(destKey) else { return nil }
		return self.transpose(from: source, to: dest)
	}
	
	func separateComponentsFromWhitespace() -> [String] {
		let separators = [" ", "\t", "-"]
		let allCharacters = Array(self).map{String($0)}
		var components = [String]()
		var currentComponent: String = ""
		
		for character in allCharacters {
			guard !currentComponent.isEmpty else { currentComponent = character; continue}
			if separators.contains(character) { // if this character is a separator
				if currentComponent.hasSuffix(character) {  // if we're in a string of the same separator, continue the string
					currentComponent += character
				} else { // if we've been in a string of letters (or anything else) but now we have a separator, store the current component and start a new one
					components.append(currentComponent)
					currentComponent = character
				}
			} else { // if this character is not a separator (and the component is not empty)...
				if let last = currentComponent.last, separators.contains(String(last)) {  // if this is a new string, after a separator
					components.append(currentComponent)
					currentComponent = character
				} else {
					currentComponent += character
				}
			}
		}
		components.append(currentComponent) // tack on the final component.
		return components
	}
	
}
