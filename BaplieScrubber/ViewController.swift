//
//  ViewController.swift
//  BaplieScrubber
//
//  Created by Joshua Kraft on 9/2/18.
//  Copyright © 2018 Joshua Kraft. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet var baplieIconImage: NSImageView!
    @IBOutlet var baplieDragWellView: BaplieDragWell!
    @IBOutlet var baplieHeaderView: NSTextView!
    @IBOutlet var baplieContentView: NSTextView!
    @IBOutlet var baplieFooterView: NSTextView!
    @IBOutlet var exportButton: NSButton!
    
    

    var hasBaplie = false {
        didSet {
            if hasBaplie == true {
                displayBaplie()
                exportButton.isEnabled = true
            }
        }
    }
    var targetURL = ""
    var baplieContents = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(copyBaplie), name: Notification.Name("BaplieDropped"), object: nil)
    }
    

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    
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
    
    @IBAction func clearFTX(_ sender: Any) {
        
        var baplie = baplieContentView.string.components(separatedBy: "'")
        baplie.removeLast()
        var index = 0
        var lineCount = Int()
        var ftxIndices = [Int]()
        
        func trimFTX() {
            
            for _ in baplie {
                baplie[index] = baplie[index].trimmingCharacters(in: .whitespacesAndNewlines)
                baplie[index].append("'\n")
                index += 1
            }
            
            var ftxIndex = 0

            repeat {
                if baplie[ftxIndex].contains("FTX") {
                    ftxIndices.append(ftxIndex)
                }
                
                ftxIndex += 1
                
            } while ftxIndex < baplie.count
            
            ftxIndices = ftxIndices.reversed()
            
            for index in ftxIndices {
                baplie.remove(at: index)
            }
            
            baplieContentView.string = baplie.joined()
        }
        
        func adjustFooter() {
            var footerLines = baplieFooterView.string.components(separatedBy: "'")
            var footerFirstLineParts = footerLines[0].components(separatedBy: "+")
            lineCount = Int(footerFirstLineParts[1])!
            let newLineCount = String(lineCount - ftxIndices.count)
            let newFooter = "UNT+\(newLineCount)+\(footerFirstLineParts[2])'\(footerLines[1])'"
            baplieFooterView.string = newFooter
        }
        
        trimFTX()
        adjustFooter()
    }

    @IBAction func clearBaplie(_ sender: Any) {
        baplieDragWellView.clearBaplie()
        targetURL = ""
        baplieHeaderView.string = ""
        baplieContentView.string = ""
        baplieFooterView.string = ""
    }
}



