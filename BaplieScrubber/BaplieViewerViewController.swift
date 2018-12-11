//
//  BaplieViewerViewController.swift
//  BaplieScrubber
//
//  Created by Joshua Kraft on 12/10/18.
//  Copyright © 2018 Joshua Kraft. All rights reserved.
//

import Cocoa


@objc class BaplieViewerViewController: NSViewController {
    
    @IBOutlet var baplieHeaderView: NSTextView!
    @IBOutlet var baplieContentView: NSTextView!
    @IBOutlet var baplieFooterView: NSTextView!
        
    let nc = NotificationCenter.default
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        baplieHeaderView.isEditable = false
        baplieContentView.isEditable = false
        baplieFooterView.isEditable = false
                
    }
    
    @IBAction func dismiss(_ sender: NSButton) {
        self.dismiss(sender.superview)
    }
}
