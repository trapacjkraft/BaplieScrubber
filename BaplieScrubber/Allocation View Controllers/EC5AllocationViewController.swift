//
//  EC5AllocationViewController.swift
//  BaplieScrubber
//
//  Created by Joshua Kraft on 12/21/18.
//  Copyright © 2018 Joshua Kraft. All rights reserved.
//

import Cocoa

protocol EC5AllocationViewControllerDelegate: class {
    func passAllocations(allocations: [String: [String : Int]])
}

class EC5AllocationViewController: NSViewController {
    
    var oneAllocations = [
        "oneCMBs2": 0,
        "oneCMBs4": 0,
        "oneCMBc4": 0,
        "oneCMBc5": 0,
        "oneHALs2": 0,
        "oneHALs4": 0,
        "oneHALc4": 0,
        "oneHALc5": 0,
        "oneHCMs2": 0,
        "oneHCMs4": 0,
        "oneHCMc4": 0,
        "oneHCMc5": 0,
        "oneJEBs2": 0,
        "oneJEBs4": 0,
        "oneJEBc4": 0,
        "oneJEBc5": 0,
        "oneLLLs2": 0,
        "oneLLLs4": 0,
        "oneLLLc4": 0,
        "oneLLLc5": 0,
        "oneSPRs2": 0,
        "oneSPRs4": 0,
        "oneSPRc4": 0,
        "oneSPRc5": 0,
        ]
    
    @IBOutlet var oneCMBs2: NSTextField!
    @IBOutlet var oneCMBs4: NSTextField!
    @IBOutlet var oneCMBc4: NSTextField!
    @IBOutlet var oneCMBc5: NSTextField!
    
    @IBOutlet var oneHALs2: NSTextField!
    @IBOutlet var oneHALs4: NSTextField!
    @IBOutlet var oneHALc4: NSTextField!
    @IBOutlet var oneHALc5: NSTextField!
    
    @IBOutlet var oneHCMs2: NSTextField!
    @IBOutlet var oneHCMs4: NSTextField!
    @IBOutlet var oneHCMc4: NSTextField!
    @IBOutlet var oneHCMc5: NSTextField!
    
    @IBOutlet var oneJEBs2: NSTextField!
    @IBOutlet var oneJEBs4: NSTextField!
    @IBOutlet var oneJEBc4: NSTextField!
    @IBOutlet var oneJEBc5: NSTextField!
    
    @IBOutlet var oneLLLs2: NSTextField!
    @IBOutlet var oneLLLs4: NSTextField!
    @IBOutlet var oneLLLc4: NSTextField!
    @IBOutlet var oneLLLc5: NSTextField!
    
    @IBOutlet var oneSPRs2: NSTextField!
    @IBOutlet var oneSPRs4: NSTextField!
    @IBOutlet var oneSPRc4: NSTextField!
    @IBOutlet var oneSPRc5: NSTextField!
    
    
    
    var hlcAllocations = [
        "hlcCMBs2": 0,
        "hlcCMBs4": 0,
        "hlcCMBc4": 0,
        "hlcCMBc5": 0,
        "hlcHALs2": 0,
        "hlcHALs4": 0,
        "hlcHALc4": 0,
        "hlcHALc5": 0,
        "hlcHCMs2": 0,
        "hlcHCMs4": 0,
        "hlcHCMc4": 0,
        "hlcHCMc5": 0,
        "hlcJEBs2": 0,
        "hlcJEBs4": 0,
        "hlcJEBc4": 0,
        "hlcJEBc5": 0,
        "hlcLLLs2": 0,
        "hlcLLLs4": 0,
        "hlcLLLc4": 0,
        "hlcLLLc5": 0,
        "hlcSPRs2": 0,
        "hlcSPRs4": 0,
        "hlcSPRc4": 0,
        "hlcSPRc5": 0,
        ]
    
    @IBOutlet var hlcCMBs2: NSTextField!
    @IBOutlet var hlcCMBs4: NSTextField!
    @IBOutlet var hlcCMBc4: NSTextField!
    @IBOutlet var hlcCMBc5: NSTextField!
    
    @IBOutlet var hlcHALs2: NSTextField!
    @IBOutlet var hlcHALs4: NSTextField!
    @IBOutlet var hlcHALc4: NSTextField!
    @IBOutlet var hlcHALc5: NSTextField!
    
