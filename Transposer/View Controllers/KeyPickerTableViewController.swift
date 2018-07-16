//
//  KeyPickerTableViewController.swift
//  Transposer
//
//  Created by Jonathan Tuzman on 7/15/18.
//  Copyright © 2018 Jonathan Tuzman. All rights reserved.
//

import UIKit

class KeyPickerTableViewController: UITableViewController {
    
    var keys = Music.allMajorKeys
    var selectedKey: Key?
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keys.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let keyForCell = keys[indexPath.row]
        cell.textLabel?.text = keyForCell.name
        cell.accessoryType = selectedKey == keyForCell ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tappedKey = keys[indexPath.row]
        selectedKey = selectedKey == tappedKey ? nil : tappedKey
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)        
    }
    
}
