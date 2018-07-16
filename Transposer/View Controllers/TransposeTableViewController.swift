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
	
	var song: Song!
    var fromButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(fromKeyTapped(_:)))
        let view = UIButton()
        view.titleLabel?.text = "'From' Key"
        view.addGestureRecognizer(tap)

        fromButtonItem = UIBarButtonItem(title: "From key", style: .plain, target: self, action: #selector(fromKeyTapped(_:)))

        navigationItem.rightBarButtonItems = [ fromButtonItem ]
    }
    
    @objc func fromKeyTapped(_ button: UIButton) {
        print("from tapped")
        let picker = KeyPickerTableViewController()
        picker.modalPresentationStyle = .popover
        picker.popoverPresentationController?.barButtonItem = fromButtonItem
        present(picker, animated: true, completion: nil)
    }
	
	@IBOutlet weak var sourceTextView: UITextView!
	@IBOutlet weak var destTextView: UITextView!
	@IBAction func transposeTapped() {
		guard let sourceText = sourceTextView.text else { return }
		destTextView.text = sourceText.transpose(from: sourceKey, to: destKey)
	}
}
