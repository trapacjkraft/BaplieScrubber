//
//  PS7AllocationViewController.swift
//  BaplieScrubber
//
//  Created by Joshua Kraft on 12/14/18.
//  Copyright © 2018 Joshua Kraft. All rights reserved.
//

import Cocoa

protocol PS7AllocationViewControllerDelegate: class {
    func passAllocations(allocations: [String: [String : Int]])
}

class PS7AllocationViewController: NSViewController {
    
    var oneAllocations = [
        "oneHKGs2": 0,
        "oneHKGs4": 0,
        "oneHKGc4": 0,
        "oneHKGc5": 0,
        "oneXMNs2": 0,
        "oneXMNs4": 0,
        "oneXMNc4": 0,
        "oneXMNc5": 0,
        "oneYTIs2": 0,
        "oneYTIs4": 0,
        "oneYTIc4": 0,
        "oneYTIc5": 0
    ]
    
    @IBOutlet var oneHKGs2: NSTextField!
    @IBOutlet var oneHKGs4: NSTextField!
    @IBOutlet var oneHKGc4: NSTextField!
    @IBOutlet var oneHKGc5: NSTextField!
    
    @IBOutlet var oneXMNs2: NSTextField!
    @IBOutlet var oneXMNs4: NSTextField!
    @IBOutlet var oneXMNc4: NSTextField!
    @IBOutlet var oneXMNc5: NSTextField!
    
    @IBOutlet var oneYTIs2: NSTextField!
    @IBOutlet var oneYTIs4: NSTextField!
    @IBOutlet var oneYTIc4: NSTextField!
    @IBOutlet var oneYTIc5: NSTextField!
    
    
    
    var hlcAllocations = [
        "hlcHKGs2": 0,
        "hlcHKGs4": 0,
        "hlcHKGc4": 0,
        "hlcHKGc5": 0,
        "hlcXMNs2": 0,
        "hlcXMNs4": 0,
        "hlcXMNc4": 0,
        "hlcXMNc5": 0,
        "hlcYTIs2": 0,
        "hlcYTIs4": 0,
        "hlcYTIc4": 0,
        "hlcYTIc5": 0
    ]
    
    @IBOutlet var hlcHKGs2: NSTextField!
    @IBOutlet var hlcHKGs4: NSTextField!
    @IBOutlet var hlcHKGc4: NSTextField!
    @IBOutlet var hlcHKGc5: NSTextField!
    
    @IBOutlet var hlcXMNs2: NSTextField!
    @IBOutlet var hlcXMNs4: NSTextField!
    @IBOutlet var hlcXMNc4: NSTextField!
    @IBOutlet var hlcXMNc5: NSTextField!
    
    @IBOutlet var hlcYTIs2: NSTextField!
    @IBOutlet var hlcYTIs4: NSTextField!
    @IBOutlet var hlcYTIc4: NSTextField!
    @IBOutlet var hlcYTIc5: NSTextField!
    
    
    
    var ymlAllocations = [
        "ymlHKGs2": 0,
        "ymlHKGs4": 0,
        "ymlHKGc4": 0,
        "ymlHKGc5": 0,
        "ymlXMNs2": 0,
        "ymlXMNs4": 0,
        "ymlXMNc4": 0,
        "ymlXMNc5": 0,
        "ymlYTIs2": 0,
        "ymlYTIs4": 0,
        "ymlYTIc4": 0,
        "ymlYTIc5": 0
    ]
    
    @IBOutlet var ymlHKGs2: NSTextField!
    @IBOutlet var ymlHKGs4: NSTextField!
    @IBOutlet var ymlHKGc4: NSTextField!
    @IBOutlet var ymlHKGc5: NSTextField!
    
    @IBOutlet var ymlXMNs2: NSTextField!
    @IBOutlet var ymlXMNs4: NSTextField!
    @IBOutlet var ymlXMNc4: NSTextField!
    @IBOutlet var ymlXMNc5: NSTextField!
    
    @IBOutlet var ymlYTIs2: NSTextField!
    @IBOutlet var ymlYTIs4: NSTextField!
    @IBOutlet var ymlYTIc4: NSTextField!
    @IBOutlet var ymlYTIc5: NSTextField!
    
