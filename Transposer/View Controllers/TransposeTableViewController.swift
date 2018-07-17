//
//  TransposeTableViewController.swift
//  Transposer
//
//  Created by Jonathan Tuzman on 6/17/18.
//  Copyright © 2018 Jonathan Tuzman. All rights reserved.
//

import UIKit

class TransposeTableViewController: UITableViewController, KeyPickerDelegate {
	
	var sourceKey: Key! {
		didSet {
			if let name = sourceKey?.name?.components(separatedBy: " ").first {
				fromButtonItem.title = "From \(name)"
			}
		}
	}
	var destKey: Key! {
		didSet {
			if let name = destKey?.name?.components(separatedBy: " ").first {
				toButtonItem.title = "To \(name)"
			}
		}
	}
	
	var delegatedKey: Key?
	
	var song: Song!
	var fromButtonItem: UIBarButtonItem!
	var toButtonItem: UIBarButtonItem!
	
	override func viewDidLoad() {
		let tap = UITapGestureRecognizer(target: self, action: #selector(fromKeyTapped(_:)))
		let view = UIButton()
		view.titleLabel?.text = "'From' Key"
		view.addGestureRecognizer(tap)
		
		fromButtonItem = UIBarButtonItem(title: "'From' key", style: .plain, target: self, action: #selector(fromKeyTapped(_:)))
		toButtonItem = UIBarButtonItem(title: "'To' key", style: .plain, target: self, action: #selector(toKeyTapped(_:)))
		navigationItem.rightBarButtonItems = [ toButtonItem, fromButtonItem ]
	}
	
	@objc func fromKeyTapped(_ button: UIBarButtonItem) {
		setKey(presentingFrom: button) { self.sourceKey = self.delegatedKey }
	}
	
	@objc func toKeyTapped(_ button: UIBarButtonItem) {
		setKey(presentingFrom: button) { self.destKey = self.delegatedKey }
	}
	
	fileprivate func setKey(presentingFrom buttonItem: UIBarButtonItem, with action: (@escaping ()->())) {
		let picker = KeyPickerTableViewController()
		picker.delegate = self
		picker.action = action
		picker.modalPresentationStyle = .popover
		picker.popoverPresentationController?.barButtonItem = buttonItem
		present(picker, animated: true, completion: nil)
	}
	
	@IBOutlet weak var sourceTextView: UITextView!
	@IBOutlet weak var destTextView: UITextView!
	
	@IBAction func transposeTapped() {
		guard let sourceText = sourceTextView.text else { return }
		guard let sourceKey = sourceKey, let destKey = destKey else {
			// alert: Please select to/from key
			return
		}
		destTextView.text = sourceText.transpose(from: sourceKey, to: destKey)
	}
}
