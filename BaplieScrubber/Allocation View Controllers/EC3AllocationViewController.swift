//
//  EC3AllocationViewController.swift
//  BaplieScrubber
//
//  Created by Joshua Kraft on 12/21/18.
//  Copyright © 2018 Joshua Kraft. All rights reserved.
//

import Cocoa

protocol EC3AllocationViewControllerDelegate: class {
    func passAllocations(allocations: [String: [String : Int]])
}

class EC3AllocationViewController: NSViewController {

    var oneAllocations = [
        "oneBLBs2": 0,
        "oneBLBs4": 0,
        "oneBLBc4": 0,
        "oneBLBc5": 0,
        "oneBUSs2": 0,
        "oneBUSs4": 0,
        "oneBUSc4": 0,
        "oneBUSc5": 0,
        "oneHKGs2": 0,
        "oneHKGs4": 0,
        "oneHKGc4": 0,
        "oneHKGc5": 0,
        "oneKAOs2": 0,
        "oneKAOs4": 0,
        "oneKAOc4": 0,
        "oneKAOc5": 0,
        "oneMZXs2": 0,
        "oneMZXs4": 0,
        "oneMZXc4": 0,
        "oneMZXc5": 0,
        "oneSHGs2": 0,
        "oneSHGs4": 0,
        "oneSHGc4": 0,
        "oneSHGc5": 0,
        "oneXMNs2": 0,
        "oneXMNs4": 0,
        "oneXMNc4": 0,
        "oneXMNc5": 0,
        "oneYTIs2": 0,
        "oneYTIs4": 0,
        "oneYTIc4": 0,
        "oneYTIc5": 0,
        ]
    
    @IBOutlet var oneBLBs2: NSTextField!
    @IBOutlet var oneBLBs4: NSTextField!
    @IBOutlet var oneBLBc4: NSTextField!
    @IBOutlet var oneBLBc5: NSTextField!
    
    @IBOutlet var oneBUSs2: NSTextField!
    @IBOutlet var oneBUSs4: NSTextField!
    @IBOutlet var oneBUSc4: NSTextField!
    @IBOutlet var oneBUSc5: NSTextField!
    
    @IBOutlet var oneHKGs2: NSTextField!
    @IBOutlet var oneHKGs4: NSTextField!
    @IBOutlet var oneHKGc4: NSTextField!
    @IBOutlet var oneHKGc5: NSTextField!
    
    @IBOutlet var oneKAOs2: NSTextField!
    @IBOutlet var oneKAOs4: NSTextField!
    @IBOutlet var oneKAOc4: NSTextField!
    @IBOutlet var oneKAOc5: NSTextField!
    
    @IBOutlet var oneMZXs2: NSTextField!
    @IBOutlet var oneMZXs4: NSTextField!
    @IBOutlet var oneMZXc4: NSTextField!
    @IBOutlet var oneMZXc5: NSTextField!
    
    @IBOutlet var oneSHGs2: NSTextField!
    @IBOutlet var oneSHGs4: NSTextField!
    @IBOutlet var oneSHGc4: NSTextField!
    @IBOutlet var oneSHGc5: NSTextField!
    
    @IBOutlet var oneXMNs2: NSTextField!
    @IBOutlet var oneXMNs4: NSTextField!
    @IBOutlet var oneXMNc4: NSTextField!
    @IBOutlet var oneXMNc5: NSTextField!
    
    @IBOutlet var oneYTIs2: NSTextField!
    @IBOutlet var oneYTIs4: NSTextField!
    @IBOutlet var oneYTIc4: NSTextField!
    @IBOutlet var oneYTIc5: NSTextField!
    
    

    var hlcAllocations = [
        "hlcBLBs2": 0,
        "hlcBLBs4": 0,
        "hlcBLBc4": 0,
        "hlcBLBc5": 0,
        "hlcBUSs2": 0,
        "hlcBUSs4": 0,
        "hlcBUSc4": 0,
        "hlcBUSc5": 0,
        "hlcHKGs2": 0,
        "hlcHKGs4": 0,
        "hlcHKGc4": 0,
        "hlcHKGc5": 0,
        "hlcKAOs2": 0,
        "hlcKAOs4": 0,
        "hlcKAOc4": 0,
        "hlcKAOc5": 0,
        "hlcMZXs2": 0,
        "hlcMZXs4": 0,
        "hlcMZXc4": 0,
        "hlcMZXc5": 0,
        "hlcSHGs2": 0,
        "hlcSHGs4": 0,
        "hlcSHGc4": 0,
        "hlcSHGc5": 0,
        "hlcXMNs2": 0,
        "hlcXMNs4": 0,
        "hlcXMNc4": 0,
        "hlcXMNc5": 0,
        "hlcYTIs2": 0,
        "hlcYTIs4": 0,
        "hlcYTIc4": 0,
        "hlcYTIc5": 0,
        ]
    