    weak var delegate: PS7AllocationViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func setAllocations(_ sender: Any) {
        
        oneAllocations.updateValue((Int(oneHKGs2.stringValue)) ?? 0, forKey: "oneHKGs2")
        oneAllocations.updateValue((Int(oneHKGs4.stringValue)) ?? 0, forKey: "oneHKGs4")
        oneAllocations.updateValue((Int(oneHKGc4.stringValue)) ?? 0, forKey: "oneHKGc4")
        oneAllocations.updateValue((Int(oneHKGc5.stringValue)) ?? 0, forKey: "oneHKGc5")
        
        oneAllocations.updateValue((Int(oneXMNs2.stringValue)) ?? 0, forKey: "oneXMNs2")
        oneAllocations.updateValue((Int(oneXMNs4.stringValue)) ?? 0, forKey: "oneXMNs4")
        oneAllocations.updateValue((Int(oneXMNc4.stringValue)) ?? 0, forKey: "oneXMNc4")
        oneAllocations.updateValue((Int(oneXMNc5.stringValue)) ?? 0, forKey: "oneXMNc5")
        
        oneAllocations.updateValue((Int(oneYTIs2.stringValue)) ?? 0, forKey: "oneYTIs2")
        oneAllocations.updateValue((Int(oneYTIs4.stringValue)) ?? 0, forKey: "oneYTIs4")
        oneAllocations.updateValue((Int(oneYTIc4.stringValue)) ?? 0, forKey: "oneYTIc4")
        oneAllocations.updateValue((Int(oneYTIc5.stringValue)) ?? 0, forKey: "oneYTIc5")
        
        hlcAllocations.updateValue((Int(hlcHKGs2.stringValue)) ?? 0, forKey: "hlcHKGs2")
        hlcAllocations.updateValue((Int(hlcHKGs4.stringValue)) ?? 0, forKey: "hlcHKGs4")
        hlcAllocations.updateValue((Int(hlcHKGc4.stringValue)) ?? 0, forKey: "hlcHKGc4")
        hlcAllocations.updateValue((Int(hlcHKGc5.stringValue)) ?? 0, forKey: "hlcHKGc5")
        
        hlcAllocations.updateValue((Int(hlcXMNs2.stringValue)) ?? 0, forKey: "hlcXMNs2")
        hlcAllocations.updateValue((Int(hlcXMNs4.stringValue)) ?? 0, forKey: "hlcXMNs4")
        hlcAllocations.updateValue((Int(hlcXMNc4.stringValue)) ?? 0, forKey: "hlcXMNc4")
        hlcAllocations.updateValue((Int(hlcXMNc5.stringValue)) ?? 0, forKey: "hlcXMNc5")
        
        hlcAllocations.updateValue((Int(hlcYTIs2.stringValue)) ?? 0, forKey: "hlcYTIs2")
        hlcAllocations.updateValue((Int(hlcYTIs4.stringValue)) ?? 0, forKey: "hlcYTIs4")
        hlcAllocations.updateValue((Int(hlcYTIc4.stringValue)) ?? 0, forKey: "hlcYTIc4")
        hlcAllocations.updateValue((Int(hlcYTIc5.stringValue)) ?? 0, forKey: "hlcYTIc5")
        
        ymlAllocations.updateValue((Int(ymlHKGs2.stringValue)) ?? 0, forKey: "ymlHKGs2")
        ymlAllocations.updateValue((Int(ymlHKGs4.stringValue)) ?? 0, forKey: "ymlHKGs4")
        ymlAllocations.updateValue((Int(ymlHKGc4.stringValue)) ?? 0, forKey: "ymlHKGc4")
        ymlAllocations.updateValue((Int(ymlHKGc5.stringValue)) ?? 0, forKey: "ymlHKGc5")
        
        ymlAllocations.updateValue((Int(ymlXMNs2.stringValue)) ?? 0, forKey: "ymlXMNs2")
        ymlAllocations.updateValue((Int(ymlXMNs4.stringValue)) ?? 0, forKey: "ymlXMNs4")
        ymlAllocations.updateValue((Int(ymlXMNc4.stringValue)) ?? 0, forKey: "ymlXMNc4")
        ymlAllocations.updateValue((Int(ymlXMNc5.stringValue)) ?? 0, forKey: "ymlXMNc5")
        
        ymlAllocations.updateValue((Int(ymlYTIs2.stringValue)) ?? 0, forKey: "ymlYTIs2")
        ymlAllocations.updateValue((Int(ymlYTIs4.stringValue)) ?? 0, forKey: "ymlYTIs4")
        ymlAllocations.updateValue((Int(ymlYTIc4.stringValue)) ?? 0, forKey: "ymlYTIc4")
        ymlAllocations.updateValue((Int(ymlYTIc5.stringValue)) ?? 0, forKey: "ymlYTIc5")
        
        let allocations = ["ONE": oneAllocations, "HLC": hlcAllocations, "YML": ymlAllocations]
        
        delegate?.passAllocations(allocations: allocations)
        
        let nc = NotificationCenter.default
        nc.post(name: NSNotification.Name("AllocationsChanged"), object: nil)
        
        self.dismissViewController(self)
        
        
    }
    
}
