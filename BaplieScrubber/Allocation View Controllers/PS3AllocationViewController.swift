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
    func passSavedAllocations(allocs: [String: String])
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
        "oneHCMs2":0,
        "oneHCMs4":0,
        "oneHCMc4":0,
        "oneHCMc5":0,
        "oneLLLs2":0,
        "oneLLLs4":0,
        "oneLLLc4":0,
        "oneLLLc5":0,
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
    
    @IBOutlet var oneHCMs2: NSTextField!
    @IBOutlet var oneHCMs4: NSTextField!
    @IBOutlet var oneHCMc4: NSTextField!
    @IBOutlet var oneHCMc5: NSTextField!
    
    @IBOutlet var oneLLLs2: NSTextField!
    @IBOutlet var oneLLLs4: NSTextField!
    @IBOutlet var oneLLLc4: NSTextField!
    @IBOutlet var oneLLLc5: NSTextField!
    
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
        "hlcHCMs2":0,
        "hlcHCMs4":0,
        "hlcHCMc4":0,
        "hlcHCMc5":0,
        "hlcLLLs2":0,
        "hlcLLLs4":0,
        "hlcLLLc4":0,
        "hlcLLLc5":0,
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
    
    @IBOutlet var hlcHCMs2: NSTextField!
    @IBOutlet var hlcHCMs4: NSTextField!
    @IBOutlet var hlcHCMc4: NSTextField!
    @IBOutlet var hlcHCMc5: NSTextField!
    
    @IBOutlet var hlcLLLs2: NSTextField!
    @IBOutlet var hlcLLLs4: NSTextField!
    @IBOutlet var hlcLLLc4: NSTextField!
    @IBOutlet var hlcLLLc5: NSTextField!
    
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
        "ymlHCMs2":0,
        "ymlHCMs4":0,
        "ymlHCMc4":0,
        "ymlHCMc5":0,
        "ymlLLLs2":0,
        "ymlLLLs4":0,
        "ymlLLLc4":0,
        "ymlLLLc5":0,
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
    
    @IBOutlet var ymlHCMs2: NSTextField!
    @IBOutlet var ymlHCMs4: NSTextField!
    @IBOutlet var ymlHCMc4: NSTextField!
    @IBOutlet var ymlHCMc5: NSTextField!
    
    @IBOutlet var ymlLLLs2: NSTextField!
    @IBOutlet var ymlLLLs4: NSTextField!
    @IBOutlet var ymlLLLc4: NSTextField!
    @IBOutlet var ymlLLLc5: NSTextField!
    
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
    
    var textFields = [NSTextField]()
    var savedAllocations = [String: String]()

    weak var delegate: PS3AllocationViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func prepareTextFields() {
        
        oneBUSs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneBUSs2")
        oneBUSs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneBUSs4")
        oneBUSc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneBUSc4")
        oneBUSc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneBUSc5")
        
        oneCMBs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneCMBs2")
        oneCMBs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneCMBs4")
        oneCMBc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneCMBc4")
        oneCMBc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneCMBc5")
        
        oneHCMs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneHCMs2")
        oneHCMs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneHCMs4")
        oneHCMc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneHCMc4")
        oneHCMc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneHCMc5")
        
        oneLLLs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneLLLs2")
        oneLLLs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneLLLs4")
        oneLLLc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneLLLc4")
        oneLLLc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneLLLc5")
        
        oneNGBs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneNGBs2")
        oneNGBs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneNGBs4")
        oneNGBc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneNGBc4")
        oneNGBc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneNGBc5")
        
        oneNSAs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneNSAs2")
        oneNSAs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneNSAs4")
        oneNSAc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneNSAc4")
        oneNSAc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneNSAc5")
        
        onePAVs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "onePAVs2")
        onePAVs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "onePAVs4")
        onePAVc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "onePAVc4")
        onePAVc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "onePAVc5")
        
        onePKLs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "onePKLs2")
        onePKLs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "onePKLs4")
        onePKLc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "onePKLc4")
        onePKLc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "onePKLc5")
        
        oneSHGs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneSHGs2")
        oneSHGs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneSHGs4")
        oneSHGc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneSHGc4")
        oneSHGc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneSHGc5")
        
        oneSHKs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneSHKs2")
        oneSHKs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneSHKs4")
        oneSHKc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneSHKc4")
        oneSHKc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneSHKc5")
        
        oneSPRs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneSPRs2")
        oneSPRs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneSPRs4")
        oneSPRc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneSPRc4")
        oneSPRc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "oneSPRc5")

        
        
        hlcBUSs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcBUSs2")
        hlcBUSs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcBUSs4")
        hlcBUSc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcBUSc4")
        hlcBUSc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcBUSc5")
        
        hlcCMBs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcCMBs2")
        hlcCMBs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcCMBs4")
        hlcCMBc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcCMBc4")
        hlcCMBc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcCMBc5")
        
        hlcHCMs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcHCMs2")
        hlcHCMs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcHCMs4")
        hlcHCMc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcHCMc4")
        hlcHCMc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcHCMc5")
        
        hlcLLLs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcLLLs2")
        hlcLLLs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcLLLs4")
        hlcLLLc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcLLLc4")
        hlcLLLc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcLLLc5")
        
        hlcNGBs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcNGBs2")
        hlcNGBs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcNGBs4")
        hlcNGBc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcNGBc4")
        hlcNGBc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcNGBc5")
        
        hlcNSAs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcNSAs2")
        hlcNSAs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcNSAs4")
        hlcNSAc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcNSAc4")
        hlcNSAc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcNSAc5")
        
        hlcPAVs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcPAVs2")
        hlcPAVs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcPAVs4")
        hlcPAVc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcPAVc4")
        hlcPAVc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcPAVc5")
        
        hlcPKLs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcPKLs2")
        hlcPKLs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcPKLs4")
        hlcPKLc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcPKLc4")
        hlcPKLc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcPKLc5")
        
        hlcSHGs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcSHGs2")
        hlcSHGs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcSHGs4")
        hlcSHGc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcSHGc4")
        hlcSHGc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcSHGc5")
        
        hlcSHKs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcSHKs2")
        hlcSHKs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcSHKs4")
        hlcSHKc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcSHKc4")
        hlcSHKc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcSHKc5")
        
        hlcSPRs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcSPRs2")
        hlcSPRs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcSPRs4")
        hlcSPRc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcSPRc4")
        hlcSPRc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "hlcSPRc5")
        
        
        
        ymlBUSs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlBUSs2")
        ymlBUSs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlBUSs4")
        ymlBUSc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlBUSc4")
        ymlBUSc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlBUSc5")
        
        ymlCMBs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlCMBs2")
        ymlCMBs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlCMBs4")
        ymlCMBc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlCMBc4")
        ymlCMBc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlCMBc5")
        
        ymlHCMs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlHCMs2")
        ymlHCMs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlHCMs4")
        ymlHCMc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlHCMc4")
        ymlHCMc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlHCMc5")
        
        ymlLLLs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlLLLs2")
        ymlLLLs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlLLLs4")
        ymlLLLc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlLLLc4")
        ymlLLLc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlLLLc5")
        
        ymlNGBs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlNGBs2")
        ymlNGBs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlNGBs4")
        ymlNGBc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlNGBc4")
        ymlNGBc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlNGBc5")
        
        ymlNSAs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlNSAs2")
        ymlNSAs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlNSAs4")
        ymlNSAc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlNSAc4")
        ymlNSAc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlNSAc5")
        
        ymlPAVs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlPAVs2")
        ymlPAVs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlPAVs4")
        ymlPAVc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlPAVc4")
        ymlPAVc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlPAVc5")
        
        ymlPKLs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlPKLs2")
        ymlPKLs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlPKLs4")
        ymlPKLc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlPKLc4")
        ymlPKLc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlPKLc5")
        
        ymlSHGs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlSHGs2")
        ymlSHGs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlSHGs4")
        ymlSHGc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlSHGc4")
        ymlSHGc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlSHGc5")
        
        ymlSHKs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlSHKs2")
        ymlSHKs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlSHKs4")
        ymlSHKc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlSHKc4")
        ymlSHKc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlSHKc5")
        
        ymlSPRs2.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlSPRs2")
        ymlSPRs4.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlSPRs4")
        ymlSPRc4.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlSPRc4")
        ymlSPRc5.identifier = NSUserInterfaceItemIdentifier(rawValue: "ymlSPRc5")
        
        
        
        textFields.append(oneBUSs2)
        textFields.append(oneBUSs4)
        textFields.append(oneBUSc4)
        textFields.append(oneBUSc5)
        
        textFields.append(oneCMBs2)
        textFields.append(oneCMBs4)
        textFields.append(oneCMBc4)
        textFields.append(oneCMBc5)
        
        textFields.append(oneHCMs2)
        textFields.append(oneHCMs4)
        textFields.append(oneHCMc4)
        textFields.append(oneHCMc5)
        
        textFields.append(oneLLLs2)
        textFields.append(oneLLLs4)
        textFields.append(oneLLLc4)
        textFields.append(oneLLLc5)
        
        textFields.append(oneNGBs2)
        textFields.append(oneNGBs4)
        textFields.append(oneNGBc4)
        textFields.append(oneNGBc5)
        
        textFields.append(oneNSAs2)
        textFields.append(oneNSAs4)
        textFields.append(oneNSAc4)
        textFields.append(oneNSAc5)
        
        textFields.append(onePAVs2)
        textFields.append(onePAVs4)
        textFields.append(onePAVc4)
        textFields.append(onePAVc5)
        
        textFields.append(onePKLs2)
        textFields.append(onePKLs4)
        textFields.append(onePKLc4)
        textFields.append(onePKLc5)
        
        textFields.append(oneSHGs2)
        textFields.append(oneSHGs4)
        textFields.append(oneSHGc4)
        textFields.append(oneSHGc5)
        
        textFields.append(oneSHKs2)
        textFields.append(oneSHKs4)
        textFields.append(oneSHKc4)
        textFields.append(oneSHKc5)
        
        textFields.append(oneSPRs2)
        textFields.append(oneSPRs4)
        textFields.append(oneSPRc4)
        textFields.append(oneSPRc5)

        
        
        textFields.append(hlcBUSs2)
        textFields.append(hlcBUSs4)
        textFields.append(hlcBUSc4)
        textFields.append(hlcBUSc5)
        
        textFields.append(hlcCMBs2)
        textFields.append(hlcCMBs4)
        textFields.append(hlcCMBc4)
        textFields.append(hlcCMBc5)
        
        textFields.append(hlcHCMs2)
        textFields.append(hlcHCMs4)
        textFields.append(hlcHCMc4)
        textFields.append(hlcHCMc5)
        
        textFields.append(hlcLLLs2)
        textFields.append(hlcLLLs4)
        textFields.append(hlcLLLc4)
        textFields.append(hlcLLLc5)
        
        textFields.append(hlcNGBs2)
        textFields.append(hlcNGBs4)
        textFields.append(hlcNGBc4)
        textFields.append(hlcNGBc5)
        
        textFields.append(hlcNSAs2)
        textFields.append(hlcNSAs4)
        textFields.append(hlcNSAc4)
        textFields.append(hlcNSAc5)
        
        textFields.append(hlcPAVs2)
        textFields.append(hlcPAVs4)
        textFields.append(hlcPAVc4)
        textFields.append(hlcPAVc5)
        
        textFields.append(hlcPKLs2)
        textFields.append(hlcPKLs4)
        textFields.append(hlcPKLc4)
        textFields.append(hlcPKLc5)
        
        textFields.append(hlcSHGs2)
        textFields.append(hlcSHGs4)
        textFields.append(hlcSHGc4)
        textFields.append(hlcSHGc5)
        
        textFields.append(hlcSHKs2)
        textFields.append(hlcSHKs4)
        textFields.append(hlcSHKc4)
        textFields.append(hlcSHKc5)
        
        textFields.append(hlcSPRs2)
        textFields.append(hlcSPRs4)
        textFields.append(hlcSPRc4)
        textFields.append(hlcSPRc5)

        
        
        textFields.append(ymlBUSs2)
        textFields.append(ymlBUSs4)
        textFields.append(ymlBUSc4)
        textFields.append(ymlBUSc5)
        
        textFields.append(ymlCMBs2)
        textFields.append(ymlCMBs4)
        textFields.append(ymlCMBc4)
        textFields.append(ymlCMBc5)
        
        textFields.append(ymlHCMs2)
        textFields.append(ymlHCMs4)
        textFields.append(ymlHCMc4)
        textFields.append(ymlHCMc5)
        
        textFields.append(ymlLLLs2)
        textFields.append(ymlLLLs4)
        textFields.append(ymlLLLc4)
        textFields.append(ymlLLLc5)
        
        textFields.append(ymlNGBs2)
        textFields.append(ymlNGBs4)
        textFields.append(ymlNGBc4)
        textFields.append(ymlNGBc5)
        
        textFields.append(ymlNSAs2)
        textFields.append(ymlNSAs4)
        textFields.append(ymlNSAc4)
        textFields.append(ymlNSAc5)
        
        textFields.append(ymlPAVs2)
        textFields.append(ymlPAVs4)
        textFields.append(ymlPAVc4)
        textFields.append(ymlPAVc5)
        
        textFields.append(ymlPKLs2)
        textFields.append(ymlPKLs4)
        textFields.append(ymlPKLc4)
        textFields.append(ymlPKLc5)
        
        textFields.append(ymlSHGs2)
        textFields.append(ymlSHGs4)
        textFields.append(ymlSHGc4)
        textFields.append(ymlSHGc5)
        
        textFields.append(ymlSHKs2)
        textFields.append(ymlSHKs4)
        textFields.append(ymlSHKc4)
        textFields.append(ymlSHKc5)
        
        textFields.append(ymlSPRs2)
        textFields.append(ymlSPRs4)
        textFields.append(ymlSPRc4)
        textFields.append(ymlSPRc5)

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
        
        oneAllocations.updateValue((Int(oneCMBs2.stringValue)) ?? 0, forKey: "oneCMBs2")
        oneAllocations.updateValue((Int(oneCMBs4.stringValue)) ?? 0, forKey: "oneCMBs4")
        oneAllocations.updateValue((Int(oneCMBc4.stringValue)) ?? 0, forKey: "oneCMBc4")
        oneAllocations.updateValue((Int(oneCMBc5.stringValue)) ?? 0, forKey: "oneCMBc5")
        
        oneAllocations.updateValue((Int(oneHCMs2.stringValue)) ?? 0, forKey: "oneHCMs2")
        oneAllocations.updateValue((Int(oneHCMs4.stringValue)) ?? 0, forKey: "oneHCMs4")
        oneAllocations.updateValue((Int(oneHCMc4.stringValue)) ?? 0, forKey: "oneHCMc4")
        oneAllocations.updateValue((Int(oneHCMc5.stringValue)) ?? 0, forKey: "oneHCMc5")
        
        oneAllocations.updateValue((Int(oneLLLs2.stringValue)) ?? 0, forKey: "oneLLLs2")
        oneAllocations.updateValue((Int(oneLLLs4.stringValue)) ?? 0, forKey: "oneLLLs4")
        oneAllocations.updateValue((Int(oneLLLc4.stringValue)) ?? 0, forKey: "oneLLLc4")
        oneAllocations.updateValue((Int(oneLLLc5.stringValue)) ?? 0, forKey: "oneLLLc5")
        
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
        
        oneAllocations.updateValue((Int(oneSHGs2.stringValue)) ?? 0, forKey: "oneSHGs2")
        oneAllocations.updateValue((Int(oneSHGs4.stringValue)) ?? 0, forKey: "oneSHGs4")
        oneAllocations.updateValue((Int(oneSHGc4.stringValue)) ?? 0, forKey: "oneSHGc4")
        oneAllocations.updateValue((Int(oneSHGc5.stringValue)) ?? 0, forKey: "oneSHGc5")

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
        
        hlcAllocations.updateValue((Int(hlcHCMs2.stringValue)) ?? 0, forKey: "hlcHCMs2")
        hlcAllocations.updateValue((Int(hlcHCMs4.stringValue)) ?? 0, forKey: "hlcHCMs4")
        hlcAllocations.updateValue((Int(hlcHCMc4.stringValue)) ?? 0, forKey: "hlcHCMc4")
        hlcAllocations.updateValue((Int(hlcHCMc5.stringValue)) ?? 0, forKey: "hlcHCMc5")
        
        hlcAllocations.updateValue((Int(hlcLLLs2.stringValue)) ?? 0, forKey: "hlcLLLs2")
        hlcAllocations.updateValue((Int(hlcLLLs4.stringValue)) ?? 0, forKey: "hlcLLLs4")
        hlcAllocations.updateValue((Int(hlcLLLc4.stringValue)) ?? 0, forKey: "hlcLLLc4")
        hlcAllocations.updateValue((Int(hlcLLLc5.stringValue)) ?? 0, forKey: "hlcLLLc5")
        
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
        
        hlcAllocations.updateValue((Int(hlcSHGs2.stringValue)) ?? 0, forKey: "hlcSHGs2")
        hlcAllocations.updateValue((Int(hlcSHGs4.stringValue)) ?? 0, forKey: "hlcSHGs4")
        hlcAllocations.updateValue((Int(hlcSHGc4.stringValue)) ?? 0, forKey: "hlcSHGc4")
        hlcAllocations.updateValue((Int(hlcSHGc5.stringValue)) ?? 0, forKey: "hlcSHGc5")

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
        
        ymlAllocations.updateValue((Int(ymlHCMs2.stringValue)) ?? 0, forKey: "ymlHCMs2")
        ymlAllocations.updateValue((Int(ymlHCMs4.stringValue)) ?? 0, forKey: "ymlHCMs4")
        ymlAllocations.updateValue((Int(ymlHCMc4.stringValue)) ?? 0, forKey: "ymlHCMc4")
        ymlAllocations.updateValue((Int(ymlHCMc5.stringValue)) ?? 0, forKey: "ymlHCMc5")
        
        ymlAllocations.updateValue((Int(ymlLLLs2.stringValue)) ?? 0, forKey: "ymlLLLs2")
        ymlAllocations.updateValue((Int(ymlLLLs4.stringValue)) ?? 0, forKey: "ymlLLLs4")
        ymlAllocations.updateValue((Int(ymlLLLc4.stringValue)) ?? 0, forKey: "ymlLLLc4")
        ymlAllocations.updateValue((Int(ymlLLLc5.stringValue)) ?? 0, forKey: "ymlLLLc5")
        
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
        
        ymlAllocations.updateValue((Int(ymlSHGs2.stringValue)) ?? 0, forKey: "ymlSHGs2")
        ymlAllocations.updateValue((Int(ymlSHGs4.stringValue)) ?? 0, forKey: "ymlSHGs4")
        ymlAllocations.updateValue((Int(ymlSHGc4.stringValue)) ?? 0, forKey: "ymlSHGc4")
        ymlAllocations.updateValue((Int(ymlSHGc5.stringValue)) ?? 0, forKey: "ymlSHGc5")

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
        delegate?.passAllocations(allocations: allocations)
        saveAllocations(allocations: allocations)

        let nc = NotificationCenter.default
        nc.post(name: NSNotification.Name("AllocationsChanged"), object: nil)
        
        self.dismissViewController(self)

    }
    
}
