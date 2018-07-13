//
//  Subcomponents tests.swift
//  TransposerTests
//
//  Created by Jonathan Tuzman on 7/12/18.
//  Copyright © 2018 Jonathan Tuzman. All rights reserved.
//

import XCTest

class Subcomponents_tests: XCTestCase {
	
	func testComponentStuff() {
		let string = "(C#,"
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
				if index != string.endIndex {
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
		XCTAssertEqual(components.count, 3)
	}
	
	func testCases() {
		var string = ""
		string = "(C#,"
		let strings = [string, "A......G", "(Bbsus)"]
		for string in strings {
			XCTAssertEqual(musicalComponents(from: string).joined(), string)
		}
	}
	
	func musicalComponents(from string: String) -> [String] {
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
