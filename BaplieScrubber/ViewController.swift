//
//  ViewController.swift
//  BaplieScrubber
//
//  Created by Joshua Kraft on 9/2/18.
//  Copyright © 2018 Joshua Kraft. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, AllocationViewControllerDelegate {
    
    @IBOutlet var baplieIconImage: NSImageView!
    @IBOutlet var baplieDragWellView: BaplieDragWell!
    @IBOutlet var baplieHeaderView: NSTextView!
    @IBOutlet var baplieContentView: NSTextView!
    @IBOutlet var baplieFooterView: NSTextView!
    @IBOutlet var assignEmptiesButton: NSButton!
    @IBOutlet var exportButton: NSButton!
    
    var allocations = [String: [String: Int]]()
    
    
    var hasBaplie = false {
        didSet {
            if hasBaplie == true {
                displayBaplie()
                exportButton.isEnabled = true
            }
        }
    }
    
    var baplieIsReady = false {
        didSet {
            if baplieIsReady == true {
                updateHeaders()
            }
        }
    }
    
    var targetURL = ""
    var baplieContents = ""
    let scrubber = Scrubber()
    let allocator = Allocator()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        baplieHeaderView.isSelectable = true
        baplieHeaderView.isEditable = false
        
        baplieContentView.isSelectable = true
        baplieContentView.isEditable = false
        
        baplieFooterView.isSelectable = true
        baplieContentView.isEditable = false
        
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(copyBaplie), name: Notification.Name("BaplieDropped"), object: nil)
        nc.addObserver(self, selector: #selector(enableEmptyButton), name: Notification.Name("AllocationsChanged"), object: nil)
        
    }
    
    @objc func enableEmptyButton() {
        assignEmptiesButton.isEnabled = true
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
    //Eventually, the below four methods should move to their own class.
    
    @objc func copyBaplie() {
        
        let fm = FileManager.default
        let libraryDirectory: String = NSHomeDirectory() + "/" + "Library/Caches/com.trapac.BaplieScrubber"
        
        if fm.fileExists(atPath: libraryDirectory) {
            do { try fm.removeItem(atPath: libraryDirectory) } catch let error {
                Swift.print(error)
                NSLog("Could not clean directory at startup: \(error)")
            }
        }
        
        do { try fm.createDirectory(atPath: libraryDirectory, withIntermediateDirectories: true, attributes: nil) } catch let error {
            NSLog("Could not create BaplieScrubber directory: \(error)")
            Swift.print(error)
            Swift.print("Destination directory: " + libraryDirectory)
        }
        
        let fileURL = baplieDragWellView.droppedBapliePath!
        let fileName = NSURL.fileURL(withPath: fileURL).lastPathComponent
        targetURL = libraryDirectory + "/" + fileName
        
        do { try fm.copyItem(atPath: fileURL, toPath: targetURL) } catch let error {
            NSLog("Could not copy file: \(error)")
            Swift.print(error)
            Swift.print("Destination path: " + targetURL)
        }
        
        Swift.print("Source path: " + baplieDragWellView.droppedBapliePath!)
        Swift.print("Destination directory: " + libraryDirectory)
        Swift.print("Destination path: " + targetURL)
        
        let data = fm.contents(atPath: targetURL)
        baplieContents = String(data: data!, encoding: .utf8)!
        hasBaplie = true
        
    }
    
    func getBaplieParts() {
        
        var baplie = baplieContents.components(separatedBy: "'")
        baplie.removeLast()
        var index = 0
        
        for _ in baplie {
            baplie[index] = baplie[index].trimmingCharacters(in: .whitespacesAndNewlines)
            baplie[index].append("'\n")
            index += 1
        }
        
        var header = String()
        var headerLineCount = 0
        
        func getHeader() {
            for line in baplie {
                if line.contains("LOC+147") {
                    break
                } else {
                    header.append(line)
                    headerLineCount += 1
                }
            }
            
            baplie.removeFirst(headerLineCount)
            baplieHeaderView.string = header
        }
        
        var footer = String()
        var footerLineCount = 0
        
        func getFooter() {
            
            for line in baplie {
                if line.contains("UNT+") || line.contains("UNZ+") {
                    footer.append(line)
                    footerLineCount += 1
                }
            }
            
            
            baplie.removeLast(footerLineCount)
            baplieFooterView.string = footer
            
            
        }
        
        getHeader()
        getFooter()
        baplieContentView.string = baplie.joined()
        
    }
    
    func displayBaplie() {
        getBaplieParts()
        baplieIsReady = true
    }
    
    @IBAction func writeBaplie(_ sender: Any) {
        
        let libraryDirectory: String = NSHomeDirectory() + "/" + "Library/Caches/com.trapac.BaplieScrubber/"
        let fileURL = baplieDragWellView.droppedBapliePath!
        let fileName = NSURL.fileURL(withPath: fileURL).lastPathComponent
        let destination = libraryDirectory + "scrubbed" + fileName
        
        let contents = baplieHeaderView.string + baplieContentView.string + baplieFooterView.string
        
        do {
            try contents.write(toFile: destination, atomically: true, encoding: .utf8)
        } catch {
            NSLog("Could not write baplie to directory: \(error)")
            Swift.print(error)
        }
        
        let workspace = NSWorkspace()
        workspace.openFile(destination, withApplication: "TextEdit")
        
    }
    
    func updateHeaders() {
        scrubber.getHeader(baplieHeader: baplieHeaderView.string)
        allocator.getHeader(baplieHeader: baplieHeaderView.string)
    }
    
    func clearFTX() {
        let trimmedParts = scrubber.trimFTX(baplieString: baplieContentView.string, footerString: baplieFooterView.string)
        baplieContentView.string = trimmedParts.0
        baplieFooterView.string = trimmedParts.1
    }
    
    func fixStartTags() {
        let trimmedParts = scrubber.fixStartTags(baplieString: baplieContentView.string, footerString: baplieFooterView.string)
        baplieContentView.string = trimmedParts.0
        baplieFooterView.string = trimmedParts.1
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if let allocationViewController = segue.destinationController as? AllocationViewController {
            allocationViewController.delegate = self
        }
    }
    
    func passAllocations(allocations: [String: [String : Int]]) {
        self.allocations = allocations
    }
    
    @IBAction func assignEmptyLines(_ sender: Any) {
        allocator.allocations = self.allocations        
        let (baplieFulls, baplieEmpties) = allocator.assignShippingLines(baplieString: baplieContentView.string)
        baplieContentView.string = baplieFulls + baplieEmpties

    }
    
    @IBAction func scrubBaplie(_ sender: Any) {
        
        guard !baplieHeaderView.string.contains("TRAPAC+TRAPAC") else {
            let alert = NSAlert()
            alert.messageText = "Outbound Baplie!"
            alert.informativeText = "This Baplie appears to have come from TraPac. Scrubbing is not supported for internal Baplies."
            alert.runModal()
            return
        }
        
        clearFTX()
        fixStartTags()
    }
    
    @IBAction func clearBaplie(_ sender: Any) {
        baplieDragWellView.clearBaplie()
        targetURL = ""
        baplieHeaderView.string = ""
        baplieContentView.string = ""
        baplieFooterView.string = ""
        hasBaplie = false
        baplieIsReady = false
        assignEmptiesButton.isEnabled = false
        exportButton.isEnabled = false
        allocator.reset()
    }
}



