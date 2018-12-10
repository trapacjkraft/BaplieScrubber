//
//  BaplieHeader.swift
//  BaplieScrubber
//
//  Created by Joshua Kraft on 11/6/18.
//  Copyright © 2018 Joshua Kraft. All rights reserved.
//

import Cocoa

class BaplieHeader: NSObject {

    var isTrapacBaplie: Bool
    var headerString: String
    var voyageNumber: String
    var vesselName: String
    var currentPort: String
    var nextPort: String
    var fileNameForExport: String
    
    override init() {
       
        isTrapacBaplie = false
        headerString = String()
        voyageNumber = ""
        vesselName = ""
        currentPort = ""
        nextPort = ""
        fileNameForExport = String()

    }
    
    init(header: String) {
        
        isTrapacBaplie = false
        headerString = header
        voyageNumber = ""
        vesselName = ""
        currentPort = ""
        nextPort = ""
        fileNameForExport = String()
        
        if headerString.contains("TRAPAC+TRAPAC") {
            
            isTrapacBaplie = true
            
            let headerContents = headerString.components(separatedBy: "'")
            
            for line in headerContents {
                if line.contains("TDT+20") {
                    let tdtLine = line
                    let tdtParts = tdtLine.components(separatedBy: "+++")
                    
                    if let number = tdtParts.first?.components(separatedBy: "+").last {
                        voyageNumber = number
                    }
                    
                    if let name = tdtParts.last?.components(separatedBy: "::").last?.components(separatedBy: ":").first {
                        vesselName = name
                    }
                    
                    fileNameForExport = vesselName.replacingOccurrences(of: " ", with: "_").lowercased() + "_" + voyageNumber.lowercased()
                    
                }
                
                if line.contains("LOC+5") {
                    currentPort = line.components(separatedBy: "+").last ?? ""
                }
                
                if line.contains("LOC+61") {
                    nextPort = line.components(separatedBy: "+").last ?? ""
                }
            }
        }
        
        
    }
    
}
