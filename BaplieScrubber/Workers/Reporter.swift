//
//  Reporter.swift
//  BaplieScrubber
//
//  Created by Joshua Kraft on 12/10/18.
//  Copyright © 2018 Joshua Kraft. All rights reserved.
//

import Cocoa

extension Int {
    func isEven() -> Bool {
        return ((self % 2) == 0)
    }
}


class Reporter: NSObject {

    var baplieHeader: BaplieHeader
    var baplieString: String
    var allContainers = [BaplieContainer]()
    
    var fullContainers = [BaplieContainer]()
    var emptyContainers = [BaplieContainer]()
    var throughportContainers = [BaplieContainer]()
    
    var fullTEU = [
        "one": 0,
        "hlc": 0,
        "yml": 0
    ]
    
    var emptyTEU = [
        "one": 0,
        "hlc": 0,
        "yml": 0
    ]
    
    var throughportTEU = [
        "one": 0,
        "hlc": 0,
        "yml": 0,
    ]
    
    var oneTotalTEU = 0
    var hlcTotalTEU = 0
    var ymlTotalTEU = 0
    
    init(header: BaplieHeader, baplie: String) {
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
    
    func sortContainersByStatus() {
        for container in allContainers {
            if container.isThroughport(currentPort: baplieHeader.currentPort) {
                throughportContainers.append(container)
            } else {
                if container.isFull {
                    fullContainers.append(container)
                } else {
                    emptyContainers.append(container)
                }
            }
        }
    }
    
    func getTEUCounts() {
     
        var oneLadenFEUcontainers = [BaplieContainer]()
        var oneLadenTEUcontainers = [BaplieContainer]()
        var oneEmptyFEUcontainers = [BaplieContainer]()
        var oneEmptyTEUcontainers = [BaplieContainer]()
        var oneThroughportFEUcontainers = [BaplieContainer]()
        var oneThroughportTEUcontainers = [BaplieContainer]()

        var hlcLadenFEUcontainers = [BaplieContainer]()
        var hlcLadenTEUcontainers = [BaplieContainer]()
        var hlcEmptyFEUcontainers = [BaplieContainer]()
        var hlcEmptyTEUcontainers = [BaplieContainer]()
        var hlcThroughportFEUcontainers = [BaplieContainer]()
        var hlcThroughportTEUcontainers = [BaplieContainer]()

        var ymlLadenFEUcontainers = [BaplieContainer]()
        var ymlLadenTEUcontainers = [BaplieContainer]()
        var ymlEmptyFEUcontainers = [BaplieContainer]()
        var ymlEmptyTEUcontainers = [BaplieContainer]()
        var ymlThroughportFEUcontainers = [BaplieContainer]()
        var ymlThroughportTEUcontainers = [BaplieContainer]()
        
        var oneLadenFEU = 0
        var oneLadenTEU = 0
        var oneEmptyFEU = 0
        var oneEmptyTEU = 0
        var oneThroughportFEU = 0
        var oneThroughportTEU = 0
        
        var hlcLadenFEU = 0
        var hlcLadenTEU = 0
        var hlcEmptyFEU = 0
        var hlcEmptyTEU = 0
        var hlcThroughportFEU = 0
        var hlcThroughportTEU = 0

        var ymlLadenFEU = 0
        var ymlLadenTEU = 0
        var ymlEmptyFEU = 0
        var ymlEmptyTEU = 0
        var ymlThroughportFEU = 0
        var ymlThroughportTEU = 0
    
        if baplieHeader.currentPort == "USLAX" || baplieHeader.currentPort == "USOAK" {
            
            for container in fullContainers {
                
                if container.stowageBay.isEven() {
                    
                    switch container.shippingLine {
                        
                    case "ONE":
                        oneLadenFEU += 1
                        oneLadenFEUcontainers.append(container)
                    case "HLC":
                        hlcLadenFEU += 1
                        hlcLadenFEUcontainers.append(container)
                    case "YML":
                        ymlLadenFEU += 1
                        ymlLadenFEUcontainers.append(container)
                    default:
                        break
                        
                    }
                    
                } else {
                    
                    switch container.shippingLine {
                        
                    case "ONE":
                        oneLadenTEU += 1
                        oneLadenTEUcontainers.append(container)
                    case "HLC":
                        hlcLadenTEU += 1
                        hlcLadenTEUcontainers.append(container)
                    case "YML":
                        ymlLadenTEU += 1
                        ymlLadenTEUcontainers.append(container)
                    default:
                        break
                        
                    }
                }
            }
            
            for container in emptyContainers {
                
                if container.stowageBay.isEven() {
                    
                    switch container.shippingLine {
                        
                    case "ONE":
                        oneEmptyFEU += 1
                        oneEmptyFEUcontainers.append(container)
                    case "HLC":
                        hlcEmptyFEU += 1
                        hlcEmptyFEUcontainers.append(container)
                    case "YML":
                        ymlEmptyFEU += 1
                        ymlEmptyFEUcontainers.append(container)
                    default:
                        break
                        
                    }
                } else {
                    
                    switch container.shippingLine {
                        
                    case "ONE":
                        oneEmptyTEU += 1
                        oneEmptyTEUcontainers.append(container)
                    case "HLC":
                        hlcEmptyTEU += 1
                        hlcEmptyTEUcontainers.append(container)
                    case "YML":
                        ymlEmptyTEU += 1
                        ymlEmptyTEUcontainers.append(container)
                    default:
                        break
                        
                    }
                }
            }
            
            for container in throughportContainers {
                
                if container.stowageBay.isEven() {
                    
                    switch container.shippingLine {
                        
                    case "ONE":
                        oneThroughportFEU += 1
                        oneThroughportFEUcontainers.append(container)
                    case "HLC":
                        hlcThroughportFEU += 1
                        hlcThroughportFEUcontainers.append(container)
                    case "YML":
                        ymlThroughportFEU += 1
                        ymlThroughportFEUcontainers.append(container)
                    default:
                        break
                        
                    }
                } else {
                    
                    switch container.shippingLine {
                        
                    case "ONE":
                        oneThroughportTEU += 1
                        oneThroughportTEUcontainers.append(container)
                    case "HLC":
                        hlcThroughportTEU += 1
                        hlcThroughportTEUcontainers.append(container)
                    case "YML":
                        ymlThroughportTEU += 1
                        ymlThroughportTEUcontainers.append(container)
                    default:
                        break
                        
                    }
                }
            }
        }
        
        fullTEU.updateValue(((oneLadenFEU * 2) + oneLadenTEU), forKey: "one")
        fullTEU.updateValue(((hlcLadenFEU * 2) + hlcLadenTEU), forKey: "hlc")
        fullTEU.updateValue(((ymlLadenFEU * 2) + ymlLadenTEU), forKey: "yml")
        
        emptyTEU.updateValue(((oneEmptyFEU * 2) + oneEmptyTEU), forKey: "one")
        emptyTEU.updateValue(((hlcEmptyFEU * 2) + hlcEmptyTEU), forKey: "hlc")
        emptyTEU.updateValue(((ymlEmptyFEU * 2) + ymlEmptyTEU), forKey: "yml")
        
        throughportTEU.updateValue(((oneThroughportFEU * 2) + oneThroughportTEU), forKey: "one")
        throughportTEU.updateValue(((hlcThroughportFEU * 2) + hlcThroughportTEU), forKey: "hlc")
        throughportTEU.updateValue(((ymlThroughportFEU * 2) + ymlThroughportTEU), forKey: "yml")
        
        oneTotalTEU = fullTEU["one"]! + emptyTEU["one"]! + throughportTEU["one"]!
        hlcTotalTEU = fullTEU["hlc"]! + emptyTEU["hlc"]! + throughportTEU["hlc"]!
        ymlTotalTEU = fullTEU["yml"]! + emptyTEU["yml"]! + throughportTEU["yml"]!

        
    }

    func getContainerCounts() {
    }
    
    func generateTEUReportForCSV() -> String {
        
        findContainers()
        sortContainersByStatus()
        getTEUCounts()
        
        var CSVReport = ""
        
        if baplieHeader.currentPort == "USLAX" || baplieHeader.currentPort == "USOAK" {
            CSVReport = "\"\",ONE,HLC,YML" + "\nLaden (TEU),\(fullTEU["one"]!),\(fullTEU["hlc"]!),\(fullTEU["yml"]!)" + "\nEmpty (TEU),\(emptyTEU["one"]!),\(emptyTEU["hlc"]!),\(emptyTEU["yml"]!)" + "\nR.o.B (TEU),\(throughportTEU["one"]!),\(throughportTEU["hlc"]!),\(throughportTEU["yml"]!)" + "\nTotal (TEU),\(oneTotalTEU),\(hlcTotalTEU),\(ymlTotalTEU)"
        }
        
        
        return CSVReport
        
    }
    
    func generateContainerReportForCSV() {
    }
    
    
    func writeReport(report: String) {
        
        let libraryDirectory: String = NSHomeDirectory() + "/" + "Library/Caches/com.trapac.BaplieScrubber/"
        let fileName = baplieHeader.vesselName + " v." + baplieHeader.voyageNumber + " BSA.csv"
        
        let destination = libraryDirectory + fileName
        let contents = report
        
        do {
            try contents.write(toFile: destination, atomically: true, encoding: .utf8)
        } catch let error {
            let alert = NSAlert(error: error)
            alert.runModal()
        }
        
        let workspace = NSWorkspace()
        
        workspace.openFile(destination, withApplication: "Numbers")
    }
}

