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
    func resetReplacementValue()
}

class Rescrubber: NSObject, ErrorLogPopoverViewDelegate, RescrubberViewControllerDelegate {
    
    var errorLineNumbers: [Int]
    var errorLineValues: [String]
    var errorLinesAndText: [[String: String]]
    var valuesToRemove: [Int: String]
    var valuesToReplace: [Int: String]
    var valuesToRescrub: [RescrubberRecord]
    
    var replaceValues: [RescrubberRecord]
    var removeValues: [RescrubberRecord]
    
    var baplieContent: String
    var baplieToRescrub: [String]
    
    var replacementFooter = ""
    
    var baplieFooter = BaplieFooter()
    
    weak var delegate: RescrubberDelegate?
    
    override init() {
        
        errorLineNumbers = [Int]()
        errorLineValues = [String]()
        errorLinesAndText = [[String: String]]()
        valuesToRemove = [Int: String]()
        valuesToReplace = [Int: String]()
        valuesToRescrub = [RescrubberRecord]()
        
        replaceValues = [RescrubberRecord]()
        removeValues = [RescrubberRecord]()
        
        baplieContent = String()
        baplieToRescrub = [String]()
        
    }
    
    func updateBaplieContent(baplie: String) {
        baplieContent = baplie
    }
    
    func getFooter(footer: String) {
        baplieFooter = BaplieFooter(footer: footer)
        
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
        
        baplieToRescrub = baplie
    }
    
    func combineAndPassValues() {
        
        getErrorLineValues()
        
        var index = 0
        
        while index < errorLineValues.count {
            
            var valuesToAdd = [String: String]()
            valuesToAdd.updateValue((String(errorLineNumbers[index])), forKey: "lineNumber")
            valuesToAdd.updateValue(errorLineValues[index], forKey: "lineText")
            valuesToAdd.updateValue("No", forKey: "editedStatus")
            
            errorLinesAndText.append(valuesToAdd)
            index += 1
        }
        
        delegate?.getErrorLinesAndText(values: errorLinesAndText)
        
        index = 0
        
    }
    
    func getValuesToReplace(replacingValues: [Int : String]) {
        for (lineNumber, lineValue) in replacingValues {
            valuesToReplace.updateValue(lineValue, forKey: lineNumber)
            
            if let _: String = valuesToRemove[lineNumber] {
                valuesToRemove.removeValue(forKey: lineNumber)
            }
        }
        
    }
    
    func getValuesToRemove(removingValues: [Int : String]) {
        
        for (lineNumber, lineValue) in removingValues {
            valuesToRemove.updateValue(lineValue, forKey: lineNumber)
            
            if let _: String = valuesToReplace[lineNumber] {
                valuesToReplace.removeValue(forKey: lineNumber)
            }
        }
        
        for (lineNumber, lineValue) in valuesToRemove {
            let record = RescrubberRecord(number: lineNumber, value: lineValue, rescrub: false, replacement: nil)
            valuesToRescrub.append(record)
        }
        
        valuesToRemove.removeAll()
    
    }
    
    func getReplacementValue(value: String) {

        let replacementValue = value
        
        delegate?.resetReplacementValue()
        
        for (lineNumber, lineValue) in valuesToReplace {
            let record = RescrubberRecord(number: lineNumber, value: lineValue, rescrub: true, replacement: replacementValue)
            valuesToRescrub.append(record)
        }
        
        valuesToReplace.removeAll()
        
    }
    
    func rescrub() {
        
        for record in valuesToRescrub {
            
            if record.shouldBeRescrubbed {
                replaceValues.append(record)
            } else {
                removeValues.append(record)
            }
            
        }
        
        replaceValues = replaceValues.sorted(by: { $0.lineNumber > $1.lineNumber })
        removeValues = removeValues.sorted(by: { $0.lineNumber > $1.lineNumber })
        
        for record in replaceValues {
            
            baplieToRescrub[record.lineNumber - 1] = record.replacementValue!
            
        }
        
        for record in removeValues {
            
            baplieToRescrub.remove(at: record.lineNumber - 1)
            
        }
        
        
        updateFooter()
        
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("BaplieRescrubbed"), object: nil)
        
    }
    
    func updateFooter() {
        
        let newLineCount = baplieFooter.lineCount - removeValues.count
        
        let newFooter = baplieFooter.baplieFooterContent.replacingOccurrences(of: "+\(baplieFooter.lineCount)+", with: "+\(newLineCount)+")
        
        replacementFooter = newFooter
        
    }
    
    func getRescrubbedBaplie() -> (String, String) {
        
        let rescrubbedBaplieContent = baplieToRescrub.joined().trimmingCharacters(in: .whitespaces).replacingOccurrences(of: "'\n'\n", with: "'\n")
    
        return (rescrubbedBaplieContent, replacementFooter)
    }
    
    func reset() {
     
        errorLineNumbers = [Int]()
        errorLineValues = [String]()
        errorLinesAndText = [[String: String]]()
        
        baplieContent = String()

    }
    
}
