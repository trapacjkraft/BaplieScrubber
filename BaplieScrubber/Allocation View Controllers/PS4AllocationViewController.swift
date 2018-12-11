//
//  PS4AllocationViewController.swift
//  BaplieScrubber
//
//  Created by Joshua Kraft on 12/10/18.
//  Copyright © 2018 Joshua Kraft. All rights reserved.
//

import Cocoa

protocol PS4AllocationViewControllerDelegate: class {
    func passAllocations(allocations: [String: [String : Int]])
}

class PS4AllocationViewController: NSViewController {
    
    var oneAllocations = [
        "oneHKGs2": 0,
        "oneHKGs4": 0,
        "oneHKGc4": 0,
        "oneHKGc5": 0,
        "oneKAOs2": 0,
        "oneKAOs4": 0,
        "oneKAOc4": 0,
        "oneKAOc5": 0,
        "oneKEEs2": 0,
        "oneKEEs4": 0,
        "oneKEEc4": 0,
        "oneKEEc5": 0,
        "oneYTIs2": 0,
        "oneYTIs4": 0,
        "oneYTIc4": 0,
        "oneYTIc5": 0,
        ]

    @IBOutlet var oneHKGs2: NSTextField!
    @IBOutlet var oneHKGs4: NSTextField!
    @IBOutlet var oneHKGc4: NSTextField!
    @IBOutlet var oneHKGc5: NSTextField!
    
    @IBOutlet var oneKAOs2: NSTextField!
    @IBOutlet var oneKAOs4: NSTextField!
    @IBOutlet var oneKAOc4: NSTextField!
    @IBOutlet var oneKAOc5: NSTextField!
    
    @IBOutlet var oneKEEs2: NSTextField!
    @IBOutlet var oneKEEs4: NSTextField!
    @IBOutlet var oneKEEc4: NSTextField!
    @IBOutlet var oneKEEc5: NSTextField!
    
    @IBOutlet var oneYTIs2: NSTextField!
    @IBOutlet var oneYTIs4: NSTextField!
    @IBOutlet var oneYTIc4: NSTextField!
    @IBOutlet var oneYTIc5: NSTextField!

    var hlcAllocations = [
        "hlcHKGs2": 0,
        "hlcHKGs4": 0,
        "hlcHKGc4": 0,
        "hlcHKGc5": 0,
        "hlcKAOs2": 0,
        "hlcKAOs4": 0,
        "hlcKAOc4": 0,
        "hlcKAOc5": 0,
        "hlcKEEs2": 0,
        "hlcKEEs4": 0,
        "hlcKEEc4": 0,
        "hlcKEEc5": 0,
        "hlcYTIs2": 0,
        "hlcYTIs4": 0,
        "hlcYTIc4": 0,
        "hlcYTIc5": 0,
        ]

    @IBOutlet var hlcHKGs2: NSTextField!
    @IBOutlet var hlcHKGs4: NSTextField!
    @IBOutlet var hlcHKGc4: NSTextField!
    @IBOutlet var hlcHKGc5: NSTextField!
    
    @IBOutlet var hlcKAOs2: NSTextField!
    @IBOutlet var hlcKAOs4: NSTextField!
    @IBOutlet var hlcKAOc4: NSTextField!
    @IBOutlet var hlcKAOc5: NSTextField!
    
    @IBOutlet var hlcKEEs2: NSTextField!
    @IBOutlet var hlcKEEs4: NSTextField!
    @IBOutlet var hlcKEEc4: NSTextField!
    @IBOutlet var hlcKEEc5: NSTextField!
    
    @IBOutlet var hlcYTIs2: NSTextField!
    @IBOutlet var hlcYTIs4: NSTextField!
    @IBOutlet var hlcYTIc4: NSTextField!
    @IBOutlet var hlcYTIc5: NSTextField!

    var ymlAllocations = [
        "ymlHKGs2": 0,
        "ymlHKGs4": 0,
        "ymlHKGc4": 0,
        "ymlHKGc5": 0,
        "ymlKAOs2": 0,
        "ymlKAOs4": 0,
        "ymlKAOc4": 0,
        "ymlKAOc5": 0,
        "ymlKEEs2": 0,
        "ymlKEEs4": 0,
        "ymlKEEc4": 0,
        "ymlKEEc5": 0,
        "ymlYTIs2": 0,
        "ymlYTIs4": 0,
        "ymlYTIc4": 0,
        "ymlYTIc5": 0,
        ]

    @IBOutlet var ymlHKGs2: NSTextField!
    @IBOutlet var ymlHKGs4: NSTextField!
    @IBOutlet var ymlHKGc4: NSTextField!
    @IBOutlet var ymlHKGc5: NSTextField!
    
    @IBOutlet var ymlKAOs2: NSTextField!
    @IBOutlet var ymlKAOs4: NSTextField!
    @IBOutlet var ymlKAOc4: NSTextField!
    @IBOutlet var ymlKAOc5: NSTextField!
    
    @IBOutlet var ymlKEEs2: NSTextField!
    @IBOutlet var ymlKEEs4: NSTextField!
    @IBOutlet var ymlKEEc4: NSTextField!
    @IBOutlet var ymlKEEc5: NSTextField!
    
    @IBOutlet var ymlYTIs2: NSTextField!
    @IBOutlet var ymlYTIs4: NSTextField!
    @IBOutlet var ymlYTIc4: NSTextField!
    @IBOutlet var ymlYTIc5: NSTextField!

