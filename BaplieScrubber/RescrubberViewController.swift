//
//  RescrubberViewController.swift
//  BaplieScrubber
//
//  Created by Joshua Kraft on 12/29/18.
//  Copyright © 2018 Joshua Kraft. All rights reserved.
//

import Cocoa

protocol RescrubberViewControllerDelegate: class {
    func getValuesToReplace(replacingValues: [Int: String])
    func getValuesToRemove(removingValues: [Int: String])
    func getReplacementValue(value: String)
}

class RescrubberViewController: NSViewController, RescrubberDelegate, ReplacementValuePopoverDelegate {

    @IBOutlet var tableView: NSTableView!
    
    @IBOutlet var replaceButton: NSButton!
    @IBOutlet var removeButton: NSButton!
    @IBOutlet var doneButton: NSButton!
    
    var data: [[String: String]]?
    
    var replacementValue = String()
    
    var hasReplacementValue = false {
        didSet {
            if hasReplacementValue {
                delegate?.getReplacementValue(value: replacementValue)
            }
        }
    }
    
    var needsReplacementValue = false {
        didSet {
            if needsReplacementValue {
                displayRVP()
            }
        }
    }
    
    weak var delegate: RescrubberViewControllerDelegate?
    
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
    
    
    @IBAction func getValuesToReplace(_ sender: NSButton) {
        
        let selectedRows = tableView.selectedRowIndexes
        var selectedValues = [Int: String]()
        
        for row in selectedRows {
            
            let lineNumber = Int((tableView.view(atColumn: 0, row: row, makeIfNecessary: false) as! NSTableCellView).textField!.stringValue)!
            let lineValue = (tableView.view(atColumn: 1, row: row, makeIfNecessary: false) as! NSTableCellView).textField!.stringValue
            
            data![row].updateValue("Yes", forKey: "editedStatus")
            
            selectedValues.updateValue(lineValue, forKey: lineNumber)
        }
        
        delegate?.getValuesToReplace(replacingValues: selectedValues)
            
        tableView.reloadData()
        
        needsReplacementValue = true
        
    }
    
    @IBAction func getValuesToRemove(_ sender: Any) {
        
        let selectedRows = tableView.selectedRowIndexes
        var selectedValues = [Int: String]()
        
        for row in selectedRows {
            
            let lineNumber = Int((tableView.view(atColumn: 0, row: row, makeIfNecessary: false) as! NSTableCellView).textField!.stringValue)!
            let lineValue = (tableView.view(atColumn: 1, row: row, makeIfNecessary: false) as! NSTableCellView).textField!.stringValue

            data![row].updateValue("Yes", forKey: "editedStatus")

            selectedValues.updateValue(lineValue, forKey: lineNumber)

        }
        
        delegate?.getValuesToRemove(removingValues: selectedValues)
        tableView.reloadData()

    }
    
    func displayRVP() {
        let vc: ReplacementValuePopover = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil).instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("ReplacementValuePopover")) as! ReplacementValuePopover
        vc.delegate = self
        
        presentViewController(vc, asPopoverRelativeTo: replaceButton.bounds, of: replaceButton, preferredEdge: .maxY, behavior: .applicationDefined)
    }
    
    func setReplacementValue(value: String) {
        replacementValue = value
        hasReplacementValue = true
    }
    
    
    func reset() {
        data?.removeAll()
        hasReplacementValue = false
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
