//
//  Allocator.swift
//  BaplieScrubber
//
//  Created by Joshua Kraft on 11/7/18.
//  Copyright © 2018 Joshua Kraft. All rights reserved.
//

import Cocoa

class Allocator: NSObject {

    var emptyS2: [BaplieContainer]
    var emptyS4: [BaplieContainer]
    var emptyC4: [BaplieContainer]
    var emptyC5: [BaplieContainer]
    var allocations: [String: [String : Int]]
    
    var hapagISOcodes = [
        "S2":"2CG1",
        "S4":"42G0",
        "C4":"45G0",
        "C5":"L5G0"
    ]
    
    var yangmingISOcodes = [
        "S2":"2200",
        "S4":"4300",
        "C4":"4500",
        "C5":"L5G0"
    ]
    
    var vesselOperator = ""

    var header = ""
    
    override init() {
        emptyS2 = [BaplieContainer]()
        emptyS4 = [BaplieContainer]()
        emptyC4 = [BaplieContainer]()
        emptyC5 = [BaplieContainer]()
        allocations = [String: [String : Int]]()
    }
    
    /*init(s2: [BaplieContainer], s4: [BaplieContainer], c4: [BaplieContainer], c5: [BaplieContainer], allocations: [String: [String : Int]]) {
        
        emptyS2 = s2
        emptyS4 = s4
        emptyC4 = c4
        emptyC5 = c5
        
        self.allocations = allocations
                
    }*/
    
    func getHeader(baplieHeader: String) {
        header = baplieHeader
    }
    
