//
//  PS2AllocationViewController.swift
//  BaplieScrubber
//
//  Created by Joshua Kraft on 12/11/18.
//  Copyright © 2018 Joshua Kraft. All rights reserved.
//

import Cocoa

protocol PS2AllocationViewControllerDelegate: class {
    func passAllocations(allocations: [String: [String : Int]])
    func passSavedAllocations(allocs: [String: String])
}

class PS2AllocationViewController: NSViewController {

    var oneAllocations = [
        "oneKBEs2": 0,
        "oneKBEs4": 0,
        "oneKBEc4": 0,
        "oneKBEc5": 0,
        "oneNAGs2": 0,
        "oneNAGs4": 0,
        "oneNAGc4": 0,
        "oneNAGc5": 0,
        "oneSHZs2": 0,
        "oneSHZs4": 0,
        "oneSHZc4": 0,
        "oneSHZc5": 0,
        "oneTKYs2": 0,
        "oneTKYs4": 0,
        "oneTKYc4": 0,
        "oneTKYc5": 0,
        ]
    
    @IBOutlet var oneKBEs2: NSTextField!
    @IBOutlet var oneKBEs4: NSTextField!
    @IBOutlet var oneKBEc4: NSTextField!
    @IBOutlet var oneKBEc5: NSTextField!
    
    @IBOutlet var oneNAGs2: NSTextField!
    @IBOutlet var oneNAGs4: NSTextField!
    @IBOutlet var oneNAGc4: NSTextField!
    @IBOutlet var oneNAGc5: NSTextField!
    
    @IBOutlet var oneSHZs2: NSTextField!
    @IBOutlet var oneSHZs4: NSTextField!
    @IBOutlet var oneSHZc4: NSTextField!
    @IBOutlet var oneSHZc5: NSTextField!
    
    @IBOutlet var oneTKYs2: NSTextField!
    @IBOutlet var oneTKYs4: NSTextField!
    @IBOutlet var oneTKYc4: NSTextField!
    @IBOutlet var oneTKYc5: NSTextField!
    
    
    
    var hlcAllocations = [
        "hlcKBEs2": 0,
        "hlcKBEs4": 0,
        "hlcKBEc4": 0,
        "hlcKBEc5": 0,
        "hlcNAGs2": 0,
        "hlcNAGs4": 0,
        "hlcNAGc4": 0,
        "hlcNAGc5": 0,
        "hlcSHZs2": 0,
        "hlcSHZs4": 0,
        "hlcSHZc4": 0,
        "hlcSHZc5": 0,
        "hlcTKYs2": 0,
        "hlcTKYs4": 0,
        "hlcTKYc4": 0,
        "hlcTKYc5": 0,
        ]
    
    @IBOutlet var hlcKBEs2: NSTextField!
    @IBOutlet var hlcKBEs4: NSTextField!
    @IBOutlet var hlcKBEc4: NSTextField!
    @IBOutlet var hlcKBEc5: NSTextField!
    
    @IBOutlet var hlcNAGs2: NSTextField!
    @IBOutlet var hlcNAGs4: NSTextField!
    @IBOutlet var hlcNAGc4: NSTextField!
    @IBOutlet var hlcNAGc5: NSTextField!
    
    @IBOutlet var hlcSHZs2: NSTextField!
    @IBOutlet var hlcSHZs4: NSTextField!
    @IBOutlet var hlcSHZc4: NSTextField!
    @IBOutlet var hlcSHZc5: NSTextField!
    
    @IBOutlet var hlcTKYs2: NSTextField!
    @IBOutlet var hlcTKYs4: NSTextField!
    @IBOutlet var hlcTKYc4: NSTextField!
    @IBOutlet var hlcTKYc5: NSTextField!

    
    
    var ymlAllocations = [
        "ymlKBEs2": 0,
        "ymlKBEs4": 0,
        "ymlKBEc4": 0,
        "ymlKBEc5": 0,
        "ymlNAGs2": 0,
        "ymlNAGs4": 0,
        "ymlNAGc4": 0,
        "ymlNAGc5": 0,
        "ymlSHZs2": 0,
        "ymlSHZs4": 0,
        "ymlSHZc4": 0,
        "ymlSHZc5": 0,
        "ymlTKYs2": 0,
        "ymlTKYs4": 0,
        "ymlTKYc4": 0,
        "ymlTKYc5": 0,
        ]
    
