//
//  EC1AllocationViewController.swift
//  BaplieScrubber
//
//  Created by Joshua Kraft on 12/9/18.
//  Copyright © 2018 Joshua Kraft. All rights reserved.
//

import Cocoa

protocol EC1AllocationViewControllerDelegate: class {
    func passAllocations(allocations: [String: [String : Int]])
}

class EC1AllocationViewController: NSViewController {

    var oneAllocations = [
        "oneBUSs2": 0,
        "oneBUSs4": 0,
        "oneBUSc4": 0,
        "oneBUSc5": 0,
        "oneKBEs2": 0,
        "oneKBEs4": 0,
        "oneKBEc4": 0,
        "oneKBEc5": 0,
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
    
    @IBOutlet var oneKBEs2: NSTextField!
    @IBOutlet var oneKBEs4: NSTextField!
    @IBOutlet var oneKBEc4: NSTextField!
    @IBOutlet var oneKBEc5: NSTextField!
    
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
        "hlcKBEs2": 0,
        "hlcKBEs4": 0,
        "hlcKBEc4": 0,
        "hlcKBEc5": 0,
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
    
    @IBOutlet var hlcKBEs2: NSTextField!
    @IBOutlet var hlcKBEs4: NSTextField!
    @IBOutlet var hlcKBEc4: NSTextField!
    @IBOutlet var hlcKBEc5: NSTextField!
    
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
        "ymlKBEs2": 0,
        "ymlKBEs4": 0,
        "ymlKBEc4": 0,
        "ymlKBEc5": 0,
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
    
    @IBOutlet var ymlKBEs2: NSTextField!
    @IBOutlet var ymlKBEs4: NSTextField!
    @IBOutlet var ymlKBEc4: NSTextField!
    @IBOutlet var ymlKBEc5: NSTextField!
    
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

    weak var delegate: EC1AllocationViewControllerDelegate?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func setAllocations(_ sender: Any) {
        
        oneAllocations.updateValue((Int(oneBUSs2.stringValue)) ?? 0, forKey: "oneBUSs2")
        oneAllocations.updateValue((Int(oneBUSs4.stringValue)) ?? 0, forKey: "oneBUSs4")
        oneAllocations.updateValue((Int(oneBUSc4.stringValue)) ?? 0, forKey: "oneBUSc4")
        oneAllocations.updateValue((Int(oneBUSc5.stringValue)) ?? 0, forKey: "oneBUSc5")
        
        oneAllocations.updateValue((Int(oneKBEs2.stringValue)) ?? 0, forKey: "oneKBEs2")
        oneAllocations.updateValue((Int(oneKBEs4.stringValue)) ?? 0, forKey: "oneKBEs4")
        oneAllocations.updateValue((Int(oneKBEc4.stringValue)) ?? 0, forKey: "oneKBEc4")
        oneAllocations.updateValue((Int(oneKBEc5.stringValue)) ?? 0, forKey: "oneKBEc5")
        
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
        
        hlcAllocations.updateValue((Int(hlcKBEs2.stringValue)) ?? 0, forKey: "hlcKBEs2")
        hlcAllocations.updateValue((Int(hlcKBEs4.stringValue)) ?? 0, forKey: "hlcKBEs4")
        hlcAllocations.updateValue((Int(hlcKBEc4.stringValue)) ?? 0, forKey: "hlcKBEc4")
        hlcAllocations.updateValue((Int(hlcKBEc5.stringValue)) ?? 0, forKey: "hlcKBEc5")
        
        hlcAllocations.updateValue((Int(hlcNGBs2.stringValue)) ?? 0, forKey: "hlcNGBs2")
        hlcAllocations.updateValue((Int(hlcNGBs4.stringValue)) ?? 0, forKey: "hlcNGBs4")
        hlcAllocations.updateValue((Int(hlcNGBc4.stringValue)) ?? 0, forKey: "hlcNGBc4")
        hlcAllocations.updateValue((Int(hlcNGBc5.stringValue)) ?? 0, forKey: "hlcNGBc5")
        
        hlcAllocations.updateValue((Int(hlcSHGs2.stringValue)) ?? 0, forKey: "hlcSHGs2")
        hlcAllocations.updateValue((Int(hlcSHGs4.stringValue)) ?? 0, forKey: "hlcSHGs4")
        hlcAllocations.updateValue((Int(hlcSHGc4.stringValue)) ?? 0, forKey: "hlcSHGc4")
        hlcAllocations.updateValue((Int(hlcSHGc5.stringValue)) ?? 0, forKey: "hlcSHGc5")
        
        hlcAllocations.updateValue((Int(hlcBUSs2.stringValue)) ?? 0, forKey: "hlcTKYs2")
        hlcAllocations.updateValue((Int(hlcTKYs4.stringValue)) ?? 0, forKey: "hlcTKYs4")
        hlcAllocations.updateValue((Int(hlcTKYc4.stringValue)) ?? 0, forKey: "hlcTKYc4")
        hlcAllocations.updateValue((Int(hlcTKYc5.stringValue)) ?? 0, forKey: "hlcTKYc5")

        ymlAllocations.updateValue((Int(ymlBUSs2.stringValue)) ?? 0, forKey: "ymlBUSs2")
        ymlAllocations.updateValue((Int(ymlBUSs4.stringValue)) ?? 0, forKey: "ymlBUSs4")
        ymlAllocations.updateValue((Int(ymlBUSc4.stringValue)) ?? 0, forKey: "ymlBUSc4")
        ymlAllocations.updateValue((Int(ymlBUSc5.stringValue)) ?? 0, forKey: "ymlBUSc5")
        
        ymlAllocations.updateValue((Int(ymlKBEs2.stringValue)) ?? 0, forKey: "ymlKBEs2")
        ymlAllocations.updateValue((Int(ymlKBEs4.stringValue)) ?? 0, forKey: "ymlKBEs4")
        ymlAllocations.updateValue((Int(ymlKBEc4.stringValue)) ?? 0, forKey: "ymlKBEc4")
        ymlAllocations.updateValue((Int(ymlKBEc5.stringValue)) ?? 0, forKey: "ymlKBEc5")
        
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
        
        let nc = NotificationCenter.default
        nc.post(name: NSNotification.Name("AllocationsChanged"), object: nil)
        
        self.dismissViewController(self)
        
        
    }

    
}
