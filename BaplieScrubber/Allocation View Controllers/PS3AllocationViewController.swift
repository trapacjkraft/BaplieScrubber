//
//  PS3AllocationViewController.swift
//  BaplieScrubber
//
//  Created by Joshua Kraft on 12/11/18.
//  Copyright © 2018 Joshua Kraft. All rights reserved.
//

import Cocoa

protocol PS3AllocationViewControllerDelegate: class {
    func passAllocations(allocations: [String: [String : Int]])
}

class PS3AllocationViewController: NSViewController {
 
    var oneAllocations = [
        "oneBUSs2": 0,
        "oneBUSs4": 0,
        "oneBUSc4": 0,
        "oneBUSc5": 0,
        "oneCMBs2": 0,
        "oneCMBs4": 0,
        "oneCMBc4": 0,
        "oneCMBc5": 0,
        "oneNGBs2": 0,
        "oneNGBs4": 0,
        "oneNGBc4": 0,
        "oneNGBc5": 0,
        "oneNSAs2": 0,
        "oneNSAs4": 0,
        "oneNSAc4": 0,
        "oneNSAc5": 0,
        "onePAVs2": 0,
        "onePAVs4": 0,
        "onePAVc4": 0,
        "onePAVc5": 0,
        "onePKLs2": 0,
        "onePKLs4": 0,
        "onePKLc4": 0,
        "onePKLc5": 0,
        "oneSHGs2": 0,
        "oneSHGs4": 0,
        "oneSHGc4": 0,
        "oneSHGc5": 0,
        "oneSHKs2": 0,
        "oneSHKs4": 0,
        "oneSHKc4": 0,
        "oneSHKc5": 0,
        "oneSPRs2": 0,
        "oneSPRs4": 0,
        "oneSPRc4": 0,
        "oneSPRc5": 0,
        ]

    @IBOutlet var oneBUSs2: NSTextField!
    @IBOutlet var oneBUSs4: NSTextField!
    @IBOutlet var oneBUSc4: NSTextField!
    @IBOutlet var oneBUSc5: NSTextField!
    
    @IBOutlet var oneCMBs2: NSTextField!
    @IBOutlet var oneCMBs4: NSTextField!
    @IBOutlet var oneCMBc4: NSTextField!
    @IBOutlet var oneCMBc5: NSTextField!
    
    @IBOutlet var oneNGBs2: NSTextField!
    @IBOutlet var oneNGBs4: NSTextField!
    @IBOutlet var oneNGBc4: NSTextField!
    @IBOutlet var oneNGBc5: NSTextField!
    
    @IBOutlet var oneNSAs2: NSTextField!
    @IBOutlet var oneNSAs4: NSTextField!
    @IBOutlet var oneNSAc4: NSTextField!
    @IBOutlet var oneNSAc5: NSTextField!
    
    @IBOutlet var onePAVs2: NSTextField!
    @IBOutlet var onePAVs4: NSTextField!
    @IBOutlet var onePAVc4: NSTextField!
    @IBOutlet var onePAVc5: NSTextField!
    
    @IBOutlet var onePKLs2: NSTextField!
    @IBOutlet var onePKLs4: NSTextField!
    @IBOutlet var onePKLc4: NSTextField!
    @IBOutlet var onePKLc5: NSTextField!
    
    @IBOutlet var oneSHGs2: NSTextField!
    @IBOutlet var oneSHGs4: NSTextField!
    @IBOutlet var oneSHGc4: NSTextField!
    @IBOutlet var oneSHGc5: NSTextField!
    
    @IBOutlet var oneSHKs2: NSTextField!
    @IBOutlet var oneSHKs4: NSTextField!
    @IBOutlet var oneSHKc4: NSTextField!
    @IBOutlet var oneSHKc5: NSTextField!
    
    @IBOutlet var oneSPRs2: NSTextField!
    @IBOutlet var oneSPRs4: NSTextField!
    @IBOutlet var oneSPRc4: NSTextField!
    @IBOutlet var oneSPRc5: NSTextField!
    
