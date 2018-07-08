//
//  Song.swift
//  Transposer
//
//  Created by Jonathan Tuzman on 7/7/18.
//  Copyright © 2018 Jonathan Tuzman. All rights reserved.
//

import Foundation

typealias MusicTextComponents = String
typealias MusicLine = [MusicTextComponents]

class Song {
	
	var lines = MusicLine()
	var text = String() {
		didSet {
			self.lines = text.split(separator: "\n").map {String($0)}
		}
	}
	
	func transpose(from sourceKey: Key, to destKey: Key) -> String {
		var newText = ""
		for line in self.lines {
			if line.isMusicLine {
				newText.append(line.transpose(from: sourceKey, to: destKey) + "\n")
			} else {
				newText.append(line + "\n")
			}
		}
		return newText
	}
	
}
