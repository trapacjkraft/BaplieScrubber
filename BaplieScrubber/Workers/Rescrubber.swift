//
//  Rescrubber.swift
//  BaplieScrubber
//
//  Created by Joshua Kraft on 12/29/18.
//  Copyright © 2018 Joshua Kraft. All rights reserved.
//

import Cocoa

protocol RescrubberDelegate: class {
    func getErrorLinesAndText(values: [[String: String]])
}

class Rescrubber: NSObject, ErrorLogPopoverViewDelegate {
    
    var errorLineNumbers: [Int]
    var errorLineValues: [String]
    var errorLinesAndText: [[String: String]]
    
    var baplieContent: String
    
    weak var delegate: RescrubberDelegate?
    
    override init() {
        
        errorLineNumbers = [Int]()
        errorLineValues = [String]()
        errorLinesAndText = [[String: String]]()
        
        baplieContent = String()
    }
    
    func updateBaplieContent(baplie: String) {
        baplieContent = baplie
    }
    
    func getErrorLineNumbers(numbers: [Int]) {
        errorLineNumbers = numbers
    }
    
    func getErrorLineValues() {
        
        var baplie = baplieContent.components(separatedBy: "'")
        baplie.removeLast()
        var index = 0
        
        for _ in baplie {
            baplie[index] = baplie[index].trimmingCharacters(in: .whitespacesAndNewlines)
            baplie[index].append("'\n")
            index += 1
        }

        for lineNumber in errorLineNumbers {
            errorLineValues.append(baplie[lineNumber - 1])
        }
    }
    
    func combineAndPassValues() {
        
        getErrorLineValues()
        
        var index = 0
        
        while index < errorLineValues.count {
            
            var valuesToAdd = [String: String]()
            valuesToAdd.updateValue((String(errorLineNumbers[index])), forKey: "lineNumber")
            valuesToAdd.updateValue(errorLineValues[index], forKey: "lineText")
            
            errorLinesAndText.append(valuesToAdd)
            index += 1
        }
        
        delegate?.getErrorLinesAndText(values: errorLinesAndText)
        
    }
    
    func reset() {
     
        errorLineNumbers = [Int]()
        errorLineValues = [String]()
        errorLinesAndText = [[String: String]]()
        
        baplieContent = String()

    }
    
}