    @IBOutlet var hlcHCMs2: NSTextField!
    @IBOutlet var hlcHCMs4: NSTextField!
    @IBOutlet var hlcHCMc4: NSTextField!
    @IBOutlet var hlcHCMc5: NSTextField!
    
    @IBOutlet var hlcJEBs2: NSTextField!
    @IBOutlet var hlcJEBs4: NSTextField!
    @IBOutlet var hlcJEBc4: NSTextField!
    @IBOutlet var hlcJEBc5: NSTextField!
    
    @IBOutlet var hlcLLLs2: NSTextField!
    @IBOutlet var hlcLLLs4: NSTextField!
    @IBOutlet var hlcLLLc4: NSTextField!
    @IBOutlet var hlcLLLc5: NSTextField!
    
    @IBOutlet var hlcSPRs2: NSTextField!
    @IBOutlet var hlcSPRs4: NSTextField!
    @IBOutlet var hlcSPRc4: NSTextField!
    @IBOutlet var hlcSPRc5: NSTextField!
    
    
    
    var ymlAllocations = [
        "ymlCMBs2": 0,
        "ymlCMBs4": 0,
        "ymlCMBc4": 0,
        "ymlCMBc5": 0,
        "ymlHALs2": 0,
        "ymlHALs4": 0,
        "ymlHALc4": 0,
        "ymlHALc5": 0,
        "ymlHCMs2": 0,
        "ymlHCMs4": 0,
        "ymlHCMc4": 0,
        "ymlHCMc5": 0,
        "ymlJEBs2": 0,
        "ymlJEBs4": 0,
        "ymlJEBc4": 0,
        "ymlJEBc5": 0,
        "ymlLLLs2": 0,
        "ymlLLLs4": 0,
        "ymlLLLc4": 0,
        "ymlLLLc5": 0,
        "ymlSPRs2": 0,
        "ymlSPRs4": 0,
        "ymlSPRc4": 0,
        "ymlSPRc5": 0,
        ]
    
    @IBOutlet var ymlCMBs2: NSTextField!
    @IBOutlet var ymlCMBs4: NSTextField!
    @IBOutlet var ymlCMBc4: NSTextField!
    @IBOutlet var ymlCMBc5: NSTextField!
    
    @IBOutlet var ymlHALs2: NSTextField!
    @IBOutlet var ymlHALs4: NSTextField!
    @IBOutlet var ymlHALc4: NSTextField!
    @IBOutlet var ymlHALc5: NSTextField!
    
    @IBOutlet var ymlHCMs2: NSTextField!
    @IBOutlet var ymlHCMs4: NSTextField!
    @IBOutlet var ymlHCMc4: NSTextField!
    @IBOutlet var ymlHCMc5: NSTextField!
    
    @IBOutlet var ymlJEBs2: NSTextField!
    @IBOutlet var ymlJEBs4: NSTextField!
    @IBOutlet var ymlJEBc4: NSTextField!
    @IBOutlet var ymlJEBc5: NSTextField!
    
    @IBOutlet var ymlLLLs2: NSTextField!
    @IBOutlet var ymlLLLs4: NSTextField!
    @IBOutlet var ymlLLLc4: NSTextField!
    @IBOutlet var ymlLLLc5: NSTextField!
    
    @IBOutlet var ymlSPRs2: NSTextField!
    @IBOutlet var ymlSPRs4: NSTextField!
    @IBOutlet var ymlSPRc4: NSTextField!
    @IBOutlet var ymlSPRc5: NSTextField!
    