    @IBOutlet var hlcBLBs2: NSTextField!
    @IBOutlet var hlcBLBs4: NSTextField!
    @IBOutlet var hlcBLBc4: NSTextField!
    @IBOutlet var hlcBLBc5: NSTextField!
    
    @IBOutlet var hlcBUSs2: NSTextField!
    @IBOutlet var hlcBUSs4: NSTextField!
    @IBOutlet var hlcBUSc4: NSTextField!
    @IBOutlet var hlcBUSc5: NSTextField!
    
    @IBOutlet var hlcHKGs2: NSTextField!
    @IBOutlet var hlcHKGs4: NSTextField!
    @IBOutlet var hlcHKGc4: NSTextField!
    @IBOutlet var hlcHKGc5: NSTextField!
    
    @IBOutlet var hlcKAOs2: NSTextField!
    @IBOutlet var hlcKAOs4: NSTextField!
    @IBOutlet var hlcKAOc4: NSTextField!
    @IBOutlet var hlcKAOc5: NSTextField!
    
    @IBOutlet var hlcMZXs2: NSTextField!
    @IBOutlet var hlcMZXs4: NSTextField!
    @IBOutlet var hlcMZXc4: NSTextField!
    @IBOutlet var hlcMZXc5: NSTextField!
    
    @IBOutlet var hlcSHGs2: NSTextField!
    @IBOutlet var hlcSHGs4: NSTextField!
    @IBOutlet var hlcSHGc4: NSTextField!
    @IBOutlet var hlcSHGc5: NSTextField!
    
    @IBOutlet var hlcXMNs2: NSTextField!
    @IBOutlet var hlcXMNs4: NSTextField!
    @IBOutlet var hlcXMNc4: NSTextField!
    @IBOutlet var hlcXMNc5: NSTextField!
    
    @IBOutlet var hlcYTIs2: NSTextField!
    @IBOutlet var hlcYTIs4: NSTextField!
    @IBOutlet var hlcYTIc4: NSTextField!
    @IBOutlet var hlcYTIc5: NSTextField!
    
    

    var ymlAllocations = [
        "ymlBLBs2": 0,
        "ymlBLBs4": 0,
        "ymlBLBc4": 0,
        "ymlBLBc5": 0,
        "ymlBUSs2": 0,
        "ymlBUSs4": 0,
        "ymlBUSc4": 0,
        "ymlBUSc5": 0,
        "ymlHKGs2": 0,
        "ymlHKGs4": 0,
        "ymlHKGc4": 0,
        "ymlHKGc5": 0,
        "ymlKAOs2": 0,
        "ymlKAOs4": 0,
        "ymlKAOc4": 0,
        "ymlKAOc5": 0,
        "ymlMZXs2": 0,
        "ymlMZXs4": 0,
        "ymlMZXc4": 0,
        "ymlMZXc5": 0,
        "ymlSHGs2": 0,
        "ymlSHGs4": 0,
        "ymlSHGc4": 0,
        "ymlSHGc5": 0,
        "ymlXMNs2": 0,
        "ymlXMNs4": 0,
        "ymlXMNc4": 0,
        "ymlXMNc5": 0,
        "ymlYTIs2": 0,
        "ymlYTIs4": 0,
        "ymlYTIc4": 0,
        "ymlYTIc5": 0,
        ]
    
    @IBOutlet var ymlBLBs2: NSTextField!
    @IBOutlet var ymlBLBs4: NSTextField!
    @IBOutlet var ymlBLBc4: NSTextField!
    @IBOutlet var ymlBLBc5: NSTextField!
    
    @IBOutlet var ymlBUSs2: NSTextField!
    @IBOutlet var ymlBUSs4: NSTextField!
    @IBOutlet var ymlBUSc4: NSTextField!
    @IBOutlet var ymlBUSc5: NSTextField!
    
