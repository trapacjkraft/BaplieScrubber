//
//  PS6AllocationViewController.swift
//  BaplieScrubber
//
//  Created by Joshua Kraft on 12/14/18.
//  Copyright © 2018 Joshua Kraft. All rights reserved.
//

import Cocoa

protocol PS6AllocationViewControllerDelegate: class {
    func passAllocations(allocations: [String: [String : Int]])
    func passSavedAllocations(allocs: [String: String])
}

class PS6AllocationViewController: NSViewController {
    
    var oneAllocations = [
        "oneBUSs2": 0,
        "oneBUSs4": 0,
        "oneBUSc4": 0,
        "oneBUSc5": 0,
        "oneNGBs2": 0,
        "oneNGBs4": 0,
        "oneNGBc4": 0,
        "oneNGBc5": 0,
        "oneSHGs2": 0,
        "oneSHGs4": 0,
        "oneSHGc4": 0,
        "oneSHGc5": 0,
        "oneTKYs2": 0,
        "oneTKYs4": 0,
        "oneTKYc4": 0,
        "oneTKYc5": 0
    ]

    @IBOutlet var oneBUSs2: NSTextField!
    @IBOutlet var oneBUSs4: NSTextField!
    @IBOutlet var oneBUSc4: NSTextField!
    @IBOutlet var oneBUSc5: NSTextField!
    
    @IBOutlet var oneNGBs2: NSTextField!
    @IBOutlet var oneNGBs4: NSTextField!
    @IBOutlet var oneNGBc4: NSTextField!
    @IBOutlet var oneNGBc5: NSTextField!
    
    @IBOutlet var oneSHGs2: NSTextField!
    @IBOutlet var oneSHGs4: NSTextField!
    @IBOutlet var oneSHGc4: NSTextField!
    @IBOutlet var oneSHGc5: NSTextField!
    
    @IBOutlet var oneTKYs2: NSTextField!
    @IBOutlet var oneTKYs4: NSTextField!
    @IBOutlet var oneTKYc4: NSTextField!
    @IBOutlet var oneTKYc5: NSTextField!
    
    
    var hlcAllocations = [
        "hlcBUSs2": 0,
        "hlcBUSs4": 0,
        "hlcBUSc4": 0,
        "hlcBUSc5": 0,
        "hlcNGBs2": 0,
        "hlcNGBs4": 0,
        "hlcNGBc4": 0,
        "hlcNGBc5": 0,
        "hlcSHGs2": 0,
        "hlcSHGs4": 0,
        "hlcSHGc4": 0,
        "hlcSHGc5": 0,
        "hlcTKYs2": 0,
        "hlcTKYs4": 0,
        "hlcTKYc4": 0,
        "hlcTKYc5": 0
    ]

    @IBOutlet var hlcBUSs2: NSTextField!
    @IBOutlet var hlcBUSs4: NSTextField!
    @IBOutlet var hlcBUSc4: NSTextField!
    @IBOutlet var hlcBUSc5: NSTextField!
    
    @IBOutlet var hlcNGBs2: NSTextField!
    @IBOutlet var hlcNGBs4: NSTextField!
    @IBOutlet var hlcNGBc4: NSTextField!
    @IBOutlet var hlcNGBc5: NSTextField!
    
    @IBOutlet var hlcSHGs2: NSTextField!
    @IBOutlet var hlcSHGs4: NSTextField!
    @IBOutlet var hlcSHGc4: NSTextField!
    @IBOutlet var hlcSHGc5: NSTextField!
    