    weak var delegate: EC5AllocationViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func setAllocations(_ sender: Any) {
        
        oneAllocations.updateValue((Int(oneCMBs2.stringValue)) ?? 0, forKey: "oneCMBs2")
        oneAllocations.updateValue((Int(oneCMBs4.stringValue)) ?? 0, forKey: "oneCMBs4")
        oneAllocations.updateValue((Int(oneCMBc4.stringValue)) ?? 0, forKey: "oneCMBc4")
        oneAllocations.updateValue((Int(oneCMBc5.stringValue)) ?? 0, forKey: "oneCMBc5")
        
        oneAllocations.updateValue((Int(oneHALs2.stringValue)) ?? 0, forKey: "oneHALs2")
        oneAllocations.updateValue((Int(oneHALs4.stringValue)) ?? 0, forKey: "oneHALs4")
        oneAllocations.updateValue((Int(oneHALc4.stringValue)) ?? 0, forKey: "oneHALc4")
        oneAllocations.updateValue((Int(oneHALc5.stringValue)) ?? 0, forKey: "oneHALc5")
        
        oneAllocations.updateValue((Int(oneHCMs2.stringValue)) ?? 0, forKey: "oneHCMs2")
        oneAllocations.updateValue((Int(oneHCMs4.stringValue)) ?? 0, forKey: "oneHCMs4")
        oneAllocations.updateValue((Int(oneHCMc4.stringValue)) ?? 0, forKey: "oneHCMc4")
        oneAllocations.updateValue((Int(oneHCMc5.stringValue)) ?? 0, forKey: "oneHCMc5")
        
        oneAllocations.updateValue((Int(oneJEBs2.stringValue)) ?? 0, forKey: "oneJEBs2")
        oneAllocations.updateValue((Int(oneJEBs4.stringValue)) ?? 0, forKey: "oneJEBs4")
        oneAllocations.updateValue((Int(oneJEBc4.stringValue)) ?? 0, forKey: "oneJEBc4")
        oneAllocations.updateValue((Int(oneJEBc5.stringValue)) ?? 0, forKey: "oneJEBc5")
        
        oneAllocations.updateValue((Int(oneLLLs2.stringValue)) ?? 0, forKey: "oneLLLs2")
        oneAllocations.updateValue((Int(oneLLLs4.stringValue)) ?? 0, forKey: "oneLLLs4")
        oneAllocations.updateValue((Int(oneLLLc4.stringValue)) ?? 0, forKey: "oneLLLc4")
        oneAllocations.updateValue((Int(oneLLLc5.stringValue)) ?? 0, forKey: "oneLLLc5")
        
        oneAllocations.updateValue((Int(oneSPRs2.stringValue)) ?? 0, forKey: "oneSPRs2")
        oneAllocations.updateValue((Int(oneSPRs4.stringValue)) ?? 0, forKey: "oneSPRs4")
        oneAllocations.updateValue((Int(oneSPRc4.stringValue)) ?? 0, forKey: "oneSPRc4")
        oneAllocations.updateValue((Int(oneSPRc5.stringValue)) ?? 0, forKey: "oneSPRc5")
        
        
        
        hlcAllocations.updateValue((Int(hlcCMBs2.stringValue)) ?? 0, forKey: "hlcCMBs2")
        hlcAllocations.updateValue((Int(hlcCMBs4.stringValue)) ?? 0, forKey: "hlcCMBs4")
        hlcAllocations.updateValue((Int(hlcCMBc4.stringValue)) ?? 0, forKey: "hlcCMBc4")
        hlcAllocations.updateValue((Int(hlcCMBc5.stringValue)) ?? 0, forKey: "hlcCMBc5")
        
        hlcAllocations.updateValue((Int(hlcHALs2.stringValue)) ?? 0, forKey: "hlcHALs2")
        hlcAllocations.updateValue((Int(hlcHALs4.stringValue)) ?? 0, forKey: "hlcHALs4")
        hlcAllocations.updateValue((Int(hlcHALc4.stringValue)) ?? 0, forKey: "hlcHALc4")
        hlcAllocations.updateValue((Int(hlcHALc5.stringValue)) ?? 0, forKey: "hlcHALc5")
        
        hlcAllocations.updateValue((Int(hlcHCMs2.stringValue)) ?? 0, forKey: "hlcHCMs2")
        hlcAllocations.updateValue((Int(hlcHCMs4.stringValue)) ?? 0, forKey: "hlcHCMs4")
        hlcAllocations.updateValue((Int(hlcHCMc4.stringValue)) ?? 0, forKey: "hlcHCMc4")
        hlcAllocations.updateValue((Int(hlcHCMc5.stringValue)) ?? 0, forKey: "hlcHCMc5")
        
        hlcAllocations.updateValue((Int(hlcJEBs2.stringValue)) ?? 0, forKey: "hlcJEBs2")
        hlcAllocations.updateValue((Int(hlcJEBs4.stringValue)) ?? 0, forKey: "hlcJEBs4")
        hlcAllocations.updateValue((Int(hlcJEBc4.stringValue)) ?? 0, forKey: "hlcJEBc4")
        hlcAllocations.updateValue((Int(hlcJEBc5.stringValue)) ?? 0, forKey: "hlcJEBc5")
        
        hlcAllocations.updateValue((Int(hlcLLLs2.stringValue)) ?? 0, forKey: "hlcLLLs2")
        hlcAllocations.updateValue((Int(hlcLLLs4.stringValue)) ?? 0, forKey: "hlcLLLs4")
        hlcAllocations.updateValue((Int(hlcLLLc4.stringValue)) ?? 0, forKey: "hlcLLLc4")
        hlcAllocations.updateValue((Int(hlcLLLc5.stringValue)) ?? 0, forKey: "hlcLLLc5")
        
        hlcAllocations.updateValue((Int(hlcSPRs2.stringValue)) ?? 0, forKey: "hlcSPRs2")
        hlcAllocations.updateValue((Int(hlcSPRs4.stringValue)) ?? 0, forKey: "hlcSPRs4")
        hlcAllocations.updateValue((Int(hlcSPRc4.stringValue)) ?? 0, forKey: "hlcSPRc4")
        hlcAllocations.updateValue((Int(hlcSPRc5.stringValue)) ?? 0, forKey: "hlcSPRc5")
        
        
        
        ymlAllocations.updateValue((Int(ymlCMBs2.stringValue)) ?? 0, forKey: "ymlCMBs2")
        ymlAllocations.updateValue((Int(ymlCMBs4.stringValue)) ?? 0, forKey: "ymlCMBs4")
        ymlAllocations.updateValue((Int(ymlCMBc4.stringValue)) ?? 0, forKey: "ymlCMBc4")
        ymlAllocations.updateValue((Int(ymlCMBc5.stringValue)) ?? 0, forKey: "ymlCMBc5")
        
        ymlAllocations.updateValue((Int(ymlHALs2.stringValue)) ?? 0, forKey: "ymlHALs2")
        ymlAllocations.updateValue((Int(ymlHALs4.stringValue)) ?? 0, forKey: "ymlHALs4")
        ymlAllocations.updateValue((Int(ymlHALc4.stringValue)) ?? 0, forKey: "ymlHALc4")
        ymlAllocations.updateValue((Int(ymlHALc5.stringValue)) ?? 0, forKey: "ymlHALc5")
        
        ymlAllocations.updateValue((Int(ymlHCMs2.stringValue)) ?? 0, forKey: "ymlHCMs2")
        ymlAllocations.updateValue((Int(ymlHCMs4.stringValue)) ?? 0, forKey: "ymlHCMs4")
        ymlAllocations.updateValue((Int(ymlHCMc4.stringValue)) ?? 0, forKey: "ymlHCMc4")
        ymlAllocations.updateValue((Int(ymlHCMc5.stringValue)) ?? 0, forKey: "ymlHCMc5")
        
        ymlAllocations.updateValue((Int(ymlJEBs2.stringValue)) ?? 0, forKey: "ymlJEBs2")
        ymlAllocations.updateValue((Int(ymlJEBs4.stringValue)) ?? 0, forKey: "ymlJEBs4")
        ymlAllocations.updateValue((Int(ymlJEBc4.stringValue)) ?? 0, forKey: "ymlJEBc4")
        ymlAllocations.updateValue((Int(ymlJEBc5.stringValue)) ?? 0, forKey: "ymlJEBc5")
        
        ymlAllocations.updateValue((Int(ymlLLLs2.stringValue)) ?? 0, forKey: "ymlLLLs2")
        ymlAllocations.updateValue((Int(ymlLLLs4.stringValue)) ?? 0, forKey: "ymlLLLs4")
        ymlAllocations.updateValue((Int(ymlLLLc4.stringValue)) ?? 0, forKey: "ymlLLLc4")
        ymlAllocations.updateValue((Int(ymlLLLc5.stringValue)) ?? 0, forKey: "ymlLLLc5")
        
        ymlAllocations.updateValue((Int(ymlSPRs2.stringValue)) ?? 0, forKey: "ymlSPRs2")
        ymlAllocations.updateValue((Int(ymlSPRs4.stringValue)) ?? 0, forKey: "ymlSPRs4")
        ymlAllocations.updateValue((Int(ymlSPRc4.stringValue)) ?? 0, forKey: "ymlSPRc4")
        ymlAllocations.updateValue((Int(ymlSPRc5.stringValue)) ?? 0, forKey: "ymlSPRc5")
        
        
        let allocations = ["ONE": oneAllocations, "HLC": hlcAllocations, "YML": ymlAllocations]
        
        delegate?.passAllocations(allocations: allocations)
        
        let nc = NotificationCenter.default
        nc.post(name: NSNotification.Name("AllocationsChanged"), object: nil)
        
        self.dismissViewController(self)
        
    }
    
}
