//
//  RescrubberViewController.swift
//  BaplieScrubber
//
//  Created by Joshua Kraft on 12/29/18.
//  Copyright © 2018 Joshua Kraft. All rights reserved.
//

import Cocoa

class RescrubberViewController: NSViewController, RescrubberDelegate {

    @IBOutlet var tableView: NSTableView!
    var data: [[String: String]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func getErrorLinesAndText(values: [[String : String]]) {
        data = values
        
    }
    
    @IBAction func exit(_ sender: Any) {
        data?.removeAll()
        tableView.reloadData()
        dismissViewController(self)
    }
    
    func reset() {
        data?.removeAll()
    }
    
}

extension RescrubberViewController: NSTableViewDataSource, NSTableViewDelegate {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return (data?.count)!
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let item = (data!)[row]
        
        let cell = tableView.makeView(withIdentifier: (tableColumn!.identifier), owner: self) as? NSTableCellView
        
        cell?.textField?.stringValue = item[(tableColumn?.identifier.rawValue)!]!
        
        return cell
        
    }
    
}
