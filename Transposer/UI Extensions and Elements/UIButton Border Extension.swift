//
//  UIButton Border Extension.swift
//  Transposer
//
//  Created by Jonathan Tuzman on 7/13/18.
//  Copyright © 2018 Jonathan Tuzman. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable extension UIButton {
	
	@IBInspectable var borderWidth: CGFloat {
		set {
			layer.borderWidth = newValue
		}
		get {
			return layer.borderWidth
		}
	}
	
	@IBInspectable var cornerRadius: CGFloat {
		set {
			layer.cornerRadius = newValue
		}
		get {
			return layer.cornerRadius
		}
	}
	
	@IBInspectable var borderColor: UIColor? {
		set {
			guard let uiColor = newValue else { return }
			layer.borderColor = uiColor.cgColor
		}
		get {
			guard let color = layer.borderColor else { return nil }
			return UIColor(cgColor: color)
		}
	}
}
