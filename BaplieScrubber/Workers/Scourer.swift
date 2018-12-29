//
//  Scourer.swift
//  BaplieScrubber
//
//  Created by Joshua Kraft on 12/25/18.
//  Copyright © 2018 Joshua Kraft. All rights reserved.
//

import Cocoa

protocol ScourerDelegate: class {
    func getErrorLineNumbers(numbers: [Int])
    func getErrorLineValues(values: [String])
}

class Scourer: NSObject, ErrorLogPopoverViewDelegate {

    var errorLineNumbers = [Int]()
    var errorLineValues = [String]()
    var baplieHeader: BaplieHeader
    var baplieContents: String
    var baplieFooter: String
    
    weak var delegate: ScourerDelegate?
    
    override init() {
        baplieHeader = BaplieHeader()
        baplieContents = ""
        baplieFooter = ""
    }
    
    func update(header: String, baplie: String, footer: String) {
        baplieHeader = BaplieHeader(header: header)
        baplieContents = baplie
        baplieFooter = footer
    }
    
    
    func getErrorLineNumbers(numbers: [Int]) {
        errorLineNumbers = numbers
    }
    
    func makeBaplieArray(baplie: String) -> [String] {
    
        
        var array = baplie.components(separatedBy: "'")
        array.removeLast()
        
        var index = 0
        
        for _ in array {
            array[index] = array[index].trimmingCharacters(in: .whitespacesAndNewlines)
            array[index].append("'\n")
            index += 1
        }
        
        return array
    }
    
    func getErrorLineValues() -> [String] {
        
        let baplieLines = makeBaplieArray(baplie: baplieContents)
        
        for lineNumber in errorLineNumbers {
            errorLineValues.append(baplieLines[(lineNumber - 1)])
        }
        
        return [""]
    }
    
    func replaceLines() {
        errorLineValues = getErrorLineValues()
        //delegate?.getErrorLineNumbers(numbers: errorLineNumbers)
        //delegate?.getErrorLineValues(values: errorLineValues)
    }
}
