//
//  Scrubber.swift
//  BaplieScrubber
//
//  Created by Joshua Kraft on 11/6/18.
//  Copyright © 2018 Joshua Kraft. All rights reserved.
//

import Cocoa

class Scrubber: NSObject {
    
    
    var header = ""
    
    var allocator = Allocator()
    var allocations = [String: [String : Int]]()
    
    
    func getHeader(baplieHeader: String) {
        header = baplieHeader
    }
    
    func trimFTX(baplieString: String, footerString: String) -> (String, String) {
        
        var adjustedFooter = ""
        var baplie = baplieString.components(separatedBy: "'")
        var footer = footerString
        baplie.removeLast()
        var index = 0
        var lineCount = Int()
        var ftxIndices = [Int]()
        
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
        
        let trimmedBaplie = baplie.joined()
        
        func adjustFooter() {
            var footerLines = footer.components(separatedBy: "'")
            var footerFirstLineParts = footerLines[0].components(separatedBy: "+")
            lineCount = Int(footerFirstLineParts[1])!
            let newLineCount = String(lineCount - ftxIndices.count)
            let newFooter = "UNT+\(newLineCount)+\(footerFirstLineParts[2])'\(footerLines[1])'"
            adjustedFooter = newFooter
        }
        
        adjustFooter()
        
        return (trimmedBaplie, adjustedFooter)
        
    }
    
    func fixStartTags(baplieString: String, footerString: String) -> (String, String) {
        
        var allowedPrefixes = ["UNB+", "UNH+", "BGM+", "DTM+", "RFF+", "NAD+", "TDT+", "LOC+", "FTX+", "GID+", "GDS+", "MEA+", "DIM+", "TMP+", "RNG+", "RFF+", "EQD+", "EQA+", "DGS+", "UNT+", "UNZ+"]
        var baplie = baplieString.components(separatedBy: "'")
        baplie.removeLast()
        var index = 0
        var badIndex = 0
        var lineCount = Int()
        var badPrefixIndices = [Int]()
        var adjustedFooter = ""
        var trimmedBaplie = ""
        
        for _ in baplie {
            baplie[index] = baplie[index].trimmingCharacters(in: .whitespacesAndNewlines)
            baplie[index].append("'\n")
            index += 1
        }
        
        for line in baplie {
            if !allowedPrefixes.contains(where: line.contains) {
                badPrefixIndices.append(badIndex)
            }
            badIndex += 1
        }
        
        func removeBadTags() {
            for badIndex in badPrefixIndices.reversed() {
                baplie.remove(at: badIndex)
            }
            
            trimmedBaplie = baplie.joined()
            
        }
        
        func adjustFooter() {
            var footerLines = footerString.components(separatedBy: "'")
            var footerFirstLineParts = footerLines[0].components(separatedBy: "+")
            lineCount = Int(footerFirstLineParts[1])!
            let newLineCount = String(lineCount - badPrefixIndices.count)
            let newFooter = "UNT+\(newLineCount)+\(footerFirstLineParts[2])'\(footerLines[1])'"
            adjustedFooter = newFooter
        }
        
        removeBadTags()
        adjustFooter()
        
        return (trimmedBaplie, adjustedFooter)
        
    }
    
}
