//
//  ViewController.swift
//  BaplieScrubber
//
//  Created by Joshua Kraft on 9/2/18.
//  Copyright © 2018 Joshua Kraft. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, PS2AllocationViewControllerDelegate, PS3AllocationViewControllerDelegate, PS4AllocationViewControllerDelegate, PS5AllocationViewControllerDelegate, PS6AllocationViewControllerDelegate, PS7AllocationViewControllerDelegate, EC1AllocationViewControllerDelegate, JAX_EC1AllocationViewControllerDelegate, EC3AllocationViewControllerDelegate, EC5AllocationViewControllerDelegate {
    
    @IBOutlet var baplieIconImage: NSImageView!
    @IBOutlet var baplieDragWellView: BaplieDragWell!
    @IBOutlet var serviceList: NSPopUpButton!
    @IBOutlet var allocationButton: NSButton!
    @IBOutlet var assignEmptiesButton: NSButton!
    @IBOutlet var bsaReportButton: NSButton!
    @IBOutlet var exportButton: NSButton!
    @IBOutlet var viewButton: NSButton!
    
    let mainNC = NotificationCenter.default
    
    let baplieViewer: BaplieViewerViewController = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil).instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "BaplieViewerViewController")) as! BaplieViewerViewController
    
    var baplieHeader = "" {
        didSet {
            mainNC.post(name: Notification.Name("HeaderChanged"), object: nil)
        }
    }
    
    var baplieContent = "" {
        didSet {
            baplieContent = baplieContent.replacingOccurrences(of: "\'\n\'\n", with: "\'\n")
            mainNC.post(name: Notification.Name("ContentChanged"), object: nil)
        }
    }

    var baplieFooter = "" {
        didSet {
            mainNC.post(name: Notification.Name("FooterChanged"), object: nil)
        }
    }
    
    var header = BaplieHeader()
    
    var allocations = [String: [String: Int]]()
    
    var hasBaplie = false {
        didSet {
            if hasBaplie == true {
                updateData()
                exportButton.isEnabled = true
            }
        }
    }
    
    var baplieIsReady = false {
        didSet {
            if baplieIsReady == true {
                updateHeaders()
                bsaReportButton.isEnabled = true
                
            }
        }
    }
    
    var targetURL = ""
    var baplieFileContents = ""
    let scrubber = Scrubber()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        mainNC.addObserver(self, selector: #selector(copyBaplie), name: Notification.Name("BaplieDropped"), object: nil)
        mainNC.addObserver(self, selector: #selector(enableBaplieViewer), name: Notification.Name("BaplieDropped"), object: nil)
        mainNC.addObserver(self, selector: #selector(enableEmptyButton), name: Notification.Name("AllocationsChanged"), object: nil)
        mainNC.addObserver(self, selector: #selector(enableAllocButton), name: Notification.Name("HeaderFetched"), object: nil)
        
        mainNC.addObserver(self, selector: #selector(updateViewerHeader), name: Notification.Name("HeaderChanged"), object: nil)
        mainNC.addObserver(self, selector: #selector(updateViewerContent), name: Notification.Name("ContentChanged"), object: nil)
        mainNC.addObserver(self, selector: #selector(updateViewerFooter), name: Notification.Name("FooterChanged"), object: nil)

        
    }
    
    @objc func enableAllocButton() {
        allocationButton.isEnabled = true
    }
    
    @objc func enableEmptyButton() {
        assignEmptiesButton.isEnabled = true
    }
    
    @objc func enableBaplieViewer() {
        viewButton.isEnabled = true
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
        
        //Swift.print("Source path: " + baplieDragWellView.droppedBapliePath!)
        //Swift.print("Destination directory: " + libraryDirectory)
        //Swift.print("Destination path: " + targetURL)
        
        let data = fm.contents(atPath: targetURL)
        baplieFileContents = String(data: data!, encoding: .utf8)!
        hasBaplie = true
        
    }
    
    func getBaplieParts() {
        
        var baplie = baplieFileContents.components(separatedBy: "'")
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
            baplieHeader = header
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
            baplieFooter = footer
            
            
        }
        
        getHeader()
        getFooter()
        baplieContent = baplie.joined()
        
    }
    
    func updateData() {
        getBaplieParts()
        header = BaplieHeader(header: baplieHeader)
        
        mainNC.post(name: Notification.Name("HeaderFetched"), object: nil)
        
        func loadServices() {
            
            guard header.isTrapacBaplie else { return }
            
            switch header.currentPort {
                
            case "USLAX":
                guard let serviceFile = Bundle.main.url(forResource: "laxservices", withExtension: nil) else { break }
                guard let svcs = try? String(contentsOf: serviceFile) else { break }
                
                let services = svcs.components(separatedBy: ",")
                
                for service in services {
                    
                    let item = NSMenuItem(title: service, action: nil, keyEquivalent: "")
                    item.target = self
                    
                    serviceList.menu?.addItem(item)
                }
                
            case "USOAK":
                guard let serviceFile = Bundle.main.url(forResource: "oakservices", withExtension: nil) else { break }
                guard let svcs = try? String(contentsOf: serviceFile) else { break }
                
                let services = svcs.components(separatedBy: ",")
                
                for service in services {
                    
                    let item = NSMenuItem(title: service, action: nil, keyEquivalent: "")
                    item.target = self
                    
                    serviceList.menu?.addItem(item)
                }
                
            case "USJAX":
                guard let serviceFile = Bundle.main.url(forResource: "jaxservices", withExtension: nil) else { break }
                guard let svcs = try? String(contentsOf: serviceFile) else { break }
                
                let services = svcs.components(separatedBy: ",")
                
                for service in services {
                    
                    let item = NSMenuItem(title: service, action: nil, keyEquivalent: "")
                    item.target = self
                    
                    serviceList.menu?.addItem(item)
                }
            default:
                break //Should not be reached

            }
            
        }
        
        loadServices()
        serviceList.isEnabled = true

        baplieIsReady = true
    }
    
    @IBAction func displayBaplieViewer(_ sender: NSButton) {
        
        presentViewController(baplieViewer, asPopoverRelativeTo: sender.bounds, of: sender, preferredEdge: .minX, behavior: .applicationDefined)
    
        baplieViewer.baplieHeaderView.string = baplieHeader
        baplieViewer.baplieContentView.string = baplieContent
        baplieViewer.baplieFooterView.string = baplieFooter

    }
    
    @objc func updateViewerHeader() {
        guard baplieViewer.baplieHeaderView != nil else { return }
        baplieViewer.baplieHeaderView.string = baplieHeader
    }
    
    @objc func updateViewerContent() {
        guard baplieViewer.baplieContentView != nil else { return }
        baplieViewer.baplieContentView.string = baplieContent
    }
    
    @objc func updateViewerFooter() {
        guard baplieViewer.baplieFooterView != nil else { return }
        baplieViewer.baplieContentView.string = baplieFooter
    }
    
    @IBAction func writeBaplie(_ sender: Any) {
        
        let libraryDirectory: String = NSHomeDirectory() + "/" + "Library/Caches/com.trapac.BaplieScrubber/"
        let fileURL = baplieDragWellView.droppedBapliePath!
        var fileName = "scrubbed" + NSURL.fileURL(withPath: fileURL).lastPathComponent
        
        if header.isTrapacBaplie {
            fileName = header.vesselName.replacingOccurrences(of: " ", with: "_") + "_v." + header.voyageNumber + ".txt"
        }
        
        let destination = libraryDirectory + fileName
        
        let contents = baplieHeader + (baplieContent.replacingOccurrences(of: "'\n'\n", with: "'\n")) + baplieFooter
        
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
        scrubber.getHeader(baplieHeader: baplieHeader)
    }
    
    func clearFTX() {
        let trimmedParts = scrubber.trimFTX(baplieString: baplieContent, footerString: baplieFooter)
        baplieContent = trimmedParts.0
        baplieFooter = trimmedParts.1
    }
    
    func fixStartTags() {
        let trimmedParts = scrubber.fixStartTags(baplieString: baplieContent, footerString: baplieFooter)
        baplieContent = trimmedParts.0
        baplieFooter = trimmedParts.1
    }
        
    @IBAction func showAllocationPanel(_ sender: NSButton) {
        
        switch serviceList.titleOfSelectedItem {
        
        case "PS2":
            let vc: PS2AllocationViewController = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil).instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "PS2AllocationViewController")) as! PS2AllocationViewController
            vc.delegate = self
            
            presentViewController(vc, asPopoverRelativeTo: sender.bounds, of: sender, preferredEdge: .maxY, behavior: .semitransient)

        case "PS3":
            let vc: PS3AllocationViewController = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil).instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "PS3AllocationViewController")) as! PS3AllocationViewController
            vc.delegate = self
            
            presentViewController(vc, asPopoverRelativeTo: sender.bounds, of: sender, preferredEdge: .maxY, behavior: .semitransient)

        case "PS4":
            let vc: PS4AllocationViewController = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil).instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "PS4AllocationViewController")) as! PS4AllocationViewController
            vc.delegate = self
            
            presentViewController(vc, asPopoverRelativeTo: sender.bounds, of: sender, preferredEdge: .maxY, behavior: .semitransient)
            
        case "PS5":
            let vc: PS5AllocationViewController = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil).instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "PS5AllocationViewController")) as! PS5AllocationViewController
            vc.delegate = self
            
            presentViewController(vc, asPopoverRelativeTo: sender.bounds, of: sender, preferredEdge: .maxY, behavior: .semitransient)

        case "PS6":
            let vc: PS6AllocationViewController = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil).instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "PS6AllocationViewController")) as! PS6AllocationViewController
            vc.delegate = self
            
            presentViewController(vc, asPopoverRelativeTo: sender.bounds, of: sender, preferredEdge: .maxY, behavior: .semitransient)
            
        case "PS7":
            let vc: PS7AllocationViewController = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil).instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "PS7AllocationViewController")) as! PS7AllocationViewController
            vc.delegate = self
            
            presentViewController(vc, asPopoverRelativeTo: sender.bounds, of: sender, preferredEdge: .maxY, behavior: .semitransient)

        case "EC1":
            switch header.currentPort {
            case "USJAX":
                let vc: JAX_EC1AllocationViewController = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil).instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "JAX_EC1AllocationViewController")) as! JAX_EC1AllocationViewController
                vc.delegate = self

                presentViewController(vc, asPopoverRelativeTo: sender.bounds, of: sender, preferredEdge: .maxY, behavior: .semitransient)

            default:
                let vc: EC1AllocationViewController = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil).instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "EC1AllocationViewController")) as! EC1AllocationViewController
                vc.delegate = self
                
                presentViewController(vc, asPopoverRelativeTo: sender.bounds, of: sender, preferredEdge: .maxY, behavior: .semitransient)

            }

        case "EC3":
            let vc: EC3AllocationViewController = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil).instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "EC3AllocationViewController")) as! EC3AllocationViewController
            vc.delegate = self
            
            presentViewController(vc, asPopoverRelativeTo: sender.bounds, of: sender, preferredEdge: .maxY, behavior: .semitransient)

        case "EC5":
            let vc: EC5AllocationViewController = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil).instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "EC5AllocationViewController")) as! EC5AllocationViewController
            vc.delegate = self
            
            presentViewController(vc, asPopoverRelativeTo: sender.bounds, of: sender, preferredEdge: .maxY, behavior: .semitransient)

        default:
            break
            
        }
        
    }
    
    func passAllocations(allocations: [String: [String : Int]]) {
        self.allocations = allocations
        
    }
    
    @IBAction func assignEmptyLines(_ sender: Any) {
        
        guard !baplieContent.isEmpty else {
            let alert = NSAlert()
            alert.messageText = "No Baplie!"
            alert.informativeText = "There doesn't appear to be a Baplie loaded. Please load a Baplie before scrubbing."
            alert.runModal()
            return
        }

        switch serviceList.titleOfSelectedItem {
        
        case "PS2":
            let allocator = PS2Allocator()
            allocator.getHeader(baplieHeader: baplieHeader)
            allocator.allocations = self.allocations
            let (baplieFulls, baplieEmpties) = allocator.assignShippingLines(baplieString: baplieContent)
            baplieContent = baplieFulls + baplieEmpties

        case "PS3":
            let allocator = PS3Allocator()
            allocator.getHeader(baplieHeader: baplieHeader)
            allocator.allocations = self.allocations
            let (baplieFulls, baplieEmpties) = allocator.assignShippingLines(baplieString: baplieContent)
            baplieContent = baplieFulls + baplieEmpties

        case "PS4":
            let allocator = PS4Allocator()
            allocator.getHeader(baplieHeader: baplieHeader)
            allocator.allocations = self.allocations
            let (baplieFulls, baplieEmpties) = allocator.assignShippingLines(baplieString: baplieContent)
            baplieContent = baplieFulls + baplieEmpties

        case "PS5":
            let allocator = PS5Allocator()
            allocator.getHeader(baplieHeader: baplieHeader)
            allocator.allocations = self.allocations
            let (baplieFulls, baplieEmpties) = allocator.assignShippingLines(baplieString: baplieContent)
            baplieContent = baplieFulls + baplieEmpties
            
        case "PS6":
            let allocator = PS6Allocator()
            allocator.getHeader(baplieHeader: baplieHeader)
            allocator.allocations = self.allocations
            let (baplieFulls, baplieEmpties) = allocator.assignShippingLines(baplieString: baplieContent)
            baplieContent = baplieFulls + baplieEmpties
            
        case "PS7":
            let allocator = PS7Allocator()
            allocator.getHeader(baplieHeader: baplieHeader)
            allocator.allocations = self.allocations
            let (baplieFulls, baplieEmpties) = allocator.assignShippingLines(baplieString: baplieContent)
            baplieContent = baplieFulls + baplieEmpties

        case "EC1":
            switch header.currentPort {
            case "USJAX":
                break
            default:
                let allocator = JAX_EC1Allocator()
                allocator.getHeader(baplieHeader: baplieHeader)
                allocator.allocations = self.allocations
                let (baplieFulls, baplieEmpties) = allocator.assignShippingLines(baplieString: baplieContent)
                baplieContent = baplieFulls + baplieEmpties
            }
            
        case "EC3":
            let allocator = EC3Allocator()
            allocator.getHeader(baplieHeader: baplieHeader)
            allocator.allocations = self.allocations
            let (baplieFulls, baplieEmpties) = allocator.assignShippingLines(baplieString: baplieContent)
            baplieContent = baplieFulls + baplieEmpties
            
        case "EC5":
            let allocator = EC5Allocator()
            allocator.getHeader(baplieHeader: baplieHeader)
            allocator.allocations = self.allocations
            let (baplieFulls, baplieEmpties) = allocator.assignShippingLines(baplieString: baplieContent)
            baplieContent = baplieFulls + baplieEmpties
            
        default:
            break

        }

    }
    
    @IBAction func scrubBaplie(_ sender: Any) {
        
        guard !baplieHeader.contains("TRAPAC+TRAPAC") else {
            let alert = NSAlert()
            alert.messageText = "TraPac Baplie!"
            alert.informativeText = "This Baplie appears to have come from TraPac. Scrubbing is not supported for TraPac Baplies."
            alert.runModal()
            return
        }
        
        guard !baplieContent.isEmpty else {
            let alert = NSAlert()
            alert.messageText = "No Baplie!"
            alert.informativeText = "There doesn't appear to be a Baplie loaded. Please load a Baplie before scrubbing."
            alert.runModal()
            return
        }
        
        clearFTX()
        fixStartTags()
    }
    
    @IBAction func generateReport(_ sender: Any) {
        let reporter = Reporter(header: header, baplie: baplieContent)
        reporter.writeReport(report: reporter.generateTEUReportForCSV())
    }
    
    @IBAction func reset(_ sender: Any) {
        baplieDragWellView.clearBaplie()
        targetURL = ""
        baplieHeader = ""
        baplieContent = ""
        baplieFooter = ""
        hasBaplie = false
        baplieIsReady = false
        viewButton.isEnabled = false
        allocationButton.isEnabled = false
        assignEmptiesButton.isEnabled = false
        exportButton.isEnabled = false
        serviceList.removeAllItems()
        serviceList.isEnabled = false
    }
}



