//
//  KeyPickerViewController.swift
//  Transposer
//
//  Created by Jonathan Tuzman on 7/13/18.
//  Copyright © 2018 Jonathan Tuzman. All rights reserved.
//

import UIKit

class KeyPickerViewController: UITableViewController {
	
	@IBOutlet var keyPickerTable: UITableView! {
		didSet {
			keyPickerTable.contentInset = UIEdgeInsetsMake(30, 30, 30, 30)
		}
	}
	@IBOutlet weak var allKeyStackView: UIStackView! {
		didSet { configureButtons() }
	}
	func configureButtons() {
		var i = 0
		for row in allKeyStackView.subviews where row is UIStackView {
			for buttonView in row.subviews where buttonView is UIButton {
				let button = buttonView as! UIButton
				
				button.borderWidth = 1
				button.borderColor = button.currentTitleColor
				button.cornerRadius = 50
				
				if i < Music.circleOfFifths.count {
					button.s`etTitle(String(Music.circleOfFifths[i].name!.split(separator: " ")[0]), for: .normal)
					i += 1
				} else {
					button.setTitle("", for: .normal)
				}
			}
		}
	}
	
//	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//		if let cell = super.tableView.cellForRow(at: indexPath) {
//			cell.separatorInset = UIEdgeInsetsMake(30, 30, 30, 30)
//			return cell
//		}
//		return UITableViewCell()
//	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return tableView.bounds.size.height / 2
	}
}
