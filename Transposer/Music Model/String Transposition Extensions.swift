//
//  MusicText.swift
//  Transposer
//
//  Created by Jonathan Tuzman on 6/17/18.
//  Copyright © 2018 Jonathan Tuzman. All rights reserved.
//

import Foundation

extension MusicText {
	static func musicalComponents(from string: String) -> (components: [String], separator: String) {
		var subcomponents = [string]
		var separator = " "
		for sep in MusicText.separators {
			if string.contains(sep) {
				subcomponents = string.components(separatedBy: sep)
				separator = sep
			}
		}
		return (subcomponents, separator)
	}
}
	
	extension String {
	
	func transpose(from sourceKey: Key, to destKey: Key) -> String {
		let newString = self
		var newComponents = MusicLine()
		
		for component in newString.split(separator: " ").map({String($0)}) {
			if component.looksLikeMusic {
				let separated = MusicText.musicalComponents(from: component)
				var newSubcomponents = [String]()
				for subcomponent in separated.components {
					newSubcomponents.append(Chord(subcomponent)?.transpose(from: sourceKey, to: destKey).symbol ?? "")
				}
				newComponents.append(newSubcomponents.joined(separator: separated.separator))
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