    @IBOutlet var hlcTKYs2: NSTextField!
    @IBOutlet var hlcTKYs4: NSTextField!
    @IBOutlet var hlcTKYc4: NSTextField!
    @IBOutlet var hlcTKYc5: NSTextField!

    
    var ymlAllocations = [
        "ymlBUSs2": 0,
        "ymlBUSs4": 0,
        "ymlBUSc4": 0,
        "ymlBUSc5": 0,
        "ymlNGBs2": 0,
        "ymlNGBs4": 0,
        "ymlNGBc4": 0,
        "ymlNGBc5": 0,
        "ymlSHGs2": 0,
        "ymlSHGs4": 0,
        "ymlSHGc4": 0,
        "ymlSHGc5": 0,
        "ymlTKYs2": 0,
        "ymlTKYs4": 0,
        "ymlTKYc4": 0,
        "ymlTKYc5": 0
    ]

    @IBOutlet var ymlBUSs2: NSTextField!
    @IBOutlet var ymlBUSs4: NSTextField!
    @IBOutlet var ymlBUSc4: NSTextField!
    @IBOutlet var ymlBUSc5: NSTextField!
    
    @IBOutlet var ymlNGBs2: NSTextField!
    @IBOutlet var ymlNGBs4: NSTextField!
    @IBOutlet var ymlNGBc4: NSTextField!
    @IBOutlet var ymlNGBc5: NSTextField!
    
    @IBOutlet var ymlSHGs2: NSTextField!
    @IBOutlet var ymlSHGs4: NSTextField!
    @IBOutlet var ymlSHGc4: NSTextField!
    @IBOutlet var ymlSHGc5: NSTextField!
    
    @IBOutlet var ymlTKYs2: NSTextField!
    @IBOutlet var ymlTKYs4: NSTextField!
    @IBOutlet var ymlTKYc4: NSTextField!
    @IBOutlet var ymlTKYc5: NSTextField!

    var textFields = [NSTextField]()
    var savedAllocations = [String: String]()

    weak var delegate: PS6AllocationViewControllerDelegate?
    
    override func viewDidLoad() {

        prepareTextFields()
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(resetSavedAllocations), name: Notification.Name("ResetSavedAllocations"), object: nil)
        
