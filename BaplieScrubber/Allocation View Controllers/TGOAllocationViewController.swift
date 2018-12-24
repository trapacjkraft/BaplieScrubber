//
//  TGOAllocationViewController.swift
//  BaplieScrubber
//
//  Created by Joshua Kraft on 12/21/18.
//  Copyright © 2018 Joshua Kraft. All rights reserved.
//

import Cocoa

protocol TGOAllocationViewControllerDelegate: class {
    func passAllocations(allocations: [String: [String : Int]])
}

class TGOAllocationViewController: NSViewController {
    
    var hlcAllocations = [
        "hlcBASs2": 0,
        "hlcBASs4": 0,
        "hlcBASc4": 0,
        "hlcBASc5": 0,
        "hlcIOAs2": 0,
        "hlcIOAs4": 0,
        "hlcIOAc4": 0,
        "hlcIOAc5": 0,
        "hlcMTVs2": 0,
        "hlcMTVs4": 0,
        "hlcMTVc4": 0,
        "hlcMTVc5": 0,
        "hlcRDJs2": 0,
        "hlcRDJs4": 0,
        "hlcRDJc4": 0,
        "hlcRDJc5": 0,
        "hlcRIGs2": 0,
        "hlcRIGs4": 0,
        "hlcRIGc4": 0,
        "hlcRIGc5": 0,
        "hlcSSAs2": 0,
        "hlcSSAs4": 0,
        "hlcSSAc4": 0,
        "hlcSSAc5": 0,
        "hlcSTSs2": 0,
        "hlcSTSs4": 0,
        "hlcSTSc4": 0,
        "hlcSTSc5": 0,
        ]
    
    @IBOutlet var hlcBASs2: NSTextField!
    @IBOutlet var hlcBASs4: NSTextField!
    @IBOutlet var hlcBASc4: NSTextField!
    @IBOutlet var hlcBASc5: NSTextField!
    
    @IBOutlet var hlcIOAs2: NSTextField!
    @IBOutlet var hlcIOAs4: NSTextField!
    @IBOutlet var hlcIOAc4: NSTextField!
    @IBOutlet var hlcIOAc5: NSTextField!
    
    @IBOutlet var hlcMTVs2: NSTextField!
    @IBOutlet var hlcMTVs4: NSTextField!
    @IBOutlet var hlcMTVc4: NSTextField!
    @IBOutlet var hlcMTVc5: NSTextField!
    
    @IBOutlet var hlcRDJs2: NSTextField!
    @IBOutlet var hlcRDJs4: NSTextField!
    @IBOutlet var hlcRDJc4: NSTextField!
    @IBOutlet var hlcRDJc5: NSTextField!
    
    @IBOutlet var hlcRIGs2: NSTextField!
    @IBOutlet var hlcRIGs4: NSTextField!
    @IBOutlet var hlcRIGc4: NSTextField!
    @IBOutlet var hlcRIGc5: NSTextField!
    
    @IBOutlet var hlcSSAs2: NSTextField!
    @IBOutlet var hlcSSAs4: NSTextField!
    @IBOutlet var hlcSSAc4: NSTextField!
    @IBOutlet var hlcSSAc5: NSTextField!
    
    @IBOutlet var hlcSTSs2: NSTextField!
    @IBOutlet var hlcSTSs4: NSTextField!
    @IBOutlet var hlcSTSc4: NSTextField!
    @IBOutlet var hlcSTSc5: NSTextField!
    
    
    
    var mskAllocations = [
        "mskBASs2": 0,
        "mskBASs4": 0,
        "mskBASc4": 0,
        "mskBASc5": 0,
        "mskIOAs2": 0,
        "mskIOAs4": 0,
        "mskIOAc4": 0,
        "mskIOAc5": 0,
        "mskMTVs2": 0,
        "mskMTVs4": 0,
        "mskMTVc4": 0,
        "mskMTVc5": 0,
        "mskRDJs2": 0,
        "mskRDJs4": 0,
        "mskRDJc4": 0,
        "mskRDJc5": 0,
        "mskRIGs2": 0,
        "mskRIGs4": 0,
        "mskRIGc4": 0,
        "mskRIGc5": 0,
        "mskSSAs2": 0,
        "mskSSAs4": 0,
        "mskSSAc4": 0,
        "mskSSAc5": 0,
        "mskSTSs2": 0,
        "mskSTSs4": 0,
        "mskSTSc4": 0,
        "mskSTSc5": 0,
        ]
    
    @IBOutlet var mskBASs2: NSTextField!
    @IBOutlet var mskBASs4: NSTextField!
    @IBOutlet var mskBASc4: NSTextField!
    @IBOutlet var mskBASc5: NSTextField!
    
