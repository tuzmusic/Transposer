//
//  MusicText.swift
//  Transposer
//
//  Created by Jonathan Tuzman on 6/17/18.
//  Copyright © 2018 Jonathan Tuzman. All rights reserved.
//

import Foundation

extension String {
	
	
	
	func transpose(from sourceKey: Key, to destKey: Key) -> String {
		let newString = self
		var newComponents = MusicLine()
		
		for component in newString.split(separator: " ").map({String($0)}) {
			if component.looksLikeMusic, let chord = Chord(component) {
				newComponents.append(chord.transpose(from: sourceKey, to: destKey).symbol)
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