        super.viewDidLoad()

    }
  
    func prepareTextFields() {
        
        oneBUSs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneBUSs2")
        oneBUSs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneBUSs4")
        oneBUSc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneBUSc4")
        oneBUSc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneBUSc5")
        
        oneNGBs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneNGBs2")
        oneNGBs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneNGBs4")
        oneNGBc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneNGBc4")
        oneNGBc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneNGBc5")
        
        oneSHGs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneSHGs2")
        oneSHGs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneSHGs4")
        oneSHGc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneSHGc4")
        oneSHGc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneSHGc5")
        
        oneTKYs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneTKYs2")
        oneTKYs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneTKYs4")
        oneTKYc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneTKYc4")
        oneTKYc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneTKYc5")

        
        
        hlcBUSs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcBUSs2")
        hlcBUSs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcBUSs4")
        hlcBUSc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcBUSc4")
        hlcBUSc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcBUSc5")
        
        hlcNGBs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcNGBs2")
        hlcNGBs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcNGBs4")
        hlcNGBc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcNGBc4")
        hlcNGBc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcNGBc5")
        
        hlcSHGs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcSHGs2")
        hlcSHGs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcSHGs4")
        hlcSHGc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcSHGc4")
        hlcSHGc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcSHGc5")
        
        hlcTKYs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcTKYs2")
        hlcTKYs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcTKYs4")
        hlcTKYc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcTKYc4")
        hlcTKYc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcTKYc5")

        
        
        ymlBUSs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlBUSs2")
        ymlBUSs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlBUSs4")
        ymlBUSc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlBUSc4")
        ymlBUSc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlBUSc5")
        
        ymlNGBs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlNGBs2")
        ymlNGBs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlNGBs4")
        ymlNGBc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlNGBc4")
        ymlNGBc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlNGBc5")
        
        ymlSHGs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlSHGs2")
        ymlSHGs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlSHGs4")
        ymlSHGc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlSHGc4")
        ymlSHGc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlSHGc5")
        
        ymlTKYs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlTKYs2")
        ymlTKYs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlTKYs4")
        ymlTKYc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlTKYc4")
        ymlTKYc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlTKYc5")

        
        
        textFields.append(oneBUSs2)
        textFields.append(oneBUSs4)
        textFields.append(oneBUSc4)
        textFields.append(oneBUSc5)
        
        textFields.append(oneNGBs2)
        textFields.append(oneNGBs4)
        textFields.append(oneNGBc4)
        textFields.append(oneNGBc5)
        
        textFields.append(oneSHGs2)
        textFields.append(oneSHGs4)
        textFields.append(oneSHGc4)
        textFields.append(oneSHGc5)
        
        textFields.append(oneTKYs2)
        textFields.append(oneTKYs4)
        textFields.append(oneTKYc4)
        textFields.append(oneTKYc5)

        
        
        textFields.append(hlcBUSs2)
        textFields.append(hlcBUSs4)
        textFields.append(hlcBUSc4)
        textFields.append(hlcBUSc5)
        
        textFields.append(hlcNGBs2)
        textFields.append(hlcNGBs4)
        textFields.append(hlcNGBc4)
        textFields.append(hlcNGBc5)
        
        textFields.append(hlcSHGs2)
        textFields.append(hlcSHGs4)
        textFields.append(hlcSHGc4)
        textFields.append(hlcSHGc5)
        
        textFields.append(hlcTKYs2)
        textFields.append(hlcTKYs4)
        textFields.append(hlcTKYc4)
        textFields.append(hlcTKYc5)

        
        
        textFields.append(ymlBUSs2)
        textFields.append(ymlBUSs4)
        textFields.append(ymlBUSc4)
        textFields.append(ymlBUSc5)
        
        textFields.append(ymlNGBs2)
        textFields.append(ymlNGBs4)
        textFields.append(ymlNGBc4)
        textFields.append(ymlNGBc5)
        
        textFields.append(ymlSHGs2)
        textFields.append(ymlSHGs4)
        textFields.append(ymlSHGc4)
        textFields.append(ymlSHGc5)
        
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
        
        oneAllocations.updateValue((Int(oneBUSs2.stringValue)) ?? 0, forKey: "oneBUSs2")
        oneAllocations.updateValue((Int(oneBUSs4.stringValue)) ?? 0, forKey: "oneBUSs4")
        oneAllocations.updateValue((Int(oneBUSc4.stringValue)) ?? 0, forKey: "oneBUSc4")
        oneAllocations.updateValue((Int(oneBUSc5.stringValue)) ?? 0, forKey: "oneBUSc5")
        
        oneAllocations.updateValue((Int(oneNGBs2.stringValue)) ?? 0, forKey: "oneNGBs2")
        oneAllocations.updateValue((Int(oneNGBs4.stringValue)) ?? 0, forKey: "oneNGBs4")
        oneAllocations.updateValue((Int(oneNGBc4.stringValue)) ?? 0, forKey: "oneNGBc4")
        oneAllocations.updateValue((Int(oneNGBc5.stringValue)) ?? 0, forKey: "oneNGBc5")
        
        oneAllocations.updateValue((Int(oneSHGs2.stringValue)) ?? 0, forKey: "oneSHGs2")
        oneAllocations.updateValue((Int(oneSHGs4.stringValue)) ?? 0, forKey: "oneSHGs4")
        oneAllocations.updateValue((Int(oneSHGc4.stringValue)) ?? 0, forKey: "oneSHGc4")
        oneAllocations.updateValue((Int(oneSHGc5.stringValue)) ?? 0, forKey: "oneSHGc5")
        
        oneAllocations.updateValue((Int(oneTKYs2.stringValue)) ?? 0, forKey: "oneTKYs2")
        oneAllocations.updateValue((Int(oneTKYs4.stringValue)) ?? 0, forKey: "oneTKYs4")
        oneAllocations.updateValue((Int(oneTKYc4.stringValue)) ?? 0, forKey: "oneTKYc4")
        oneAllocations.updateValue((Int(oneTKYc5.stringValue)) ?? 0, forKey: "oneTKYc5")

        hlcAllocations.updateValue((Int(hlcBUSs2.stringValue)) ?? 0, forKey: "hlcBUSs2")
        hlcAllocations.updateValue((Int(hlcBUSs4.stringValue)) ?? 0, forKey: "hlcBUSs4")
        hlcAllocations.updateValue((Int(hlcBUSc4.stringValue)) ?? 0, forKey: "hlcBUSc4")
        hlcAllocations.updateValue((Int(hlcBUSc5.stringValue)) ?? 0, forKey: "hlcBUSc5")
        
        hlcAllocations.updateValue((Int(hlcNGBs2.stringValue)) ?? 0, forKey: "hlcNGBs2")
        hlcAllocations.updateValue((Int(hlcNGBs4.stringValue)) ?? 0, forKey: "hlcNGBs4")
        hlcAllocations.updateValue((Int(hlcNGBc4.stringValue)) ?? 0, forKey: "hlcNGBc4")
        hlcAllocations.updateValue((Int(hlcNGBc5.stringValue)) ?? 0, forKey: "hlcNGBc5")
        
        hlcAllocations.updateValue((Int(hlcSHGs2.stringValue)) ?? 0, forKey: "hlcSHGs2")
        hlcAllocations.updateValue((Int(hlcSHGs4.stringValue)) ?? 0, forKey: "hlcSHGs4")
        hlcAllocations.updateValue((Int(hlcSHGc4.stringValue)) ?? 0, forKey: "hlcSHGc4")
        hlcAllocations.updateValue((Int(hlcSHGc5.stringValue)) ?? 0, forKey: "hlcSHGc5")
        
        hlcAllocations.updateValue((Int(hlcTKYs2.stringValue)) ?? 0, forKey: "hlcTKYs2")
        hlcAllocations.updateValue((Int(hlcTKYs4.stringValue)) ?? 0, forKey: "hlcTKYs4")
        hlcAllocations.updateValue((Int(hlcTKYc4.stringValue)) ?? 0, forKey: "hlcTKYc4")
        hlcAllocations.updateValue((Int(hlcTKYc5.stringValue)) ?? 0, forKey: "hlcTKYc5")

        ymlAllocations.updateValue((Int(ymlBUSs2.stringValue)) ?? 0, forKey: "ymlBUSs2")
        ymlAllocations.updateValue((Int(ymlBUSs4.stringValue)) ?? 0, forKey: "ymlBUSs4")
        ymlAllocations.updateValue((Int(ymlBUSc4.stringValue)) ?? 0, forKey: "ymlBUSc4")
        ymlAllocations.updateValue((Int(ymlBUSc5.stringValue)) ?? 0, forKey: "ymlBUSc5")
        
        ymlAllocations.updateValue((Int(ymlNGBs2.stringValue)) ?? 0, forKey: "ymlNGBs2")
        ymlAllocations.updateValue((Int(ymlNGBs4.stringValue)) ?? 0, forKey: "ymlNGBs4")
        ymlAllocations.updateValue((Int(ymlNGBc4.stringValue)) ?? 0, forKey: "ymlNGBc4")
        ymlAllocations.updateValue((Int(ymlNGBc5.stringValue)) ?? 0, forKey: "ymlNGBc5")
        
        ymlAllocations.updateValue((Int(ymlSHGs2.stringValue)) ?? 0, forKey: "ymlSHGs2")
        ymlAllocations.updateValue((Int(ymlSHGs4.stringValue)) ?? 0, forKey: "ymlSHGs4")
        ymlAllocations.updateValue((Int(ymlSHGc4.stringValue)) ?? 0, forKey: "ymlSHGc4")
        ymlAllocations.updateValue((Int(ymlSHGc5.stringValue)) ?? 0, forKey: "ymlSHGc5")
        
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
