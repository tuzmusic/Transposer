//
//  KeyPickerViewController.swift
//  Transposer
//
//  Created by Jonathan Tuzman on 7/13/18.
//  Copyright © 2018 Jonathan Tuzman. All rights reserved.
//

import UIKit

class KeyPickerViewController: UITableViewController {
	
	@IBOutlet weak var keyPickerTable: UITableView! {
		didSet {
			keyPickerTable.contentInset = UIEdgeInsetsMake(30, 30, 30, 30)
		}
	}
	@IBOutlet weak var allKeyStackView: UIStackView! {
		didSet {
			configureButtons()
		}
	}
	
	var fromKey: Key!
	var toKey: Key!
	
	func configure(button: UIButton, number i: Int) {
		// appearance
		button.borderWidth = 1
		button.borderColor = button.currentTitleColor
		button.cornerRadius = 50
		
		
		// label
		// TO-DO: put keys in a nicer order
		button.setTitle(i < Music.circleOfFifths.count ? String(Music.circleOfFifths[i].name!.split(separator: " ")[0]) : "", for: .normal)
	
		button.addTarget(self, action: #selector(setFromKey(sender:)), for: .touchUpInside)
	}
	
	@objc func setFromKey(sender: UIButton) {
		fromKey = Key(sender.titleLabel!.text!)
	}
	
	func configureButtons() {
		var i = 0
		for row in allKeyStackView.subviews where row is UIStackView {
			for buttonView in row.subviews where buttonView is UIButton {
				configure(button: buttonView as! UIButton, number: i)
				i += 1
			}
		}
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return tableView.bounds.size.height / 2
	}
}