    @IBOutlet var ymlHKGs2: NSTextField!
    @IBOutlet var ymlHKGs4: NSTextField!
    @IBOutlet var ymlHKGc4: NSTextField!
    @IBOutlet var ymlHKGc5: NSTextField!
    
    @IBOutlet var ymlKAOs2: NSTextField!
    @IBOutlet var ymlKAOs4: NSTextField!
    @IBOutlet var ymlKAOc4: NSTextField!
    @IBOutlet var ymlKAOc5: NSTextField!
    
    @IBOutlet var ymlMZXs2: NSTextField!
    @IBOutlet var ymlMZXs4: NSTextField!
    @IBOutlet var ymlMZXc4: NSTextField!
    @IBOutlet var ymlMZXc5: NSTextField!
    
    @IBOutlet var ymlSHGs2: NSTextField!
    @IBOutlet var ymlSHGs4: NSTextField!
    @IBOutlet var ymlSHGc4: NSTextField!
    @IBOutlet var ymlSHGc5: NSTextField!
    
    @IBOutlet var ymlXMNs2: NSTextField!
    @IBOutlet var ymlXMNs4: NSTextField!
    @IBOutlet var ymlXMNc4: NSTextField!
    @IBOutlet var ymlXMNc5: NSTextField!
    
    @IBOutlet var ymlYTIs2: NSTextField!
    @IBOutlet var ymlYTIs4: NSTextField!
    @IBOutlet var ymlYTIc4: NSTextField!
    @IBOutlet var ymlYTIc5: NSTextField!
    
