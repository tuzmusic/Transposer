//
//  KeyButton.swift
//  Transposer
//
//  Created by Jonathan Tuzman on 7/13/18.
//  Copyright © 2018 Jonathan Tuzman. All rights reserved.
//

import UIKit

class KeyButton: UIButton {

	override open var isHighlighted: Bool {
		didSet {
			backgroundColor = isHighlighted ? UIColor.black : UIColor.white
		}
	}
}
