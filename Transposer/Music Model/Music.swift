import Foundation

extension Array where Element == Note {
	var string: String {
		return self.map{$0.name}.joined(separator: " ")
	}
}

public class Music {
	static let scalePatterns = ["major" : [0, 2, 4, 5, 7, 9, 11, 12]]
	public static let noteNames = [     ["C","B#"],
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
	public static let allNotes = noteNames.joined().joined(separator: " ").split(separator: " ").map{String($0)}
	enum Accidental: Int {
		case sharp = 1
		case flat = -1
		case natural = 0
	}
	static let accidentalSymbols: [Character : Music.Accidental] = ["#" :
		.sharp, "b" : .flat]
	
	static let circleOfFifths = allMajorKeys.sorted { return $0.value < $1.value }
	static let circleOfFifthsNames = circleOfFifths.map {$0.name!.split(separator: " ")[0]}.joined(separator: " ")
	static let orderOfAccidentals = Music.circleOfFifths.map { Music.newAcc3(in: $0) }
	
	static let allMajorKeys = getAllMajorKeys()
	class func getAllMajorKeys() -> [Key] {
		let allNotes = Music.noteNames.joined().joined(separator: " ").split(separator: " ")
		var allMajorKeys = [Key]()
		for note in allNotes {
			if let key = Key(note+" major") { allMajorKeys.append(key) }
		}
		return allMajorKeys
	}
	
	
	class func newAcc3(in key: Key) -> Note? {
		// get comparison key by comparing values
		guard key.value != 0 else { return nil }
		guard let prevKey = allMajorKeys.first(where: { $0.value == key.value + (key.value < 0 ? 1 : -1 )})
			else { return nil }
		
		return key.keySig.first(where:) { !prevKey.keySig.contains($0) } ?? nil
	}
		
	
}

extension Music {
	// Testing and trying
	/*
	class func sortedKeySig(for key: Key) -> [Note] {
		var rawKeySig = key.keySig
		var sortedKeySig = [Note]()
		if key.value > 0 {	// sharp keys
			while sortedKeySig.count > 1 {
				if let otherKey = allMajorKeys.first(where: { $0.value == sortedKeySig.count - 1 }),
					let nextAccidental = key.keySig.first(where: { !otherKey.keySig.contains($0) }) {
					sortedKeySig.append(nextAccidental)
					rawKeySig.remove(at: rawKeySig.index(of: nextAccidental)!)
				}
			}
			//let prevKey = allMajorKeys.first(where:) { $0.value == key.value - 1 }!
			
		}
		return sortedKeySig
	}
	
	class func newAcc(in key: Key) -> Note? {
		// get comparison key from circle of fifths
		let keys = circleOfFifthsKeys
		let keyPos = keys.index(of: key)!
		if keyPos == 0 {
			return key.keySig.first(where:) { !keys[keyPos+1].keySig.contains($0) }
		} else if keyPos == keys.count - 1 {
			return key.keySig.first(where:) { !keys[keyPos-1].keySig.contains($0) }
		}
		return key.keySig.first(where:) {
			!keys[keyPos-1].keySig.contains($0) || !keys[keyPos+1].keySig.contains($0)
		}
	}
	class func newAcc2(in key: Key) -> Note? {
		// get comparison key by comparing key signatures
		let prev = !key.sharps.isEmpty
			? allMajorKeys.first(where:) { $0.sharps.count == key.sharps.count - 1 }!
			: !key.flats.isEmpty
			? allMajorKeys.first(where:) { $0.flats.count == key.flats.count - 1 }!
			: nil
		guard let prevKey = prev else { return nil }
		return key.keySig.first(where:) { !prevKey.keySig.contains($0) } ?? nil
	}
	*/
}





