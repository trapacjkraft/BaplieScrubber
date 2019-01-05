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
    func rescrub()
}

class RescrubberViewController: NSViewController, RescrubberDelegate, ReplacementValuePopoverDelegate {

    @IBOutlet var tableView: NSTableView!
    
    @IBOutlet var replaceButton: NSButton!
    @IBOutlet var removeButton: NSButton!
    @IBOutlet var editedTrackerLabel: NSTextField!
    @IBOutlet var doneButton: NSButton!
    
    var data: [[String: String]]?
    
    var editedCount = 0 {
        didSet {
            if editedCount == lineCount {
                doneButton.isEnabled = true
            }
        }
    }
    
    var lineCount = 0
    
    var defaultReplacementValue = String()
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
        
        lineCount = data!.count
        
        updateEditedTrackerLabel()
        
    }
    
    func updateEditedTrackerLabel() {
        editedTrackerLabel.stringValue = "\(editedCount)/\(lineCount) Values Replaced"
    }
    
    func getErrorLinesAndText(values: [[String : String]]) {
        data = values
        
    }
    
    func resetReplacementValue() {
        replacementValue = ""
        needsReplacementValue = false
    }
    
    @IBAction func exit(_ sender: Any) {
        data?.removeAll()
        tableView.reloadData()
        delegate?.rescrub()
        dismissViewController(self)
        
    }
    
    
    @IBAction func getValuesToReplace(_ sender: NSButton) {
        
        let selectedRows = tableView.selectedRowIndexes
        var selectedValues = [Int: String]()
        
        for row in selectedRows {
            
            let lineNumber = Int((tableView.view(atColumn: 0, row: row, makeIfNecessary: false) as! NSTableCellView).textField!.stringValue)!
            let lineValue = (tableView.view(atColumn: 1, row: row, makeIfNecessary: false) as! NSTableCellView).textField!.stringValue
            
            data![row].updateValue("Yes", forKey: "editedStatus")
            editedCount += 1
            
            selectedValues.updateValue(lineValue, forKey: lineNumber)
        }
        
        delegate?.getValuesToReplace(replacingValues: selectedValues)
        tableView.reloadData()
        
        defaultReplacementValue = selectedValues.first!.value
        needsReplacementValue = true
        
        updateEditedTrackerLabel()
        
        
    }
    
    @IBAction func getValuesToRemove(_ sender: Any) {
        
        let selectedRows = tableView.selectedRowIndexes
        var selectedValues = [Int: String]()
        
        for row in selectedRows {
            
            let lineNumber = Int((tableView.view(atColumn: 0, row: row, makeIfNecessary: true) as! NSTableCellView).textField!.stringValue)!
            let lineValue = (tableView.view(atColumn: 1, row: row, makeIfNecessary: false) as! NSTableCellView).textField!.stringValue

            data![row].updateValue("Yes", forKey: "editedStatus")
            editedCount += 1

            selectedValues.updateValue(lineValue, forKey: lineNumber)

        }
        
        delegate?.getValuesToRemove(removingValues: selectedValues)
        tableView.reloadData()
        updateEditedTrackerLabel()

    }
    
    func displayRVP() {
        let vc: ReplacementValuePopover = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil).instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("ReplacementValuePopover")) as! ReplacementValuePopover
        vc.delegate = self
        
        presentViewController(vc, asPopoverRelativeTo: replaceButton.bounds, of: replaceButton, preferredEdge: .maxY, behavior: .applicationDefined)
        vc.replacementValueField.stringValue = defaultReplacementValue
    }
    
    func setReplacementValue(value: String) {
        replacementValue = value
        hasReplacementValue = true
        needsReplacementValue = false
    }
    
    
    func reset() {
        data?.removeAll()
        hasReplacementValue = false
        needsReplacementValue = false
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
