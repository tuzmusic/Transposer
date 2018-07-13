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
		
		components.append(currentComponent)
		return components
	}
}

extension String {
	
	func transpose(from sourceKey: Key, to destKey: Key) -> String {
		
		let newString = self
		var newComponents = MusicLine()
		
		for component in newString.split(separator: " ").map({String($0)}) {
			if component.looksLikeMusic {
				for subcomponent in MusicText.musicalComponents(from: component) {
					newComponents.append(subcomponent.transpose(from: sourceKey, to: destKey))
				}
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
