//
//  ManualScrubberRecord.swift
//  BaplieScrubber
//
//  Created by Joshua Kraft on 1/4/19.
//  Copyright © 2019 Joshua Kraft. All rights reserved.
//

import Cocoa

class ManualScrubberRecord: NSObject {

    var lineNumber: Int
    var lineValue: String
    var shouldBeRescrubbed: Bool
    var replacementValue: String?
    
    init(number: Int, value: String, rescrub: Bool, replacement: String?) {
        lineNumber = number
        lineValue = value
        shouldBeRescrubbed = rescrub
        replacementValue = replacement
    }
    
}
