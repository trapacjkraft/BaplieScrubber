//
//  ErrorLogPopoverView.swift
//  BaplieScrubber
//
//  Created by Joshua Kraft on 12/24/18.
//  Copyright © 2018 Joshua Kraft. All rights reserved.
//

import Cocoa

protocol ErrorLogPopoverViewDelegate: class {
    func getErrorLineNumbers(numbers: [Int])
}

class ErrorLogPopoverView: NSViewController {

    @IBOutlet var errorLogDragWellView: DragWellView!
    
    weak var delegate: ErrorLogPopoverViewDelegate?
    
    override func viewDidLoad() {

        super.viewDidLoad()

        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(getErrorLog), name: Notification.Name("ErrorLogDropped"), object: nil)
        
        
    }
    
    @objc func getErrorLog() {
        
        let fm = FileManager.default
        
        let libraryDirectory: String = NSHomeDirectory() + "/" + "Library/Caches/com.trapac.BaplieScrubber"
        let fileName = URL(fileURLWithPath: errorLogDragWellView.droppedFilePath!).lastPathComponent.lowercased()
        
        if !fm.fileExists(atPath: libraryDirectory) {
            do {
                try fm.createDirectory(at: URL(fileURLWithPath: libraryDirectory), withIntermediateDirectories: true, attributes: nil)
            } catch {
                Swift.print(error)
            }
        }
        
        
        let targetURL = libraryDirectory + "/" + fileName
        
        do {
            try fm.copyItem(at: URL(fileURLWithPath: errorLogDragWellView.droppedFilePath!), to: URL(fileURLWithPath: targetURL))
        } catch {
            Swift.print(error)
        }
        
        let data = fm.contents(atPath: targetURL)
        let contents = String(data: data!, encoding: .utf8)
        
        var errorLineNumbers = [Int]()
        
        let fileContents = contents!
        var errorLogContents = fileContents.components(separatedBy: "Beginning Inbound Translation.")[1].components(separatedBy: "Line number is ")
        errorLogContents.removeFirst()
        
        for line in errorLogContents {
            if let lineNumber = Int(line.components(separatedBy: ",")[0]) {
                errorLineNumbers.append(lineNumber)
            }
        }
        
        delegate?.getErrorLineNumbers(numbers: errorLineNumbers)
        errorLogDragWellView.clearBaplie()
        
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("DisplaySVC"), object: nil)
        
        dismissViewController(self)
    }
    
}
