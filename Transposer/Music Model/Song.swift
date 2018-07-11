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

class Song: Equatable {
	
	init() {}
	init(_ text: String) {
		self.text = text
		self.lines = text.split(separator: "\n").map {String($0)}
	}
	
	static func == (lh: Song, rh: Song) -> Bool {
		return lh.text == rh.text
	}
	
	var lines = MusicLine()
	var text = String() {
		didSet {
			self.lines = text.split(separator: "\n").map {String($0)}
		}
	}
	
	func transposed(from sourceKey: Key, to destKey: Key) -> Song {
		var newSong = Song()
		var newText = ""
		for line in self.lines {
			if line.isMusicLine {
				newText.append(line.transpose(from: sourceKey, to: destKey) + "\n")
			} else {
				newText.append(line + "\n")
			}
		}
		return Song(newText)
	}
	
	func transposed(fromString sourceKey: String, toString destKey: String) -> Song? {
		guard let source = Key(sourceKey), let dest = Key(destKey) else { return nil }
		return self.transposed(from: source, to: dest)
	}
	
}