    var hlcAllocations = [
        "hlcBUSs2": 0,
        "hlcBUSs4": 0,
        "hlcBUSc4": 0,
        "hlcBUSc5": 0,
        "hlcCMBs2": 0,
        "hlcCMBs4": 0,
        "hlcCMBc4": 0,
        "hlcCMBc5": 0,
        "hlcNGBs2": 0,
        "hlcNGBs4": 0,
        "hlcNGBc4": 0,
        "hlcNGBc5": 0,
        "hlcNSAs2": 0,
        "hlcNSAs4": 0,
        "hlcNSAc4": 0,
        "hlcNSAc5": 0,
        "hlcPAVs2": 0,
        "hlcPAVs4": 0,
        "hlcPAVc4": 0,
        "hlcPAVc5": 0,
        "hlcPKLs2": 0,
        "hlcPKLs4": 0,
        "hlcPKLc4": 0,
        "hlcPKLc5": 0,
        "hlcSHGs2": 0,
        "hlcSHGs4": 0,
        "hlcSHGc4": 0,
        "hlcSHGc5": 0,
        "hlcSHKs2": 0,
        "hlcSHKs4": 0,
        "hlcSHKc4": 0,
        "hlcSHKc5": 0,
        "hlcSPRs2": 0,
        "hlcSPRs4": 0,
        "hlcSPRc4": 0,
        "hlcSPRc5": 0,
        ]
    @IBOutlet var hlcBUSs2: NSTextField!
    @IBOutlet var hlcBUSs4: NSTextField!
    @IBOutlet var hlcBUSc4: NSTextField!
    @IBOutlet var hlcBUSc5: NSTextField!
    
    @IBOutlet var hlcCMBs2: NSTextField!
    @IBOutlet var hlcCMBs4: NSTextField!
    @IBOutlet var hlcCMBc4: NSTextField!
    @IBOutlet var hlcCMBc5: NSTextField!
    
    @IBOutlet var hlcNGBs2: NSTextField!
    @IBOutlet var hlcNGBs4: NSTextField!
    @IBOutlet var hlcNGBc4: NSTextField!
    @IBOutlet var hlcNGBc5: NSTextField!
    
    @IBOutlet var hlcNSAs2: NSTextField!
    @IBOutlet var hlcNSAs4: NSTextField!
    @IBOutlet var hlcNSAc4: NSTextField!
    @IBOutlet var hlcNSAc5: NSTextField!
    
    @IBOutlet var hlcPAVs2: NSTextField!
    @IBOutlet var hlcPAVs4: NSTextField!
    @IBOutlet var hlcPAVc4: NSTextField!
    @IBOutlet var hlcPAVc5: NSTextField!
    
    @IBOutlet var hlcPKLs2: NSTextField!
    @IBOutlet var hlcPKLs4: NSTextField!
    @IBOutlet var hlcPKLc4: NSTextField!
    @IBOutlet var hlcPKLc5: NSTextField!
    
    @IBOutlet var hlcSHGs2: NSTextField!
    @IBOutlet var hlcSHGs4: NSTextField!
    @IBOutlet var hlcSHGc4: NSTextField!
    @IBOutlet var hlcSHGc5: NSTextField!
    
    @IBOutlet var hlcSHKs2: NSTextField!
    @IBOutlet var hlcSHKs4: NSTextField!
    @IBOutlet var hlcSHKc4: NSTextField!
    @IBOutlet var hlcSHKc5: NSTextField!
    
    @IBOutlet var hlcSPRs2: NSTextField!
    @IBOutlet var hlcSPRs4: NSTextField!
    @IBOutlet var hlcSPRc4: NSTextField!
    @IBOutlet var hlcSPRc5: NSTextField!
    
