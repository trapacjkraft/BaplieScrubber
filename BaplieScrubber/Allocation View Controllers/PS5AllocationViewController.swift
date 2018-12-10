//
//  PS5AllocationViewController.swift
//  BaplieScrubber
//
//  Created by Joshua Kraft on 11/7/18.
//  Copyright © 2018 Joshua Kraft. All rights reserved.
//

import Cocoa

protocol PS5AllocationViewControllerDelegate: class {
    func passAllocations(allocations: [String: [String : Int]])
}

class PS5AllocationViewController: NSViewController {

    
    var oneAllocations = [
        "oneNGBs2": 0,
        "oneNGBs4": 0,
        "oneNGBc4": 0,
        "oneNGBc5": 0,
        "oneQDOs2": 0,
        "oneQDOs4": 0,
        "oneQDOc4": 0,
        "oneQDOc5": 0,
        "oneSHGs2": 0,
        "oneSHGs4": 0,
        "oneSHGc4": 0,
        "oneSHGc5": 0
    ]
    
    var hlcAllocations = [
        "hlcNGBs2": 0,
        "hlcNGBs4": 0,
        "hlcNGBc4": 0,
        "hlcNGBc5": 0,
        "hlcQDOs2": 0,
        "hlcQDOs4": 0,
        "hlcQDOc4": 0,
        "hlcQDOc5": 0,
        "hlcSHGs2": 0,
        "hlcSHGs4": 0,
        "hlcSHGc4": 0,
        "hlcSHGc5": 0
    ]

    var ymlAllocations = [
        "ymlNGBs2": 0,
        "ymlNGBs4": 0,
        "ymlNGBc4": 0,
        "ymlNGBc5": 0,
        "ymlQDOs2": 0,
        "ymlQDOs4": 0,
        "ymlQDOc4": 0,
        "ymlQDOc5": 0,
        "ymlSHGs2": 0,
        "ymlSHGs4": 0,
        "ymlSHGc4": 0,
        "ymlSHGc5": 0
    ]

    weak var delegate: PS5AllocationViewControllerDelegate?
    
    @IBOutlet var oneNGBs2: NSTextField!
    @IBOutlet var oneNGBs4: NSTextField!
    @IBOutlet var oneNGBc4: NSTextField!
    @IBOutlet var oneNGBc5: NSTextField!
    
    @IBOutlet var oneQDOs2: NSTextField!
    @IBOutlet var oneQDOs4: NSTextField!
    @IBOutlet var oneQDOc4: NSTextField!
    @IBOutlet var oneQDOc5: NSTextField!
    
    @IBOutlet var oneSHGs2: NSTextField!
    @IBOutlet var oneSHGs4: NSTextField!
    @IBOutlet var oneSHGc4: NSTextField!
    @IBOutlet var oneSHGc5: NSTextField!
    
    @IBOutlet var hlcNGBs2: NSTextField!
    @IBOutlet var hlcNGBs4: NSTextField!
    @IBOutlet var hlcNGBc4: NSTextField!
    @IBOutlet var hlcNGBc5: NSTextField!
    
    @IBOutlet var hlcQDOs2: NSTextField!
    @IBOutlet var hlcQDOs4: NSTextField!
    @IBOutlet var hlcQDOc4: NSTextField!
    @IBOutlet var hlcQDOc5: NSTextField!
    
    @IBOutlet var hlcSHGs2: NSTextField!
    @IBOutlet var hlcSHGs4: NSTextField!
    @IBOutlet var hlcSHGc4: NSTextField!
    @IBOutlet var hlcSHGc5: NSTextField!
    
    @IBOutlet var ymlNGBs2: NSTextField!
    @IBOutlet var ymlNGBs4: NSTextField!
    @IBOutlet var ymlNGBc4: NSTextField!
    @IBOutlet var ymlNGBc5: NSTextField!
    
    @IBOutlet var ymlQDOs2: NSTextField!
    @IBOutlet var ymlQDOs4: NSTextField!
    @IBOutlet var ymlQDOc4: NSTextField!
    @IBOutlet var ymlQDOc5: NSTextField!
    
    @IBOutlet var ymlSHGs2: NSTextField!
    @IBOutlet var ymlSHGs4: NSTextField!
    @IBOutlet var ymlSHGc4: NSTextField!
    @IBOutlet var ymlSHGc5: NSTextField!
    
