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
			configure(keyPickerTable)
		}
	}
	
	var fromKey: Key?
	var toKey: Key?
	var fromButtons = [UIButton]()
	var toButtons = [UIButton]()
	
	fileprivate func configure(_ stackView: UIStackView, in sect: Int) {
		var i = 0
		for row in stackView.subviews where row is UIStackView {
			for buttonView in row.subviews where buttonView is UIButton {
				let button = buttonView as! UIButton
				configure(button, number: i)
				i += 1
				if sect == 0 {
					toButtons.append(button)
				} else {
					fromButtons.append(button)
				}
			}
		}
	}
	
	fileprivate func configure(_ table: UITableView) {
		for sect in 0..<numberOfSections(in: table) {
			let cell = tableView(table, cellForRowAt: IndexPath(row: 0, section: sect))
			
			let inset: CGFloat = 500
			cell.separatorInset = UIEdgeInsetsMake(inset, inset, inset, inset)
			
			if let allKeysStackView = cell.contentView.subviews.first as? UIStackView {
				configure(allKeysStackView, in: sect)
			}
		}
	}
	
	fileprivate func configure(_ button: UIButton, number i: Int) {
		// appearance
		button.borderWidth = 1
		button.borderColor = button.currentTitleColor
		button.cornerRadius = 50
		
		// label
		// TO-DO: put keys in a nicer order
		if i < Music.circleOfFifths.count {
			button.setTitle(String(Music.circleOfFifths[i].name!.split(separator: " ")[0]), for: .normal)
		} else {
			button.setTitle("", for: .normal)
		}
		
		button.addTarget(self, action: #selector(keyButtonTapped(button:)), for: .touchUpInside)
	}
	
	@objc func keyButtonTapped(button: UIButton) {
		let array = fromButtons.contains(button) ? fromButtons : toButtons
		for b in array where b != button { b.isSelected = false }
		button.isSelected = !button.isSelected
		
		let title = button.isSelected ? Key(button.titleLabel!.text!) : nil
		if array == fromButtons {
			fromKey = title
		} else {
			toKey = title
		}
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return tableView.bounds.size.height / 2 * 0.8
	}
}