    @IBOutlet var ymlKBEs2: NSTextField!
    @IBOutlet var ymlKBEs4: NSTextField!
    @IBOutlet var ymlKBEc4: NSTextField!
    @IBOutlet var ymlKBEc5: NSTextField!
    
    @IBOutlet var ymlNAGs2: NSTextField!
    @IBOutlet var ymlNAGs4: NSTextField!
    @IBOutlet var ymlNAGc4: NSTextField!
    @IBOutlet var ymlNAGc5: NSTextField!
    
    @IBOutlet var ymlSHZs2: NSTextField!
    @IBOutlet var ymlSHZs4: NSTextField!
    @IBOutlet var ymlSHZc4: NSTextField!
    @IBOutlet var ymlSHZc5: NSTextField!
    
    @IBOutlet var ymlTKYs2: NSTextField!
    @IBOutlet var ymlTKYs4: NSTextField!
    @IBOutlet var ymlTKYc4: NSTextField!
    @IBOutlet var ymlTKYc5: NSTextField!
    
    var textFields = [NSTextField]()
    var savedAllocations = [String: String]()

    weak var delegate: PS2AllocationViewControllerDelegate?
    
    override func viewDidLoad() {

        prepareTextFields()
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(resetSavedAllocations), name: Notification.Name("ResetSavedAllocations"), object: nil)