    @IBOutlet var mskIOAs2: NSTextField!
    @IBOutlet var mskIOAs4: NSTextField!
    @IBOutlet var mskIOAc4: NSTextField!
    @IBOutlet var mskIOAc5: NSTextField!
    
    @IBOutlet var mskMTVs2: NSTextField!
    @IBOutlet var mskMTVs4: NSTextField!
    @IBOutlet var mskMTVc4: NSTextField!
    @IBOutlet var mskMTVc5: NSTextField!
    
    @IBOutlet var mskRDJs2: NSTextField!
    @IBOutlet var mskRDJs4: NSTextField!
    @IBOutlet var mskRDJc4: NSTextField!
    @IBOutlet var mskRDJc5: NSTextField!
    
    @IBOutlet var mskRIGs2: NSTextField!
    @IBOutlet var mskRIGs4: NSTextField!
    @IBOutlet var mskRIGc4: NSTextField!
    @IBOutlet var mskRIGc5: NSTextField!
    
    @IBOutlet var mskSSAs2: NSTextField!
    @IBOutlet var mskSSAs4: NSTextField!
    @IBOutlet var mskSSAc4: NSTextField!
    @IBOutlet var mskSSAc5: NSTextField!
    
    @IBOutlet var mskSTSs2: NSTextField!
    @IBOutlet var mskSTSs4: NSTextField!
    @IBOutlet var mskSTSc4: NSTextField!
    @IBOutlet var mskSTSc5: NSTextField!
  
