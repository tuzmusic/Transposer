//: A UIKit based Playground for presenting user interface

import UIKit
import PlaygroundSupport
import MusicFramework

import XCTest

let noteNames = [     ["C","B#"],
							 ["C#", "Db"],
							 ["D"],
							 ["D#", "Eb"],
							 ["E", "Fb"],
							 ["F", "E#"],
							 ["F#", "Gb"],
							 ["G"],
							 ["G#", "Ab"],
							 ["A"],
							 ["A#", "Bb"],
							 ["B", "Cb"]
]
let allNotes = noteNames.joined().joined(separator: " ").split(separator: " ").map{String($0)}

// NOTE 1: Component already looksLikeMusic.
// NOTE 2: Remember that we only need to transpose notes, so "sus4" is just as non-music as any punctuation
// Step through the characters until we have a chord, save that as a component.
let string = "(C#,"
var components = [String]()
let start = string.startIndex
var currentComponent = ""
print("working")
let i = 0
let index = string.index(start, offsetBy: i)
var substring = String(string[index]) // form a new substring each time through the loop. or not?

if allNotes.contains(substring) {
	// If our substring is a note, and isn't the last character, check the next character to see if it's part of the note name. Then store that note name in the components array.
	if index != string.endIndex {
		let nextIndex = string.index(index, offsetBy: 1)
		let longerSub = String(string[..<nextIndex])
		if allNotes.contains(longerSub) { substring = longerSub }
	}
	components.append(substring)
} else {
	currentComponent += substring
}