    weak var delegate: PS4AllocationViewControllerDelegate?

    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func setAllocations(_ sender: Any) {
        
        oneAllocations.updateValue((Int(oneHKGs2.stringValue)) ?? 0, forKey: "oneHKGs2")
        oneAllocations.updateValue((Int(oneHKGs4.stringValue)) ?? 0, forKey: "oneHKGs4")
        oneAllocations.updateValue((Int(oneHKGc4.stringValue)) ?? 0, forKey: "oneHKGc4")
        oneAllocations.updateValue((Int(oneHKGc5.stringValue)) ?? 0, forKey: "oneHKGc5")
        
        oneAllocations.updateValue((Int(oneKAOs2.stringValue)) ?? 0, forKey: "oneKAOs2")
        oneAllocations.updateValue((Int(oneKAOs4.stringValue)) ?? 0, forKey: "oneKAOs4")
        oneAllocations.updateValue((Int(oneKAOc4.stringValue)) ?? 0, forKey: "oneKAOc4")
        oneAllocations.updateValue((Int(oneKAOc5.stringValue)) ?? 0, forKey: "oneKAOc5")
        
        oneAllocations.updateValue((Int(oneKEEs2.stringValue)) ?? 0, forKey: "oneKEEs2")
        oneAllocations.updateValue((Int(oneKEEs4.stringValue)) ?? 0, forKey: "oneKEEs4")
        oneAllocations.updateValue((Int(oneKEEc4.stringValue)) ?? 0, forKey: "oneKEEc4")
        oneAllocations.updateValue((Int(oneKEEc5.stringValue)) ?? 0, forKey: "oneKEEc5")
        
        oneAllocations.updateValue((Int(oneYTIs2.stringValue)) ?? 0, forKey: "oneYTIs2")
        oneAllocations.updateValue((Int(oneYTIs4.stringValue)) ?? 0, forKey: "oneYTIs4")
        oneAllocations.updateValue((Int(oneYTIc4.stringValue)) ?? 0, forKey: "oneYTIc4")
        oneAllocations.updateValue((Int(oneYTIc5.stringValue)) ?? 0, forKey: "oneYTIc5")

        hlcAllocations.updateValue((Int(hlcHKGs2.stringValue)) ?? 0, forKey: "hlcHKGs2")
        hlcAllocations.updateValue((Int(hlcHKGs4.stringValue)) ?? 0, forKey: "hlcHKGs4")
        hlcAllocations.updateValue((Int(hlcHKGc4.stringValue)) ?? 0, forKey: "hlcHKGc4")
        hlcAllocations.updateValue((Int(hlcHKGc5.stringValue)) ?? 0, forKey: "hlcHKGc5")
        
        hlcAllocations.updateValue((Int(hlcKAOs2.stringValue)) ?? 0, forKey: "hlcKAOs2")
        hlcAllocations.updateValue((Int(hlcKAOs4.stringValue)) ?? 0, forKey: "hlcKAOs4")
        hlcAllocations.updateValue((Int(hlcKAOc4.stringValue)) ?? 0, forKey: "hlcKAOc4")
        hlcAllocations.updateValue((Int(hlcKAOc5.stringValue)) ?? 0, forKey: "hlcKAOc5")
        
        hlcAllocations.updateValue((Int(hlcKEEs2.stringValue)) ?? 0, forKey: "hlcKEEs2")
        hlcAllocations.updateValue((Int(hlcKEEs4.stringValue)) ?? 0, forKey: "hlcKEEs4")
        hlcAllocations.updateValue((Int(hlcKEEc4.stringValue)) ?? 0, forKey: "hlcKEEc4")
        hlcAllocations.updateValue((Int(hlcKEEc5.stringValue)) ?? 0, forKey: "hlcKEEc5")
        
        hlcAllocations.updateValue((Int(hlcYTIs2.stringValue)) ?? 0, forKey: "hlcYTIs2")
        hlcAllocations.updateValue((Int(hlcYTIs4.stringValue)) ?? 0, forKey: "hlcYTIs4")
        hlcAllocations.updateValue((Int(hlcYTIc4.stringValue)) ?? 0, forKey: "hlcYTIc4")
        hlcAllocations.updateValue((Int(hlcYTIc5.stringValue)) ?? 0, forKey: "hlcYTIc5")

        ymlAllocations.updateValue((Int(ymlHKGs2.stringValue)) ?? 0, forKey: "ymlHKGs2")
        ymlAllocations.updateValue((Int(ymlHKGs4.stringValue)) ?? 0, forKey: "ymlHKGs4")
        ymlAllocations.updateValue((Int(ymlHKGc4.stringValue)) ?? 0, forKey: "ymlHKGc4")
        ymlAllocations.updateValue((Int(ymlHKGc5.stringValue)) ?? 0, forKey: "ymlHKGc5")
        
        ymlAllocations.updateValue((Int(ymlKAOs2.stringValue)) ?? 0, forKey: "ymlKAOs2")
        ymlAllocations.updateValue((Int(ymlKAOs4.stringValue)) ?? 0, forKey: "ymlKAOs4")
        ymlAllocations.updateValue((Int(ymlKAOc4.stringValue)) ?? 0, forKey: "ymlKAOc4")
        ymlAllocations.updateValue((Int(ymlKAOc5.stringValue)) ?? 0, forKey: "ymlKAOc5")
        
        ymlAllocations.updateValue((Int(ymlKEEs2.stringValue)) ?? 0, forKey: "ymlKEEs2")
        ymlAllocations.updateValue((Int(ymlKEEs4.stringValue)) ?? 0, forKey: "ymlKEEs4")
        ymlAllocations.updateValue((Int(ymlKEEc4.stringValue)) ?? 0, forKey: "ymlKEEc4")
        ymlAllocations.updateValue((Int(ymlKEEc5.stringValue)) ?? 0, forKey: "ymlKEEc5")
        
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