    func assignShippingLines(baplieString: String) -> String {
        
        var containers = [BaplieContainer]()
        var emptyContainers = [BaplieContainer]()
        
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
                    containers.append(container)
                    
                    containerStartingPoints.removeFirst()
                    
                }
            }
            
            let lastContainerStart = containerStartingPoints[0]
            let lastContainerEnd = baplie.endIndex - 1
            let lastContainer = baplie[lastContainerStart...lastContainerEnd]
            containers.append(BaplieContainer(container: lastContainer.joined()))
            
        }
        
        func getEmptyContainers() { //Checks for status flag on container records and creates an array of all empty containers.
            for container in containers {
                if !container.isFull {
                    emptyContainers.append(container)
                }
            }
        }
        
        func sortEmptyContainersBySize() { //Checks to find which set of ISO codes to use, then creates arrays for each type of SD empty. Nonstandard empties are USUALLY planned already, so no need to assign operators. Update later for OAK RFRs.
            
            func getVesselOperator() -> String {
                
                let headerArray = header.components(separatedBy: "'")
                
                for line in headerArray {
                    if line.contains("TDT+20+") {
                        let operatorLine = line.components(separatedBy: "+++")[1]
                        vesselOperator = operatorLine.components(separatedBy: ":")[0]
                    }
                }
                
                return vesselOperator
            }
            
            vesselOperator = getVesselOperator()
            
            switch vesselOperator {
                
            case "HLC":
                
                for container in emptyContainers {
                    
                    switch container.containerISO {
                    case hapagISOcodes["S2"]:
                        emptyS2.append(container)
                    case hapagISOcodes["S4"]:
                        emptyS4.append(container)
                    case hapagISOcodes["C4"]:
                        emptyC4.append(container)
                    case hapagISOcodes["C5"]:
                        emptyC5.append(container)
                    default:
                        break //Should not be reached.
                    }
                }
                
            case "YML":
                
                for container in emptyContainers {
                    
                    switch container.containerISO {
                        
                    case yangmingISOcodes["S2"]:
                        emptyS2.append(container)
                    case yangmingISOcodes["S4"]:
                        emptyS4.append(container)
                    case yangmingISOcodes["C4"]:
                        emptyC4.append(container)
                    case yangmingISOcodes["C5"]:
                        emptyC5.append(container)
                    default:
                        break //Should not be reached.
                    }
                }
                
            default:
                break //Reached if vessel operator line is malformed. Program needs to know vessel operator to decide which ISO codes to use. Should not be reached considering export features are for TraPac-generated Baplies.
            }
            
        }
        
        
        var emptyNGBs2 = [BaplieContainer]()
        var emptyNGBs4 = [BaplieContainer]()
        var emptyNGBc4 = [BaplieContainer]()
        var emptyNGBc5 = [BaplieContainer]()
        
        var emptyQDOs2 = [BaplieContainer]()
        var emptyQDOs4 = [BaplieContainer]()
        var emptyQDOc4 = [BaplieContainer]()
        var emptyQDOc5 = [BaplieContainer]()
        
        var emptySHGs2 = [BaplieContainer]()
        var emptySHGs4 = [BaplieContainer]()
        var emptySHGc4 = [BaplieContainer]()
        var emptySHGc5 = [BaplieContainer]()
        
        func sortContainerSizesByPort() {
            
            for container in emptyS2 {
                
                guard !emptyS2.isEmpty else { return }
                
                switch container.dischargePort {
                    
                case "CNNGB":
                    emptyNGBs2.append(container)
                case "CNTAO":
                    emptyQDOs2.append(container)
                case "CNSHA":
                    emptySHGs2.append(container)
                default:
                    break //Should not be reached if Baplie is properly formed. Only standard mtys to ports should be left ZZ.
                }
            }
            
            for container in emptyS4 {
                
                guard !emptyS4.isEmpty else { return }
                
                switch container.dischargePort {
                    
                case "CNNGB":
                    emptyNGBs4.append(container)
                case "CNTAO":
                    emptyQDOs4.append(container)
                case "CNSHA":
                    emptySHGs4.append(container)
                default:
                    break //Should not be reached if Baplie is properly formed. Only standard mtys to ports should be left ZZ.
                }
            }

            for container in emptyC4 {
                
                guard !emptyC4.isEmpty else { return }
                
                switch container.dischargePort {
                    
                case "CNNGB":
                    emptyNGBc4.append(container)
                case "CNTAO":
                    emptyQDOc4.append(container)
                case "CNSHA":
                    emptySHGc4.append(container)
                default:
                    break //Should not be reached if Baplie is properly formed. Only standard mtys to ports should be left ZZ.
                }
            }

            for container in emptyC5 {
                
                guard !emptyC5.isEmpty else { return }
                
                switch container.dischargePort {
                    
                case "CNNGB":
                    emptyNGBc5.append(container)
                case "CNTAO":
                    emptyQDOc5.append(container)
                case "CNSHA":
                    emptySHGc5.append(container)
                default:
                    break //Should not be reached if Baplie is properly formed. Only standard mtys to ports should be left ZZ.
                }
            }

            
        }
        
        var baplieContentWithOperators = String()
        var sortedContainers = [emptyNGBs2, emptyNGBs4, emptyNGBc4, emptyNGBc5, emptyQDOs2, emptyQDOs4, emptyQDOc4, emptyQDOc5, emptySHGs2, emptySHGs4, emptySHGc4, emptySHGc5]
        var combinedAllocations = [String: Int]()
        
        
        func combineAllocations() {
            
            for (_, allocation) in allocations {
                for (allocationType, allocationNumber) in allocation {
                    combinedAllocations.updateValue(allocationNumber, forKey: allocationType)
                }
            }
        }
        
        func assignOperators() {
            
            combineAllocations()
            
            func assignS2() {
                
                var index = 0
                
                var oneNGBs2count = combinedAllocations["oneNGBs2"]
                var hlcNGBs2count = combinedAllocations["hlcNGBs2"]
                var ymlNGBs2count = combinedAllocations["ymlNGBs2"]
                
                var oneQDOs2count = combinedAllocations["oneQDOs2"]
                var hlcQDOs2count = combinedAllocations["hlcQDOs2"]
                var ymlQDOs2count = combinedAllocations["ymlQDOs2"]
                
                var oneSHGs2count = combinedAllocations["oneSHGs2"]
                var hlcSHGs2count = combinedAllocations["hlcSHGs2"]
                var ymlSHGs2count = combinedAllocations["ymlSHGs2"]
                
                
                
                
                
            }

        }
        
        
        
        findContainers()
        getEmptyContainers()
        sortEmptyContainersBySize()
        sortContainerSizesByPort()
        
        
        
        
        return ""
    }

    
    
    
}