    var ymlAllocations = [
        "ymlBUSs2": 0,
        "ymlBUSs4": 0,
        "ymlBUSc4": 0,
        "ymlBUSc5": 0,
        "ymlCMBs2": 0,
        "ymlCMBs4": 0,
        "ymlCMBc4": 0,
        "ymlCMBc5": 0,
        "ymlNGBs2": 0,
        "ymlNGBs4": 0,
        "ymlNGBc4": 0,
        "ymlNGBc5": 0,
        "ymlNSAs2": 0,
        "ymlNSAs4": 0,
        "ymlNSAc4": 0,
        "ymlNSAc5": 0,
        "ymlPAVs2": 0,
        "ymlPAVs4": 0,
        "ymlPAVc4": 0,
        "ymlPAVc5": 0,
        "ymlPKLs2": 0,
        "ymlPKLs4": 0,
        "ymlPKLc4": 0,
        "ymlPKLc5": 0,
        "ymlSHGs2": 0,
        "ymlSHGs4": 0,
        "ymlSHGc4": 0,
        "ymlSHGc5": 0,
        "ymlSHKs2": 0,
        "ymlSHKs4": 0,
        "ymlSHKc4": 0,
        "ymlSHKc5": 0,
        "ymlSPRs2": 0,
        "ymlSPRs4": 0,
        "ymlSPRc4": 0,
        "ymlSPRc5": 0,
        ]

    @IBOutlet var ymlBUSs2: NSTextField!
    @IBOutlet var ymlBUSs4: NSTextField!
    @IBOutlet var ymlBUSc4: NSTextField!
    @IBOutlet var ymlBUSc5: NSTextField!
    
    @IBOutlet var ymlCMBs2: NSTextField!
    @IBOutlet var ymlCMBs4: NSTextField!
    @IBOutlet var ymlCMBc4: NSTextField!
    @IBOutlet var ymlCMBc5: NSTextField!
    
    @IBOutlet var ymlNGBs2: NSTextField!
    @IBOutlet var ymlNGBs4: NSTextField!
    @IBOutlet var ymlNGBc4: NSTextField!
    @IBOutlet var ymlNGBc5: NSTextField!
    
    @IBOutlet var ymlNSAs2: NSTextField!
    @IBOutlet var ymlNSAs4: NSTextField!
    @IBOutlet var ymlNSAc4: NSTextField!
    @IBOutlet var ymlNSAc5: NSTextField!
    
    @IBOutlet var ymlPAVs2: NSTextField!
    @IBOutlet var ymlPAVs4: NSTextField!
    @IBOutlet var ymlPAVc4: NSTextField!
    @IBOutlet var ymlPAVc5: NSTextField!
    
    @IBOutlet var ymlPKLs2: NSTextField!
    @IBOutlet var ymlPKLs4: NSTextField!
    @IBOutlet var ymlPKLc4: NSTextField!
    @IBOutlet var ymlPKLc5: NSTextField!
    
    @IBOutlet var ymlSHGs2: NSTextField!
    @IBOutlet var ymlSHGs4: NSTextField!
    @IBOutlet var ymlSHGc4: NSTextField!
    @IBOutlet var ymlSHGc5: NSTextField!
    
    @IBOutlet var ymlSHKs2: NSTextField!
    @IBOutlet var ymlSHKs4: NSTextField!
    @IBOutlet var ymlSHKc4: NSTextField!
    @IBOutlet var ymlSHKc5: NSTextField!
    
    @IBOutlet var ymlSPRs2: NSTextField!
    @IBOutlet var ymlSPRs4: NSTextField!
    @IBOutlet var ymlSPRc4: NSTextField!
    @IBOutlet var ymlSPRc5: NSTextField!
    
