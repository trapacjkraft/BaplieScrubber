//
//  ReplacementValuePopover.swift
//  BaplieScrubber
//
//  Created by Joshua Kraft on 12/30/18.
//  Copyright © 2018 Joshua Kraft. All rights reserved.
//

import Cocoa

protocol ReplacementValuePopoverDelegate: class {
    func setReplacementValue(value: String)
}

class ReplacementValuePopover: NSViewController {

    @IBOutlet var replacementValueField: NSTextField!

    weak var delegate: ReplacementValuePopoverDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func exit(_ sender: Any) {
        delegate?.setReplacementValue(value: replacementValueField.stringValue)
        dismissViewController(self)
    }
}
