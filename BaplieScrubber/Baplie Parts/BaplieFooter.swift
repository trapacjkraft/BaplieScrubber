//
//  BaplieFooter.swift
//  BaplieScrubber
//
//  Created by Joshua Kraft on 11/6/18.
//  Copyright © 2018 Joshua Kraft. All rights reserved.
//

import Cocoa

class BaplieFooter: NSObject {

    var lineCount = 0
    var baplieFooterContent: String
    
    override init() {
        baplieFooterContent = ""
    }
    
    init(footer: String) {
        
        baplieFooterContent = footer
        
        let footerContents = footer.components(separatedBy: "'")
        
        for line in footerContents {
            if line.contains("UNT++") {
                lineCount = Int(line.components(separatedBy: "++")[1].components(separatedBy: "+")[0])!
            } else if line.contains("UNT+") {
                lineCount = Int(line.components(separatedBy: "+")[1])!
            }
        }
        
        Swift.print("x")
    }
    
}