    @IBOutlet var allocationButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func setAllocations(_ sender: Any) {
        
        oneAllocations.updateValue((Int(oneNGBs2.stringValue)) ?? 0, forKey: "oneNGBs2")
        oneAllocations.updateValue((Int(oneNGBs4.stringValue)) ?? 0, forKey: "oneNGBs4")
        oneAllocations.updateValue((Int(oneNGBc4.stringValue)) ?? 0, forKey: "oneNGBc4")
        oneAllocations.updateValue((Int(oneNGBc5.stringValue)) ?? 0, forKey: "oneNGBc5")
        
        oneAllocations.updateValue((Int(oneQDOs2.stringValue)) ?? 0, forKey: "oneQDOs2")
        oneAllocations.updateValue((Int(oneQDOs4.stringValue)) ?? 0, forKey: "oneQDOs4")
        oneAllocations.updateValue((Int(oneQDOc4.stringValue)) ?? 0, forKey: "oneQDOc4")
        oneAllocations.updateValue((Int(oneQDOc5.stringValue)) ?? 0, forKey: "oneQDOc5")
        
        oneAllocations.updateValue((Int(oneSHGs2.stringValue)) ?? 0, forKey: "oneSHGs2")
        oneAllocations.updateValue((Int(oneSHGs4.stringValue)) ?? 0, forKey: "oneSHGs4")
        oneAllocations.updateValue((Int(oneSHGc4.stringValue)) ?? 0, forKey: "oneSHGc4")
        oneAllocations.updateValue((Int(oneSHGc5.stringValue)) ?? 0, forKey: "oneSHGc5")

        hlcAllocations.updateValue((Int(hlcNGBs2.stringValue)) ?? 0, forKey: "hlcNGBs2")
        hlcAllocations.updateValue((Int(hlcNGBs4.stringValue)) ?? 0, forKey: "hlcNGBs4")
        hlcAllocations.updateValue((Int(hlcNGBc4.stringValue)) ?? 0, forKey: "hlcNGBc4")
        hlcAllocations.updateValue((Int(hlcNGBc5.stringValue)) ?? 0, forKey: "hlcNGBc5")
        
        hlcAllocations.updateValue((Int(hlcQDOs2.stringValue)) ?? 0, forKey: "hlcQDOs2")
        hlcAllocations.updateValue((Int(hlcQDOs4.stringValue)) ?? 0, forKey: "hlcQDOs4")
        hlcAllocations.updateValue((Int(hlcQDOc4.stringValue)) ?? 0, forKey: "hlcQDOc4")
        hlcAllocations.updateValue((Int(hlcQDOc5.stringValue)) ?? 0, forKey: "hlcQDOc5")
        
        hlcAllocations.updateValue((Int(hlcSHGs2.stringValue)) ?? 0, forKey: "hlcSHGs2")
        hlcAllocations.updateValue((Int(hlcSHGs4.stringValue)) ?? 0, forKey: "hlcSHGs4")
        hlcAllocations.updateValue((Int(hlcSHGc4.stringValue)) ?? 0, forKey: "hlcSHGc4")
        hlcAllocations.updateValue((Int(hlcSHGc5.stringValue)) ?? 0, forKey: "hlcSHGc5")

        ymlAllocations.updateValue((Int(ymlNGBs2.stringValue)) ?? 0, forKey: "ymlNGBs2")
        ymlAllocations.updateValue((Int(ymlNGBs4.stringValue)) ?? 0, forKey: "ymlNGBs4")
        ymlAllocations.updateValue((Int(ymlNGBc4.stringValue)) ?? 0, forKey: "ymlNGBc4")
        ymlAllocations.updateValue((Int(ymlNGBc5.stringValue)) ?? 0, forKey: "ymlNGBc5")
        
        ymlAllocations.updateValue((Int(ymlQDOs2.stringValue)) ?? 0, forKey: "ymlQDOs2")
        ymlAllocations.updateValue((Int(ymlQDOs4.stringValue)) ?? 0, forKey: "ymlQDOs4")
        ymlAllocations.updateValue((Int(ymlQDOc4.stringValue)) ?? 0, forKey: "ymlQDOc4")
        ymlAllocations.updateValue((Int(ymlQDOc5.stringValue)) ?? 0, forKey: "ymlQDOc5")
        
        ymlAllocations.updateValue((Int(ymlSHGs2.stringValue)) ?? 0, forKey: "ymlSHGs2")
        ymlAllocations.updateValue((Int(ymlSHGs4.stringValue)) ?? 0, forKey: "ymlSHGs4")
        ymlAllocations.updateValue((Int(ymlSHGc4.stringValue)) ?? 0, forKey: "ymlSHGc4")
        ymlAllocations.updateValue((Int(ymlSHGc5.stringValue)) ?? 0, forKey: "ymlSHGc5")

        let allocations = ["ONE": oneAllocations, "HLC": hlcAllocations, "YML": ymlAllocations]
        
        delegate?.passAllocations(allocations: allocations)
        
        let nc = NotificationCenter.default
        nc.post(name: NSNotification.Name("AllocationsChanged"), object: nil)
        
        self.dismissViewController(self)
        
        
    }
    
}
