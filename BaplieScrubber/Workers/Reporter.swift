//
//  Reporter.swift
//  BaplieScrubber
//
//  Created by Joshua Kraft on 12/10/18.
//  Copyright © 2018 Joshua Kraft. All rights reserved.
//

import Cocoa

class Reporter: NSObject {

    var baplieHeader: String
    var baplieString: String
    var allContainers = [BaplieContainer]()
    
    var fullContainers = [BaplieContainer]()
    var emptyContainers = [BaplieContainer]()
    var throughportContainers = [BaplieContainer]()
    
    init(header: String, baplie: String) {
        baplieHeader = header
        baplieString = baplie
    }
    
    
    func findContainers() { //Creates a list of all the containers in the Baplie.
        
        var baplie = baplieString.components(separatedBy: "'")
        var containerStartIndex = 0
        var containerStartIndices = [Int]()
        var index = 0
        var containerIndex = 0
        
        for _ in baplie {
            baplie[index] = baplie[index].trimmingCharacters(in: .whitespacesAndNewlines)
            baplie[index].append("'\n")
            index += 1
        }
        
        for line in baplie {
            if line.contains("LOC+147+") {
                containerStartIndex = containerIndex
                containerStartIndices.append(containerStartIndex)
            }
            containerIndex += 1
        }
        
        var containerStartingPoints = containerStartIndices
        
        for _ in containerStartIndices {
            
            while containerStartingPoints.count > 1 {
                let containerStart = containerStartingPoints[0]
                let containerEnd = containerStartingPoints[1]
                
                let containerSlice = baplie[containerStart..<containerEnd]
                let container = BaplieContainer(container: containerSlice.joined())
                allContainers.append(container)
                
                containerStartingPoints.removeFirst()
                
            }
        }
        
        let lastContainerStart = containerStartingPoints[0]
        let lastContainerEnd = baplie.endIndex - 1
        let lastContainer = baplie[lastContainerStart...lastContainerEnd]
        allContainers.append(BaplieContainer(container: lastContainer.joined()))
        
    }
    
    func sortContainers() {
        
    }

    
}