        super.viewDidLoad()
    }
    
    func prepareTextFields() {
        
        oneKBEs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneKBEs2")
        oneKBEs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneKBEs4")
        oneKBEc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneKBEc4")
        oneKBEc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneKBEc5")

        oneNAGs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneNAGs2")
        oneNAGs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneNAGs4")
        oneNAGc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneNAGc4")
        oneNAGc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneNAGc5")

        oneSHZs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneSHZs2")
        oneSHZs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneSHZs4")
        oneSHZc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneSHZc4")
        oneSHZc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneSHZc5")
        
        oneTKYs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneTKYs2")
        oneTKYs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneTKYs4")
        oneTKYc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneTKYc4")
        oneTKYc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneTKYc5")
        
        
        
        hlcKBEs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcKBEs2")
        hlcKBEs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcKBEs4")
        hlcKBEc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcKBEc4")
        hlcKBEc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcKBEc5")
        
        hlcNAGs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcNAGs2")
        hlcNAGs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcNAGs4")
        hlcNAGc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcNAGc4")
        hlcNAGc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcNAGc5")
        
        hlcSHZs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcSHZs2")
        hlcSHZs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcSHZs4")
        hlcSHZc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcSHZc4")
        hlcSHZc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcSHZc5")
        
        hlcTKYs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcTKYs2")
        hlcTKYs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcTKYs4")
        hlcTKYc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcTKYc4")
        hlcTKYc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcTKYc5")
        
        
        
        ymlKBEs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlKBEs2")
        ymlKBEs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlKBEs4")
        ymlKBEc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlKBEc4")
        ymlKBEc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlKBEc5")
        
        ymlNAGs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlNAGs2")
        ymlNAGs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlNAGs4")
        ymlNAGc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlNAGc4")
        ymlNAGc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlNAGc5")
        
        ymlSHZs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlSHZs2")
        ymlSHZs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlSHZs4")
        ymlSHZc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlSHZc4")
        ymlSHZc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlSHZc5")
        
        ymlTKYs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlTKYs2")
        ymlTKYs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlTKYs4")
        ymlTKYc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlTKYc4")
        ymlTKYc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlTKYc5")
        
        
        
        textFields.append(oneKBEs2)
        textFields.append(oneKBEs4)
        textFields.append(oneKBEc4)
        textFields.append(oneKBEc5)
        
        textFields.append(oneNAGs2)
        textFields.append(oneNAGs4)
        textFields.append(oneNAGc4)
        textFields.append(oneNAGc5)
        
        textFields.append(oneSHZs2)
        textFields.append(oneSHZs4)
        textFields.append(oneSHZc4)
        textFields.append(oneSHZc5)
        
        textFields.append(oneTKYs2)
        textFields.append(oneTKYs4)
        textFields.append(oneTKYc4)
        textFields.append(oneTKYc5)
        
        
        
        textFields.append(hlcKBEs2)
        textFields.append(hlcKBEs4)
        textFields.append(hlcKBEc4)
        textFields.append(hlcKBEc5)
        
        textFields.append(hlcNAGs2)
        textFields.append(hlcNAGs4)
        textFields.append(hlcNAGc4)
        textFields.append(hlcNAGc5)
        
        textFields.append(hlcSHZs2)
        textFields.append(hlcSHZs4)
        textFields.append(hlcSHZc4)
        textFields.append(hlcSHZc5)
        
        textFields.append(hlcTKYs2)
        textFields.append(hlcTKYs4)
        textFields.append(hlcTKYc4)
        textFields.append(hlcTKYc5)
        
        
        
        textFields.append(ymlKBEs2)
        textFields.append(ymlKBEs4)
        textFields.append(ymlKBEc4)
        textFields.append(ymlKBEc5)
        
        textFields.append(ymlNAGs2)
        textFields.append(ymlNAGs4)
        textFields.append(ymlNAGc4)
        textFields.append(ymlNAGc5)
        
        textFields.append(ymlSHZs2)
        textFields.append(ymlSHZs4)
        textFields.append(ymlSHZc4)
        textFields.append(ymlSHZc5)
        
        textFields.append(ymlTKYs2)
        textFields.append(ymlTKYs4)
        textFields.append(ymlTKYc4)
        textFields.append(ymlTKYc5)

    }

    func saveAllocations(allocations: [String: [String : Int]]) {
        
        for (_, allocation) in allocations {
            for (allocationType, allocationAmount) in allocation {
                savedAllocations.updateValue(String(allocationAmount), forKey: allocationType)
            }
        }
        
    }
    
    @objc func resetSavedAllocations() {
        savedAllocations.removeAll()
    }

    @IBAction func setAllocations(_ sender: Any) {

        oneAllocations.updateValue((Int(oneKBEs2.stringValue)) ?? 0, forKey: "oneKBEs2")
        oneAllocations.updateValue((Int(oneKBEs4.stringValue)) ?? 0, forKey: "oneKBEs4")
        oneAllocations.updateValue((Int(oneKBEc4.stringValue)) ?? 0, forKey: "oneKBEc4")
        oneAllocations.updateValue((Int(oneKBEc5.stringValue)) ?? 0, forKey: "oneKBEc5")
        
        oneAllocations.updateValue((Int(oneNAGs2.stringValue)) ?? 0, forKey: "oneNAGs2")
        oneAllocations.updateValue((Int(oneNAGs4.stringValue)) ?? 0, forKey: "oneNAGs4")
        oneAllocations.updateValue((Int(oneNAGc4.stringValue)) ?? 0, forKey: "oneNAGc4")
        oneAllocations.updateValue((Int(oneNAGc5.stringValue)) ?? 0, forKey: "oneNAGc5")
        
        oneAllocations.updateValue((Int(oneSHZs2.stringValue)) ?? 0, forKey: "oneSHZs2")
        oneAllocations.updateValue((Int(oneSHZs4.stringValue)) ?? 0, forKey: "oneSHZs4")
        oneAllocations.updateValue((Int(oneSHZc4.stringValue)) ?? 0, forKey: "oneSHZc4")
        oneAllocations.updateValue((Int(oneSHZc5.stringValue)) ?? 0, forKey: "oneSHZc5")
        
        oneAllocations.updateValue((Int(oneTKYs2.stringValue)) ?? 0, forKey: "oneTKYs2")
        oneAllocations.updateValue((Int(oneTKYs4.stringValue)) ?? 0, forKey: "oneTKYs4")
        oneAllocations.updateValue((Int(oneTKYc4.stringValue)) ?? 0, forKey: "oneTKYc4")
        oneAllocations.updateValue((Int(oneTKYc5.stringValue)) ?? 0, forKey: "oneTKYc5")

        
        
        hlcAllocations.updateValue((Int(hlcKBEs2.stringValue)) ?? 0, forKey: "hlcKBEs2")
        hlcAllocations.updateValue((Int(hlcKBEs4.stringValue)) ?? 0, forKey: "hlcKBEs4")
        hlcAllocations.updateValue((Int(hlcKBEc4.stringValue)) ?? 0, forKey: "hlcKBEc4")
        hlcAllocations.updateValue((Int(hlcKBEc5.stringValue)) ?? 0, forKey: "hlcKBEc5")
        
        hlcAllocations.updateValue((Int(hlcNAGs2.stringValue)) ?? 0, forKey: "hlcNAGs2")
        hlcAllocations.updateValue((Int(hlcNAGs4.stringValue)) ?? 0, forKey: "hlcNAGs4")
        hlcAllocations.updateValue((Int(hlcNAGc4.stringValue)) ?? 0, forKey: "hlcNAGc4")
        hlcAllocations.updateValue((Int(hlcNAGc5.stringValue)) ?? 0, forKey: "hlcNAGc5")
        
        hlcAllocations.updateValue((Int(hlcSHZs2.stringValue)) ?? 0, forKey: "hlcSHZs2")
        hlcAllocations.updateValue((Int(hlcSHZs4.stringValue)) ?? 0, forKey: "hlcSHZs4")
        hlcAllocations.updateValue((Int(hlcSHZc4.stringValue)) ?? 0, forKey: "hlcSHZc4")
        hlcAllocations.updateValue((Int(hlcSHZc5.stringValue)) ?? 0, forKey: "hlcSHZc5")
        
        hlcAllocations.updateValue((Int(hlcTKYs2.stringValue)) ?? 0, forKey: "hlcTKYs2")
        hlcAllocations.updateValue((Int(hlcTKYs4.stringValue)) ?? 0, forKey: "hlcTKYs4")
        hlcAllocations.updateValue((Int(hlcTKYc4.stringValue)) ?? 0, forKey: "hlcTKYc4")
        hlcAllocations.updateValue((Int(hlcTKYc5.stringValue)) ?? 0, forKey: "hlcTKYc5")

        ymlAllocations.updateValue((Int(ymlKBEs2.stringValue)) ?? 0, forKey: "ymlKBEs2")
        ymlAllocations.updateValue((Int(ymlKBEs4.stringValue)) ?? 0, forKey: "ymlKBEs4")
        ymlAllocations.updateValue((Int(ymlKBEc4.stringValue)) ?? 0, forKey: "ymlKBEc4")
        ymlAllocations.updateValue((Int(ymlKBEc5.stringValue)) ?? 0, forKey: "ymlKBEc5")
        
        ymlAllocations.updateValue((Int(ymlNAGs2.stringValue)) ?? 0, forKey: "ymlNAGs2")
        ymlAllocations.updateValue((Int(ymlNAGs4.stringValue)) ?? 0, forKey: "ymlNAGs4")
        ymlAllocations.updateValue((Int(ymlNAGc4.stringValue)) ?? 0, forKey: "ymlNAGc4")
        ymlAllocations.updateValue((Int(ymlNAGc5.stringValue)) ?? 0, forKey: "ymlNAGc5")
        
        ymlAllocations.updateValue((Int(ymlSHZs2.stringValue)) ?? 0, forKey: "ymlSHZs2")
        ymlAllocations.updateValue((Int(ymlSHZs4.stringValue)) ?? 0, forKey: "ymlSHZs4")
        ymlAllocations.updateValue((Int(ymlSHZc4.stringValue)) ?? 0, forKey: "ymlSHZc4")
        ymlAllocations.updateValue((Int(ymlSHZc5.stringValue)) ?? 0, forKey: "ymlSHZc5")
        
        ymlAllocations.updateValue((Int(ymlTKYs2.stringValue)) ?? 0, forKey: "ymlTKYs2")
        ymlAllocations.updateValue((Int(ymlTKYs4.stringValue)) ?? 0, forKey: "ymlTKYs4")
        ymlAllocations.updateValue((Int(ymlTKYc4.stringValue)) ?? 0, forKey: "ymlTKYc4")
        ymlAllocations.updateValue((Int(ymlTKYc5.stringValue)) ?? 0, forKey: "ymlTKYc5")

        
        let allocations = ["ONE": oneAllocations, "HLC": hlcAllocations, "YML": ymlAllocations]
        
        delegate?.passAllocations(allocations: allocations)
        saveAllocations(allocations: allocations)
        delegate?.passSavedAllocations(allocs: savedAllocations)

        let nc = NotificationCenter.default
        nc.post(name: NSNotification.Name("AllocationsChanged"), object: nil)
        
        self.dismissViewController(self)

    }
    
}