    weak var delegate: PS3AllocationViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func setAllocations(_ sender: Any) {
        
        oneAllocations.updateValue((Int(oneBUSs2.stringValue)) ?? 0, forKey: "oneBUSs2")
        oneAllocations.updateValue((Int(oneBUSs4.stringValue)) ?? 0, forKey: "oneBUSs4")
        oneAllocations.updateValue((Int(oneBUSc4.stringValue)) ?? 0, forKey: "oneBUSc4")
        oneAllocations.updateValue((Int(oneBUSc5.stringValue)) ?? 0, forKey: "oneBUSc5")
        
        oneAllocations.updateValue((Int(oneCMBs2.stringValue)) ?? 0, forKey: "oneCMBs2")
        oneAllocations.updateValue((Int(oneCMBs4.stringValue)) ?? 0, forKey: "oneCMBs4")
        oneAllocations.updateValue((Int(oneCMBc4.stringValue)) ?? 0, forKey: "oneCMBc4")
        oneAllocations.updateValue((Int(oneCMBc5.stringValue)) ?? 0, forKey: "oneCMBc5")
        
        oneAllocations.updateValue((Int(oneNGBs2.stringValue)) ?? 0, forKey: "oneNGBs2")
        oneAllocations.updateValue((Int(oneNGBs4.stringValue)) ?? 0, forKey: "oneNGBs4")
        oneAllocations.updateValue((Int(oneNGBc4.stringValue)) ?? 0, forKey: "oneNGBc4")
        oneAllocations.updateValue((Int(oneNGBc5.stringValue)) ?? 0, forKey: "oneNGBc5")
        
        oneAllocations.updateValue((Int(oneNSAs2.stringValue)) ?? 0, forKey: "oneNSAs2")
        oneAllocations.updateValue((Int(oneNSAs4.stringValue)) ?? 0, forKey: "oneNSAs4")
        oneAllocations.updateValue((Int(oneNSAc4.stringValue)) ?? 0, forKey: "oneNSAc4")
        oneAllocations.updateValue((Int(oneNSAc5.stringValue)) ?? 0, forKey: "oneNSAc5")
        
        oneAllocations.updateValue((Int(onePAVs2.stringValue)) ?? 0, forKey: "onePAVs2")
        oneAllocations.updateValue((Int(onePAVs4.stringValue)) ?? 0, forKey: "onePAVs4")
        oneAllocations.updateValue((Int(onePAVc4.stringValue)) ?? 0, forKey: "onePAVc4")
        oneAllocations.updateValue((Int(onePAVc5.stringValue)) ?? 0, forKey: "onePAVc5")
        
        oneAllocations.updateValue((Int(onePKLs2.stringValue)) ?? 0, forKey: "onePKLs2")
        oneAllocations.updateValue((Int(onePKLs4.stringValue)) ?? 0, forKey: "onePKLs4")
        oneAllocations.updateValue((Int(onePKLc4.stringValue)) ?? 0, forKey: "onePKLc4")
        oneAllocations.updateValue((Int(onePKLc5.stringValue)) ?? 0, forKey: "onePKLc5")
        
        oneAllocations.updateValue((Int(onePKLs2.stringValue)) ?? 0, forKey: "onePKLs2")
        oneAllocations.updateValue((Int(onePKLs4.stringValue)) ?? 0, forKey: "onePKLs4")
        oneAllocations.updateValue((Int(onePKLc4.stringValue)) ?? 0, forKey: "onePKLc4")
        oneAllocations.updateValue((Int(onePKLc5.stringValue)) ?? 0, forKey: "onePKLc5")
        
        oneAllocations.updateValue((Int(oneSHKs2.stringValue)) ?? 0, forKey: "oneSHKs2")
        oneAllocations.updateValue((Int(oneSHKs4.stringValue)) ?? 0, forKey: "oneSHKs4")
        oneAllocations.updateValue((Int(oneSHKc4.stringValue)) ?? 0, forKey: "oneSHKc4")
        oneAllocations.updateValue((Int(oneSHKc5.stringValue)) ?? 0, forKey: "oneSHKc5")
        
        oneAllocations.updateValue((Int(oneSPRs2.stringValue)) ?? 0, forKey: "oneSPRs2")
        oneAllocations.updateValue((Int(oneSPRs4.stringValue)) ?? 0, forKey: "oneSPRs4")
        oneAllocations.updateValue((Int(oneSPRc4.stringValue)) ?? 0, forKey: "oneSPRc4")
        oneAllocations.updateValue((Int(oneSPRc5.stringValue)) ?? 0, forKey: "oneSPRc5")
        
        
        
        hlcAllocations.updateValue((Int(hlcBUSs2.stringValue)) ?? 0, forKey: "hlcBUSs2")
        hlcAllocations.updateValue((Int(hlcBUSs4.stringValue)) ?? 0, forKey: "hlcBUSs4")
        hlcAllocations.updateValue((Int(hlcBUSc4.stringValue)) ?? 0, forKey: "hlcBUSc4")
        hlcAllocations.updateValue((Int(hlcBUSc5.stringValue)) ?? 0, forKey: "hlcBUSc5")
        
        hlcAllocations.updateValue((Int(hlcCMBs2.stringValue)) ?? 0, forKey: "hlcCMBs2")
        hlcAllocations.updateValue((Int(hlcCMBs4.stringValue)) ?? 0, forKey: "hlcCMBs4")
        hlcAllocations.updateValue((Int(hlcCMBc4.stringValue)) ?? 0, forKey: "hlcCMBc4")
        hlcAllocations.updateValue((Int(hlcCMBc5.stringValue)) ?? 0, forKey: "hlcCMBc5")
        
        hlcAllocations.updateValue((Int(hlcNGBs2.stringValue)) ?? 0, forKey: "hlcNGBs2")
        hlcAllocations.updateValue((Int(hlcNGBs4.stringValue)) ?? 0, forKey: "hlcNGBs4")
        hlcAllocations.updateValue((Int(hlcNGBc4.stringValue)) ?? 0, forKey: "hlcNGBc4")
        hlcAllocations.updateValue((Int(hlcNGBc5.stringValue)) ?? 0, forKey: "hlcNGBc5")
        
        hlcAllocations.updateValue((Int(hlcNSAs2.stringValue)) ?? 0, forKey: "hlcNSAs2")
        hlcAllocations.updateValue((Int(hlcNSAs4.stringValue)) ?? 0, forKey: "hlcNSAs4")
        hlcAllocations.updateValue((Int(hlcNSAc4.stringValue)) ?? 0, forKey: "hlcNSAc4")
        hlcAllocations.updateValue((Int(hlcNSAc5.stringValue)) ?? 0, forKey: "hlcNSAc5")
        
        hlcAllocations.updateValue((Int(hlcPAVs2.stringValue)) ?? 0, forKey: "hlcPAVs2")
        hlcAllocations.updateValue((Int(hlcPAVs4.stringValue)) ?? 0, forKey: "hlcPAVs4")
        hlcAllocations.updateValue((Int(hlcPAVc4.stringValue)) ?? 0, forKey: "hlcPAVc4")
        hlcAllocations.updateValue((Int(hlcPAVc5.stringValue)) ?? 0, forKey: "hlcPAVc5")
        
        hlcAllocations.updateValue((Int(hlcPKLs2.stringValue)) ?? 0, forKey: "hlcPKLs2")
        hlcAllocations.updateValue((Int(hlcPKLs4.stringValue)) ?? 0, forKey: "hlcPKLs4")
        hlcAllocations.updateValue((Int(hlcPKLc4.stringValue)) ?? 0, forKey: "hlcPKLc4")
        hlcAllocations.updateValue((Int(hlcPKLc5.stringValue)) ?? 0, forKey: "hlcPKLc5")
        
        hlcAllocations.updateValue((Int(hlcPKLs2.stringValue)) ?? 0, forKey: "hlcPKLs2")
        hlcAllocations.updateValue((Int(hlcPKLs4.stringValue)) ?? 0, forKey: "hlcPKLs4")
        hlcAllocations.updateValue((Int(hlcPKLc4.stringValue)) ?? 0, forKey: "hlcPKLc4")
        hlcAllocations.updateValue((Int(hlcPKLc5.stringValue)) ?? 0, forKey: "hlcPKLc5")
        
        hlcAllocations.updateValue((Int(hlcSHKs2.stringValue)) ?? 0, forKey: "hlcSHKs2")
        hlcAllocations.updateValue((Int(hlcSHKs4.stringValue)) ?? 0, forKey: "hlcSHKs4")
        hlcAllocations.updateValue((Int(hlcSHKc4.stringValue)) ?? 0, forKey: "hlcSHKc4")
        hlcAllocations.updateValue((Int(hlcSHKc5.stringValue)) ?? 0, forKey: "hlcSHKc5")
        
        hlcAllocations.updateValue((Int(hlcSPRs2.stringValue)) ?? 0, forKey: "hlcSPRs2")
        hlcAllocations.updateValue((Int(hlcSPRs4.stringValue)) ?? 0, forKey: "hlcSPRs4")
        hlcAllocations.updateValue((Int(hlcSPRc4.stringValue)) ?? 0, forKey: "hlcSPRc4")
        hlcAllocations.updateValue((Int(hlcSPRc5.stringValue)) ?? 0, forKey: "hlcSPRc5")

        
        
        ymlAllocations.updateValue((Int(ymlBUSs2.stringValue)) ?? 0, forKey: "ymlBUSs2")
        ymlAllocations.updateValue((Int(ymlBUSs4.stringValue)) ?? 0, forKey: "ymlBUSs4")
        ymlAllocations.updateValue((Int(ymlBUSc4.stringValue)) ?? 0, forKey: "ymlBUSc4")
        ymlAllocations.updateValue((Int(ymlBUSc5.stringValue)) ?? 0, forKey: "ymlBUSc5")
        
        ymlAllocations.updateValue((Int(ymlCMBs2.stringValue)) ?? 0, forKey: "ymlCMBs2")
        ymlAllocations.updateValue((Int(ymlCMBs4.stringValue)) ?? 0, forKey: "ymlCMBs4")
        ymlAllocations.updateValue((Int(ymlCMBc4.stringValue)) ?? 0, forKey: "ymlCMBc4")
        ymlAllocations.updateValue((Int(ymlCMBc5.stringValue)) ?? 0, forKey: "ymlCMBc5")
        
        ymlAllocations.updateValue((Int(ymlNGBs2.stringValue)) ?? 0, forKey: "ymlNGBs2")
        ymlAllocations.updateValue((Int(ymlNGBs4.stringValue)) ?? 0, forKey: "ymlNGBs4")
        ymlAllocations.updateValue((Int(ymlNGBc4.stringValue)) ?? 0, forKey: "ymlNGBc4")
        ymlAllocations.updateValue((Int(ymlNGBc5.stringValue)) ?? 0, forKey: "ymlNGBc5")
        
        ymlAllocations.updateValue((Int(ymlNSAs2.stringValue)) ?? 0, forKey: "ymlNSAs2")
        ymlAllocations.updateValue((Int(ymlNSAs4.stringValue)) ?? 0, forKey: "ymlNSAs4")
        ymlAllocations.updateValue((Int(ymlNSAc4.stringValue)) ?? 0, forKey: "ymlNSAc4")
        ymlAllocations.updateValue((Int(ymlNSAc5.stringValue)) ?? 0, forKey: "ymlNSAc5")
        
        ymlAllocations.updateValue((Int(ymlPAVs2.stringValue)) ?? 0, forKey: "ymlPAVs2")
        ymlAllocations.updateValue((Int(ymlPAVs4.stringValue)) ?? 0, forKey: "ymlPAVs4")
        ymlAllocations.updateValue((Int(ymlPAVc4.stringValue)) ?? 0, forKey: "ymlPAVc4")
        ymlAllocations.updateValue((Int(ymlPAVc5.stringValue)) ?? 0, forKey: "ymlPAVc5")
        
        ymlAllocations.updateValue((Int(ymlPKLs2.stringValue)) ?? 0, forKey: "ymlPKLs2")
        ymlAllocations.updateValue((Int(ymlPKLs4.stringValue)) ?? 0, forKey: "ymlPKLs4")
        ymlAllocations.updateValue((Int(ymlPKLc4.stringValue)) ?? 0, forKey: "ymlPKLc4")
        ymlAllocations.updateValue((Int(ymlPKLc5.stringValue)) ?? 0, forKey: "ymlPKLc5")
        
        ymlAllocations.updateValue((Int(ymlPKLs2.stringValue)) ?? 0, forKey: "ymlPKLs2")
        ymlAllocations.updateValue((Int(ymlPKLs4.stringValue)) ?? 0, forKey: "ymlPKLs4")
        ymlAllocations.updateValue((Int(ymlPKLc4.stringValue)) ?? 0, forKey: "ymlPKLc4")
        ymlAllocations.updateValue((Int(ymlPKLc5.stringValue)) ?? 0, forKey: "ymlPKLc5")
        
        ymlAllocations.updateValue((Int(ymlSHKs2.stringValue)) ?? 0, forKey: "ymlSHKs2")
        ymlAllocations.updateValue((Int(ymlSHKs4.stringValue)) ?? 0, forKey: "ymlSHKs4")
        ymlAllocations.updateValue((Int(ymlSHKc4.stringValue)) ?? 0, forKey: "ymlSHKc4")
        ymlAllocations.updateValue((Int(ymlSHKc5.stringValue)) ?? 0, forKey: "ymlSHKc5")
        
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