    weak var delegate: EC3AllocationViewControllerDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func setAllocations(_ sender: Any) {
        
        oneAllocations.updateValue((Int(oneBLBs2.stringValue)) ?? 0, forKey: "oneBLBs2")
        oneAllocations.updateValue((Int(oneBLBs4.stringValue)) ?? 0, forKey: "oneBLBs4")
        oneAllocations.updateValue((Int(oneBLBc4.stringValue)) ?? 0, forKey: "oneBLBc4")
        oneAllocations.updateValue((Int(oneBLBc5.stringValue)) ?? 0, forKey: "oneBLBc5")
        
        oneAllocations.updateValue((Int(oneBUSs2.stringValue)) ?? 0, forKey: "oneBUSs2")
        oneAllocations.updateValue((Int(oneBUSs4.stringValue)) ?? 0, forKey: "oneBUSs4")
        oneAllocations.updateValue((Int(oneBUSc4.stringValue)) ?? 0, forKey: "oneBUSc4")
        oneAllocations.updateValue((Int(oneBUSc5.stringValue)) ?? 0, forKey: "oneBUSc5")
        
        oneAllocations.updateValue((Int(oneHKGs2.stringValue)) ?? 0, forKey: "oneHKGs2")
        oneAllocations.updateValue((Int(oneHKGs4.stringValue)) ?? 0, forKey: "oneHKGs4")
        oneAllocations.updateValue((Int(oneHKGc4.stringValue)) ?? 0, forKey: "oneHKGc4")
        oneAllocations.updateValue((Int(oneHKGc5.stringValue)) ?? 0, forKey: "oneHKGc5")
        
        oneAllocations.updateValue((Int(oneKAOs2.stringValue)) ?? 0, forKey: "oneKAOs2")
        oneAllocations.updateValue((Int(oneKAOs4.stringValue)) ?? 0, forKey: "oneKAOs4")
        oneAllocations.updateValue((Int(oneKAOc4.stringValue)) ?? 0, forKey: "oneKAOc4")
        oneAllocations.updateValue((Int(oneKAOc5.stringValue)) ?? 0, forKey: "oneKAOc5")
        
        oneAllocations.updateValue((Int(oneMZXs2.stringValue)) ?? 0, forKey: "oneMZXs2")
        oneAllocations.updateValue((Int(oneMZXs4.stringValue)) ?? 0, forKey: "oneMZXs4")
        oneAllocations.updateValue((Int(oneMZXc4.stringValue)) ?? 0, forKey: "oneMZXc4")
        oneAllocations.updateValue((Int(oneMZXc5.stringValue)) ?? 0, forKey: "oneMZXc5")
        
        oneAllocations.updateValue((Int(oneSHGs2.stringValue)) ?? 0, forKey: "oneSHGs2")
        oneAllocations.updateValue((Int(oneSHGs4.stringValue)) ?? 0, forKey: "oneSHGs4")
        oneAllocations.updateValue((Int(oneSHGc4.stringValue)) ?? 0, forKey: "oneSHGc4")
        oneAllocations.updateValue((Int(oneSHGc5.stringValue)) ?? 0, forKey: "oneSHGc5")
        
        oneAllocations.updateValue((Int(oneXMNs2.stringValue)) ?? 0, forKey: "oneXMNs2")
        oneAllocations.updateValue((Int(oneXMNs4.stringValue)) ?? 0, forKey: "oneXMNs4")
        oneAllocations.updateValue((Int(oneXMNc4.stringValue)) ?? 0, forKey: "oneXMNc4")
        oneAllocations.updateValue((Int(oneXMNc5.stringValue)) ?? 0, forKey: "oneXMNc5")
        
        oneAllocations.updateValue((Int(oneYTIs2.stringValue)) ?? 0, forKey: "oneYTIs2")
        oneAllocations.updateValue((Int(oneYTIs4.stringValue)) ?? 0, forKey: "oneYTIs4")
        oneAllocations.updateValue((Int(oneYTIc4.stringValue)) ?? 0, forKey: "oneYTIc4")
        oneAllocations.updateValue((Int(oneYTIc5.stringValue)) ?? 0, forKey: "oneYTIc5")
        
        
        
        hlcAllocations.updateValue((Int(hlcBLBs2.stringValue)) ?? 0, forKey: "hlcBLBs2")
        hlcAllocations.updateValue((Int(hlcBLBs4.stringValue)) ?? 0, forKey: "hlcBLBs4")
        hlcAllocations.updateValue((Int(hlcBLBc4.stringValue)) ?? 0, forKey: "hlcBLBc4")
        hlcAllocations.updateValue((Int(hlcBLBc5.stringValue)) ?? 0, forKey: "hlcBLBc5")
        
        hlcAllocations.updateValue((Int(hlcBUSs2.stringValue)) ?? 0, forKey: "hlcBUSs2")
        hlcAllocations.updateValue((Int(hlcBUSs4.stringValue)) ?? 0, forKey: "hlcBUSs4")
        hlcAllocations.updateValue((Int(hlcBUSc4.stringValue)) ?? 0, forKey: "hlcBUSc4")
        hlcAllocations.updateValue((Int(hlcBUSc5.stringValue)) ?? 0, forKey: "hlcBUSc5")
        
        hlcAllocations.updateValue((Int(hlcHKGs2.stringValue)) ?? 0, forKey: "hlcHKGs2")
        hlcAllocations.updateValue((Int(hlcHKGs4.stringValue)) ?? 0, forKey: "hlcHKGs4")
        hlcAllocations.updateValue((Int(hlcHKGc4.stringValue)) ?? 0, forKey: "hlcHKGc4")
        hlcAllocations.updateValue((Int(hlcHKGc5.stringValue)) ?? 0, forKey: "hlcHKGc5")
        
        hlcAllocations.updateValue((Int(hlcKAOs2.stringValue)) ?? 0, forKey: "hlcKAOs2")
        hlcAllocations.updateValue((Int(hlcKAOs4.stringValue)) ?? 0, forKey: "hlcKAOs4")
        hlcAllocations.updateValue((Int(hlcKAOc4.stringValue)) ?? 0, forKey: "hlcKAOc4")
        hlcAllocations.updateValue((Int(hlcKAOc5.stringValue)) ?? 0, forKey: "hlcKAOc5")
        
        hlcAllocations.updateValue((Int(hlcMZXs2.stringValue)) ?? 0, forKey: "hlcMZXs2")
        hlcAllocations.updateValue((Int(hlcMZXs4.stringValue)) ?? 0, forKey: "hlcMZXs4")
        hlcAllocations.updateValue((Int(hlcMZXc4.stringValue)) ?? 0, forKey: "hlcMZXc4")
        hlcAllocations.updateValue((Int(hlcMZXc5.stringValue)) ?? 0, forKey: "hlcMZXc5")
        
        hlcAllocations.updateValue((Int(hlcSHGs2.stringValue)) ?? 0, forKey: "hlcSHGs2")
        hlcAllocations.updateValue((Int(hlcSHGs4.stringValue)) ?? 0, forKey: "hlcSHGs4")
        hlcAllocations.updateValue((Int(hlcSHGc4.stringValue)) ?? 0, forKey: "hlcSHGc4")
        hlcAllocations.updateValue((Int(hlcSHGc5.stringValue)) ?? 0, forKey: "hlcSHGc5")
        
        hlcAllocations.updateValue((Int(hlcXMNs2.stringValue)) ?? 0, forKey: "hlcXMNs2")
        hlcAllocations.updateValue((Int(hlcXMNs4.stringValue)) ?? 0, forKey: "hlcXMNs4")
        hlcAllocations.updateValue((Int(hlcXMNc4.stringValue)) ?? 0, forKey: "hlcXMNc4")
        hlcAllocations.updateValue((Int(hlcXMNc5.stringValue)) ?? 0, forKey: "hlcXMNc5")
        
        hlcAllocations.updateValue((Int(hlcYTIs2.stringValue)) ?? 0, forKey: "hlcYTIs2")
        hlcAllocations.updateValue((Int(hlcYTIs4.stringValue)) ?? 0, forKey: "hlcYTIs4")
        hlcAllocations.updateValue((Int(hlcYTIc4.stringValue)) ?? 0, forKey: "hlcYTIc4")
        hlcAllocations.updateValue((Int(hlcYTIc5.stringValue)) ?? 0, forKey: "hlcYTIc5")
        
        
        
        
        ymlAllocations.updateValue((Int(ymlBLBs2.stringValue)) ?? 0, forKey: "ymlBLBs2")
        ymlAllocations.updateValue((Int(ymlBLBs4.stringValue)) ?? 0, forKey: "ymlBLBs4")
        ymlAllocations.updateValue((Int(ymlBLBc4.stringValue)) ?? 0, forKey: "ymlBLBc4")
        ymlAllocations.updateValue((Int(ymlBLBc5.stringValue)) ?? 0, forKey: "ymlBLBc5")
        
        ymlAllocations.updateValue((Int(ymlBUSs2.stringValue)) ?? 0, forKey: "ymlBUSs2")
        ymlAllocations.updateValue((Int(ymlBUSs4.stringValue)) ?? 0, forKey: "ymlBUSs4")
        ymlAllocations.updateValue((Int(ymlBUSc4.stringValue)) ?? 0, forKey: "ymlBUSc4")
        ymlAllocations.updateValue((Int(ymlBUSc5.stringValue)) ?? 0, forKey: "ymlBUSc5")
        
        ymlAllocations.updateValue((Int(ymlHKGs2.stringValue)) ?? 0, forKey: "ymlHKGs2")
        ymlAllocations.updateValue((Int(ymlHKGs4.stringValue)) ?? 0, forKey: "ymlHKGs4")
        ymlAllocations.updateValue((Int(ymlHKGc4.stringValue)) ?? 0, forKey: "ymlHKGc4")
        ymlAllocations.updateValue((Int(ymlHKGc5.stringValue)) ?? 0, forKey: "ymlHKGc5")
        
        ymlAllocations.updateValue((Int(ymlKAOs2.stringValue)) ?? 0, forKey: "ymlKAOs2")
        ymlAllocations.updateValue((Int(ymlKAOs4.stringValue)) ?? 0, forKey: "ymlKAOs4")
        ymlAllocations.updateValue((Int(ymlKAOc4.stringValue)) ?? 0, forKey: "ymlKAOc4")
        ymlAllocations.updateValue((Int(ymlKAOc5.stringValue)) ?? 0, forKey: "ymlKAOc5")
        
        ymlAllocations.updateValue((Int(ymlMZXs2.stringValue)) ?? 0, forKey: "ymlMZXs2")
        ymlAllocations.updateValue((Int(ymlMZXs4.stringValue)) ?? 0, forKey: "ymlMZXs4")
        ymlAllocations.updateValue((Int(ymlMZXc4.stringValue)) ?? 0, forKey: "ymlMZXc4")
        ymlAllocations.updateValue((Int(ymlMZXc5.stringValue)) ?? 0, forKey: "ymlMZXc5")
        
        ymlAllocations.updateValue((Int(ymlSHGs2.stringValue)) ?? 0, forKey: "ymlSHGs2")
        ymlAllocations.updateValue((Int(ymlSHGs4.stringValue)) ?? 0, forKey: "ymlSHGs4")
        ymlAllocations.updateValue((Int(ymlSHGc4.stringValue)) ?? 0, forKey: "ymlSHGc4")
        ymlAllocations.updateValue((Int(ymlSHGc5.stringValue)) ?? 0, forKey: "ymlSHGc5")
        
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
