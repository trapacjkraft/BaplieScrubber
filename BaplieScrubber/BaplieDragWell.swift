//
//  BaplieDragWell.swift
//  BaplieScrubber
//
//  Created by Joshua Kraft on 9/7/18.
//  Copyright © 2018 Joshua Kraft. All rights reserved.
//

import Cocoa

class BaplieDragWell: NSImageView {

    let fileTypes = ["edi", "txt"]
    var droppedBapliePath: String?
    var hasBaplie = false
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        registerForDraggedTypes([NSPasteboard.PasteboardType("public.file-url"), NSPasteboard.PasteboardType("public.item")])
        self.wantsLayer = true
    }
    
    func checkExtension(_ sender: NSDraggingInfo) -> Bool { //Check for .edi or .txt extensions
        guard let pb = sender.draggingPasteboard().propertyList(forType: NSPasteboard.PasteboardType(rawValue: "NSFilenamesPboardType")) as? NSArray,
            let path = pb[0] as? String else { return false }
        
        let suffix = URL(fileURLWithPath: path).pathExtension
        
        for type in fileTypes {
            if type.lowercased() == suffix {
                return true
            }
        }
        
        return false
    }
    
    func clearBaplie() { //Call in ViewController to return to launch-state
        self.image = NSImage(named: NSImage.Name("dimView"))
        droppedBapliePath = nil
        hasBaplie = false
    }

    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        if hasBaplie {
            return []
        } else if checkExtension(sender) {
            self.image = NSImage(named: NSImage.Name("litView"))
            return .copy
        }
        
        return []
    }
    
    override func draggingExited(_ sender: NSDraggingInfo?) {
        if !hasBaplie {
            self.image = NSImage(named: NSImage.Name("dimView"))
        }
    }
    
    override func draggingEnded(_ sender: NSDraggingInfo) {
        if hasBaplie {
            self.image = NSImage(named: NSImage.Name("activeView"))
        }
    }
    
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool { //Sets the baplie path to copy where needed and sends a loose coupled notification to let the app know that a baplie was dropped in
        
        guard let pb = sender.draggingPasteboard().propertyList(forType: NSPasteboard.PasteboardType(rawValue: "NSFilenamesPboardType")) as? NSArray,
            let path = pb[0] as? String else { return false }
        
        droppedBapliePath = path
        //Swift.print(droppedBapliePath) //This line will print the filepath to the console upon drop if you need it for debugging
        let nc = NotificationCenter.default
        hasBaplie = true
        nc.post(name: Notification.Name("BaplieDropped"), object: nil)
        
        return true
    }

    
}
