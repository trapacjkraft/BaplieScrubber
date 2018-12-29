//
//  ScourerViewController.swift
//  BaplieScrubber
//
//  Created by Joshua Kraft on 12/25/18.
//  Copyright © 2018 Joshua Kraft. All rights reserved.
//

import Cocoa

class ScourerViewController: NSViewController, ScourerDelegate {

    @IBOutlet var tableView: NSTableView!
    
    var errorLines = [Int]()
    var errorLineText = [String]()
    
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func getErrorLineNumbers(numbers: [Int]) {
        errorLines = numbers
    }
    
    func getErrorLineValues(values: [String]) {
        errorLineText = values
    }
    
}

extension ScourerViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return errorLines.count
    }
}

extension ScourerViewController: NSTableViewDelegate {
    enum CellIdentifiers {
        static let LineCell = "LineCellID"
        static let TextCell = "TextCellID"
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var text = ""
        var cellIdentifier = ""
        
        guard !errorLines.isEmpty else { return nil }
        
        let lineNumber = errorLines[row]
        let lineText = errorLineText[row]
        
        if tableColumn == tableView.tableColumns[0] {
            text = String(lineNumber)
            cellIdentifier = CellIdentifiers.LineCell
        } else if tableColumn == tableView.tableColumns[1] {
            text = lineText
        }
        
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
            return cell
        }
        return nil
    }
}
