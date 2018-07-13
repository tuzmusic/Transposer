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
			var i = 0
			for sect in 0..<numberOfSections(in: keyPickerTable) {
				let cell = tableView(keyPickerTable, cellForRowAt: IndexPath(row: 0, section: sect))
				if let allKeysStackView = cell.subviews.first?.subviews.first as? UIStackView {
					for row in allKeysStackView.subviews where row is UIStackView {
						for buttonView in row.subviews where buttonView is UIButton {
							configure(button: buttonView as! UIButton, number: i, toRatherThanFrom: false)
							i += 1
						}
					}
				}
			}
		}
	}
	
	var fromKey: Key?
	var toKey: Key?
	var fromButtons = [UIButton]()
	var toButtons = [UIButton]()
	
	func configure(button: UIButton, number i: Int, toRatherThanFrom: Bool) {
		// appearance
		button.borderWidth = 1
		button.borderColor = button.currentTitleColor
		button.cornerRadius = 50
		
		// label
		// TO-DO: put keys in a nicer order
		button.setTitle(i < Music.circleOfFifths.count
			? String(Music.circleOfFifths[i].name!.split(separator: " ")[0])
			: "", for: .normal)
		if toRatherThanFrom {
			button.addTarget(self, action: #selector(setToKey(button:)), for: .touchUpInside)
		} else {
			button.addTarget(self, action: #selector(setFromKey(button:)), for: .touchUpInside)
		}
		
		if toRatherThanFrom { toButtons.append(button) }
		else { fromButtons.append(button) }
	}
	
	@objc func setFromKey(button: UIButton) {
		for b in fromButtons where b != button {
			b.isSelected = false
		}
		button.isSelected = !button.isSelected
		fromKey = Key(button.titleLabel!.text!)
	}
	
	@objc func setToKey(button: UIButton) {
		for b in fromButtons where b != button {
			b.isSelected = false
		}
		button.isSelected = !button.isSelected
		toKey = Key(button.titleLabel!.text!)
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return tableView.bounds.size.height / 2 * 0.8
	}
}