    weak var delegate: TGOAllocationViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func setAllocations(_ sender: Any) {
        
        hlcAllocations.updateValue((Int(hlcBASs2.stringValue)) ?? 0, forKey: "hlcBASs2")
        hlcAllocations.updateValue((Int(hlcBASs4.stringValue)) ?? 0, forKey: "hlcBASs4")
        hlcAllocations.updateValue((Int(hlcBASc4.stringValue)) ?? 0, forKey: "hlcBASc4")
        hlcAllocations.updateValue((Int(hlcBASc5.stringValue)) ?? 0, forKey: "hlcBASc5")
        
        hlcAllocations.updateValue((Int(hlcIOAs2.stringValue)) ?? 0, forKey: "hlcIOAs2")
        hlcAllocations.updateValue((Int(hlcIOAs4.stringValue)) ?? 0, forKey: "hlcIOAs4")
        hlcAllocations.updateValue((Int(hlcIOAc4.stringValue)) ?? 0, forKey: "hlcIOAc4")
        hlcAllocations.updateValue((Int(hlcIOAc5.stringValue)) ?? 0, forKey: "hlcIOAc5")
        
        hlcAllocations.updateValue((Int(hlcMTVs2.stringValue)) ?? 0, forKey: "hlcMTVs2")
        hlcAllocations.updateValue((Int(hlcMTVs4.stringValue)) ?? 0, forKey: "hlcMTVs4")
        hlcAllocations.updateValue((Int(hlcMTVc4.stringValue)) ?? 0, forKey: "hlcMTVc4")
        hlcAllocations.updateValue((Int(hlcMTVc5.stringValue)) ?? 0, forKey: "hlcMTVc5")
        
        hlcAllocations.updateValue((Int(hlcRDJs2.stringValue)) ?? 0, forKey: "hlcRDJs2")
        hlcAllocations.updateValue((Int(hlcRDJs4.stringValue)) ?? 0, forKey: "hlcRDJs4")
        hlcAllocations.updateValue((Int(hlcRDJc4.stringValue)) ?? 0, forKey: "hlcRDJc4")
        hlcAllocations.updateValue((Int(hlcRDJc5.stringValue)) ?? 0, forKey: "hlcRDJc5")
        
        hlcAllocations.updateValue((Int(hlcRIGs2.stringValue)) ?? 0, forKey: "hlcRIGs2")
        hlcAllocations.updateValue((Int(hlcRIGs4.stringValue)) ?? 0, forKey: "hlcRIGs4")
        hlcAllocations.updateValue((Int(hlcRIGc4.stringValue)) ?? 0, forKey: "hlcRIGc4")
        hlcAllocations.updateValue((Int(hlcRIGc5.stringValue)) ?? 0, forKey: "hlcRIGc5")
        
        hlcAllocations.updateValue((Int(hlcSSAs2.stringValue)) ?? 0, forKey: "hlcSSAs2")
        hlcAllocations.updateValue((Int(hlcSSAs4.stringValue)) ?? 0, forKey: "hlcSSAs4")
        hlcAllocations.updateValue((Int(hlcSSAc4.stringValue)) ?? 0, forKey: "hlcSSAc4")
        hlcAllocations.updateValue((Int(hlcSSAc5.stringValue)) ?? 0, forKey: "hlcSSAc5")
        
        hlcAllocations.updateValue((Int(hlcSTSs2.stringValue)) ?? 0, forKey: "hlcSTSs2")
        hlcAllocations.updateValue((Int(hlcSTSs4.stringValue)) ?? 0, forKey: "hlcSTSs4")
        hlcAllocations.updateValue((Int(hlcSTSc4.stringValue)) ?? 0, forKey: "hlcSTSc4")
        hlcAllocations.updateValue((Int(hlcSTSc5.stringValue)) ?? 0, forKey: "hlcSTSc5")
        
        
        
        mskAllocations.updateValue((Int(mskBASs2.stringValue)) ?? 0, forKey: "mskBASs2")
        mskAllocations.updateValue((Int(mskBASs4.stringValue)) ?? 0, forKey: "mskBASs4")
        mskAllocations.updateValue((Int(mskBASc4.stringValue)) ?? 0, forKey: "mskBASc4")
        mskAllocations.updateValue((Int(mskBASc5.stringValue)) ?? 0, forKey: "mskBASc5")
        
        mskAllocations.updateValue((Int(mskIOAs2.stringValue)) ?? 0, forKey: "mskIOAs2")
        mskAllocations.updateValue((Int(mskIOAs4.stringValue)) ?? 0, forKey: "mskIOAs4")
        mskAllocations.updateValue((Int(mskIOAc4.stringValue)) ?? 0, forKey: "mskIOAc4")
        mskAllocations.updateValue((Int(mskIOAc5.stringValue)) ?? 0, forKey: "mskIOAc5")
        
        mskAllocations.updateValue((Int(mskMTVs2.stringValue)) ?? 0, forKey: "mskMTVs2")
        mskAllocations.updateValue((Int(mskMTVs4.stringValue)) ?? 0, forKey: "mskMTVs4")
        mskAllocations.updateValue((Int(mskMTVc4.stringValue)) ?? 0, forKey: "mskMTVc4")
        mskAllocations.updateValue((Int(mskMTVc5.stringValue)) ?? 0, forKey: "mskMTVc5")
        
        mskAllocations.updateValue((Int(mskRDJs2.stringValue)) ?? 0, forKey: "mskRDJs2")
        mskAllocations.updateValue((Int(mskRDJs4.stringValue)) ?? 0, forKey: "mskRDJs4")
        mskAllocations.updateValue((Int(mskRDJc4.stringValue)) ?? 0, forKey: "mskRDJc4")
        mskAllocations.updateValue((Int(mskRDJc5.stringValue)) ?? 0, forKey: "mskRDJc5")
        
        mskAllocations.updateValue((Int(mskRIGs2.stringValue)) ?? 0, forKey: "mskRIGs2")
        mskAllocations.updateValue((Int(mskRIGs4.stringValue)) ?? 0, forKey: "mskRIGs4")
        mskAllocations.updateValue((Int(mskRIGc4.stringValue)) ?? 0, forKey: "mskRIGc4")
        mskAllocations.updateValue((Int(mskRIGc5.stringValue)) ?? 0, forKey: "mskRIGc5")
        
        mskAllocations.updateValue((Int(mskSSAs2.stringValue)) ?? 0, forKey: "mskSSAs2")
        mskAllocations.updateValue((Int(mskSSAs4.stringValue)) ?? 0, forKey: "mskSSAs4")
        mskAllocations.updateValue((Int(mskSSAc4.stringValue)) ?? 0, forKey: "mskSSAc4")
        mskAllocations.updateValue((Int(mskSSAc5.stringValue)) ?? 0, forKey: "mskSSAc5")
        
        mskAllocations.updateValue((Int(mskSTSs2.stringValue)) ?? 0, forKey: "mskSTSs2")
        mskAllocations.updateValue((Int(mskSTSs4.stringValue)) ?? 0, forKey: "mskSTSs4")
        mskAllocations.updateValue((Int(mskSTSc4.stringValue)) ?? 0, forKey: "mskSTSc4")
        mskAllocations.updateValue((Int(mskSTSc5.stringValue)) ?? 0, forKey: "mskSTSc5")
        
        let allocations = ["hlc": hlcAllocations, "msk": mskAllocations]
        
        delegate?.passAllocations(allocations: allocations)
        
        let nc = NotificationCenter.default
        nc.post(name: NSNotification.Name("AllocationsChanged"), object: nil)
        
        self.dismissViewController(self)
        
    }
}
