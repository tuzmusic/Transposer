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
		var lines = [String]()
		var currentLine: String = ""
		for char in self.text {
			currentLine += String(char)
			if char == "\n" {
				lines.append(currentLine)
				currentLine = ""
			}
		}
		lines.append(String(currentLine))
		self.lines = lines
		//self.lines = text.split(separator: "\n").map {String($0)}
	}
	
	static func == (lh: Song, rh: Song) -> Bool {
		return lh.text == rh.text
	}
	
	subscript(x: Int) -> String {
		return lines[x].components(separatedBy: "\n").first!
	}
	
	var lines = MusicLine()
	var text = String() {
		didSet {
			self.lines = text.split(separator: "\n").map {String($0)}
		}
	}
	
	func transposed(from sourceKey: Key, to destKey: Key) -> Song {
		var newText = ""
		for line in self.lines {
			if line.isMusicLine_byCount {
				newText += line.transpose(from: sourceKey, to: destKey)
			} else {
				newText += line
			}
//			if line != self.lines.last! { newText += "\n" }
		}
		return Song(newText)
	}
	
	func transposed(fromString sourceKey: String, toString destKey: String) -> Song? {
		guard let source = Key(sourceKey), let dest = Key(destKey) else { return nil }
		return self.transposed(from: source, to: dest)
	}
	
}

extension Song {
	// MARK: Debugging functions
	
	func compare(to song2: Song, includePasses: Bool = true) {
		print("")
		for i in 0 ..< self.lines.count {
			if self[i] == song2[i] {
				if includePasses {
					print("Line \(i) passed")
				}
			} else {
				print("""
					Conflict in line \(i) (\(self[i].isMusicLine_byCount ? "music" : "not music"))
					Song 1:\t\(self[i])
					Song 2:\t\(song2[i])
					""")
			}
		}
		print("")
	}
}
