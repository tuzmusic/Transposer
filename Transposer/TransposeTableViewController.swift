//
//  TransposeTableViewController.swift
//  Transposer
//
//  Created by Jonathan Tuzman on 6/17/18.
//  Copyright © 2018 Jonathan Tuzman. All rights reserved.
//

import UIKit

class TransposeTableViewController: UITableViewController {
	
	var sourceKey = Key("C")!
	var destKey = Key("G")!
	
	@IBOutlet weak var sourceTextView: UITextView!
	@IBOutlet weak var destTextView: UITextView!
	@IBAction func transposeTapped() {
		guard let sourceText = sourceTextView.text else { return }
		destTextView.text = sourceText.transpose(from: sourceKey, to: destKey)
	}
}
