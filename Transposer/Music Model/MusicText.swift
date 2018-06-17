//
//  MusicText.swift
//  Transposer
//
//  Created by Jonathan Tuzman on 6/17/18.
//  Copyright © 2018 Jonathan Tuzman. All rights reserved.
//

import Foundation

typealias MusicText = String
typealias MusicLine = [MusicText]

class Song {
	var lines = MusicLine()
	
}

extension String {
	
	func transpose(from sourceKey: Key, to destKey: Key) -> String {
		let newString = self
		var newComponents = MusicLine()
		
		for component in newString.split(separator: " ") {
			let string = String(component)
			if let chord = Chord(string) {
				let newChord = chord.transpose(from: sourceKey, to: destKey)
				newComponents.append(newChord.symbol)
			} else {
				newComponents.append(string)
			}
		}
		
		return newComponents.joined(separator: " ")
	}
}
