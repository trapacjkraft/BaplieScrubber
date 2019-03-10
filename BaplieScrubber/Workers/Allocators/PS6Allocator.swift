//
//  PS6Allocator.swift
//  BaplieScrubber
//
//  Created by Joshua Kraft on 12/14/18.
//  Copyright © 2018 Joshua Kraft. All rights reserved.
//

import Cocoa

class PS6Allocator: NSObject {
    
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
    
    var oneISOcodes = [
        "S2":"2200",
        "S2b":"22G0",
        "S4":"4300",
        "S4b":"42G0",
        "C4":"4500",
        "C4b":"45G0",
        "C5":"9500",
        "C5b":"L5G0"
    ]
    
    
    var vesselOperator = ""
    var previousOperator = ""
    var header = ""
    var combinedAllocations = [String: Int]()
    var originalBaplieContent = String()
    var didFailAllocationCheck = false
    var fullBaplieContent = String()
    var otherBaplieContent = String()
    var otherBaplieContentCount = Int()
    var emptyBaplieContentWithOperators = String()
    
    override init() {
        emptyS2 = [BaplieContainer]()
        emptyS4 = [BaplieContainer]()
        emptyC4 = [BaplieContainer]()
        emptyC5 = [BaplieContainer]()
        allocations = [String: [String : Int]]()
    }
    
    
    func getHeader(baplieHeader: String) {
        header = baplieHeader
    }
    
    func assignShippingLines(baplieString: String) -> (String, String) {
        
        var containers = [BaplieContainer]()
        var emptyPreplans = [BaplieContainer]()
        var notPreplanContainers = [BaplieContainer]()
        
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
        
        func sortContainersByStatus() { //Checks for status flag on container records and creates an array of all empty containers.
            
            for container in containers {
                if !container.isFull && container.isPreplan {
                    emptyPreplans.append(container)
                } else {
                    notPreplanContainers.append(container)
                    fullBaplieContent += container.containerRecordString
                }
            }
            
            fullBaplieContent = fullBaplieContent.replacingOccurrences(of: "\'\n\'\n", with: "\'\n")
            
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
            self.previousOperator = "NAD+CA+" + vesselOperator
            
            switch vesselOperator {
                
            case "HLC":
                
                for container in emptyPreplans {
                    
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
                        otherBaplieContent += container.containerRecordString
                        otherBaplieContentCount += 1
                    }
                }
                
            case "YML":
                
                for container in emptyPreplans {
                    
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
                        otherBaplieContent += container.containerRecordString
                        otherBaplieContentCount += 1
                    }
                }
                
            case "ONE":
                
                for container in emptyPreplans {
                    
                    switch container.containerISO {
                        
                    case oneISOcodes["S2"]:
                        emptyS2.append(container)
                    case oneISOcodes["S2b"]:
                        emptyS2.append(container)
                    case oneISOcodes["S4"]:
                        emptyS4.append(container)
                    case oneISOcodes["S4b"]:
                        emptyS4.append(container)
                    case oneISOcodes["C4"]:
                        emptyC4.append(container)
                    case oneISOcodes["C4b"]:
                        emptyC4.append(container)
                    case oneISOcodes["C5"]:
                        emptyC5.append(container)
                    case oneISOcodes["C5b"]:
                        emptyC5.append(container)
                        
                    default:
                        otherBaplieContent += container.containerRecordString
                        otherBaplieContentCount += 1
                    }
                }
                
            default:
                break //Reached if vessel operator line is malformed. Program needs to know vessel operator to decide which ISO codes to use. Should not be reached considering export features are for TraPac-generated Baplies.
            }
            
        }
        
        
        var emptyBUSs2 = [BaplieContainer]()
        var emptyBUSs4 = [BaplieContainer]()
        var emptyBUSc4 = [BaplieContainer]()
        var emptyBUSc5 = [BaplieContainer]()
        
        var emptyNGBs2 = [BaplieContainer]()
        var emptyNGBs4 = [BaplieContainer]()
        var emptyNGBc4 = [BaplieContainer]()
        var emptyNGBc5 = [BaplieContainer]()
        
        var emptySHGs2 = [BaplieContainer]()
        var emptySHGs4 = [BaplieContainer]()
        var emptySHGc4 = [BaplieContainer]()
        var emptySHGc5 = [BaplieContainer]()
        
        var emptyTKYs2 = [BaplieContainer]()
        var emptyTKYs4 = [BaplieContainer]()
        var emptyTKYc4 = [BaplieContainer]()
        var emptyTKYc5 = [BaplieContainer]()

        func sortContainerSizesByPort() {
            
            for container in emptyS2 {
                
                guard !emptyS2.isEmpty else { return }
                
                switch container.dischargePort {
                    
                case "KRPUS":
                    emptyBUSs2.append(container)
                case "CNNGB":
                    emptyNGBs2.append(container)
                case "CNSHA":
                    emptySHGs2.append(container)
                case "JPTYO":
                    emptyTKYs2.append(container)
                default:
                    otherBaplieContent += container.containerRecordString
                    otherBaplieContentCount += 1
                }
            }
            
            for container in emptyS4 {
                
                guard !emptyS4.isEmpty else { return }
                
                switch container.dischargePort {
                    
                case "KRPUS":
                    emptyBUSs4.append(container)
                case "CNNGB":
                    emptyNGBs4.append(container)
                case "CNSHA":
                    emptySHGs4.append(container)
                case "JPTYO":
                    emptyTKYs4.append(container)
                default:
                    otherBaplieContent += container.containerRecordString
                    otherBaplieContentCount += 1
                }
            }
            
            for container in emptyC4 {
                
                guard !emptyC4.isEmpty else { return }
                
                switch container.dischargePort {
                    
                case "KRPUS":
                    emptyBUSc4.append(container)
                case "CNNGB":
                    emptyNGBc4.append(container)
                case "CNSHA":
                    emptySHGc4.append(container)
                case "JPTYO":
                    emptyTKYc4.append(container)
                default:
                    otherBaplieContent += container.containerRecordString
                    otherBaplieContentCount += 1
                }
            }
            
            for container in emptyC5 {
                
                guard !emptyC5.isEmpty else { return }
                
                switch container.dischargePort {
                    
                case "KRPUS":
                    emptyBUSc5.append(container)
                case "CNNGB":
                    emptyNGBc5.append(container)
                case "CNSHA":
                    emptySHGc5.append(container)
                case "JPTYO":
                    emptyTKYc5.append(container)
                default:
                    otherBaplieContent += container.containerRecordString
                    otherBaplieContentCount += 1
                }
            }
            
            
        }
        
        func combineAllocations() {
            
            for (_, allocation) in allocations {
                for (allocationType, allocationNumber) in allocation {
                    combinedAllocations.updateValue(allocationNumber, forKey: allocationType)
                }
            }
        }
        
        func replaceOperator(container: BaplieContainer, newOperator: String) -> String {
            
            var replacedContainerString = ""
            
            guard newOperator.contains("NAD+CA+") else { return container.containerRecordString }
            replacedContainerString = container.containerRecordString.replacingOccurrences(of: previousOperator, with: newOperator)
            
            return replacedContainerString
            
        }
        
        func assignS2(containers: [BaplieContainer], oneKey: String, hlcKey: String, ymlKey: String) {
            
            let oneAllocation = combinedAllocations[oneKey]
            let hlcAllocation = combinedAllocations[hlcKey]
            let ymlAllocation = combinedAllocations[ymlKey]
            var allocatedONE = 0
            var allocatedYML = 0
            var allocatedHLC = 0
            
            for container in containers {
                if allocatedONE < oneAllocation! {
                    while allocatedONE < oneAllocation! {
                        emptyBaplieContentWithOperators += replaceOperator(container: container, newOperator: "NAD+CA+ONE")
                        allocatedONE += 1
                        break
                    }
                } else if allocatedHLC < hlcAllocation! {
                    while allocatedHLC < hlcAllocation! {
                        emptyBaplieContentWithOperators += replaceOperator(container: container, newOperator: "NAD+CA+HLC")
                        allocatedHLC += 1
                        break
                    }
                } else if allocatedYML < ymlAllocation! {
                    while allocatedYML < ymlAllocation! {
                        emptyBaplieContentWithOperators += replaceOperator(container: container, newOperator: "NAD+CA+YML")
                        allocatedYML += 1
                        break
                    }
                }
            }
            
            
        }
        
        func assignS4(containers: [BaplieContainer], oneKey: String, hlcKey: String, ymlKey: String) {
            
            let oneAllocation = combinedAllocations[oneKey]
            let hlcAllocation = combinedAllocations[hlcKey]
            let ymlAllocation = combinedAllocations[ymlKey]
            var allocatedONE = 0
            var allocatedYML = 0
            var allocatedHLC = 0
            
            for container in containers {
                if allocatedONE < oneAllocation! {
                    while allocatedONE < oneAllocation! {
                        emptyBaplieContentWithOperators += replaceOperator(container: container, newOperator: "NAD+CA+ONE")
                        allocatedONE += 1
                        break
                    }
                } else if allocatedHLC < hlcAllocation! {
                    while allocatedHLC < hlcAllocation! {
                        emptyBaplieContentWithOperators += replaceOperator(container: container, newOperator: "NAD+CA+HLC")
                        allocatedHLC += 1
                        break
                    }
                } else if allocatedYML < ymlAllocation! {
                    while allocatedYML < ymlAllocation! {
                        emptyBaplieContentWithOperators += replaceOperator(container: container, newOperator: "NAD+CA+YML")
                        allocatedYML += 1
                        break
                    }
                }
            }
            
        }
        
        func assignC4(containers: [BaplieContainer], oneKey: String, hlcKey: String, ymlKey: String) {
            
            let oneAllocation = combinedAllocations[oneKey]
            let hlcAllocation = combinedAllocations[hlcKey]
            let ymlAllocation = combinedAllocations[ymlKey]
            var allocatedONE = 0
            var allocatedYML = 0
            var allocatedHLC = 0
            
            for container in containers {
                if allocatedONE < oneAllocation! {
                    while allocatedONE < oneAllocation! {
                        emptyBaplieContentWithOperators += replaceOperator(container: container, newOperator: "NAD+CA+ONE")
                        allocatedONE += 1
                        break
                    }
                } else if allocatedHLC < hlcAllocation! {
                    while allocatedHLC < hlcAllocation! {
                        emptyBaplieContentWithOperators += replaceOperator(container: container, newOperator: "NAD+CA+HLC")
                        allocatedHLC += 1
                        break
                    }
                } else if allocatedYML < ymlAllocation! {
                    while allocatedYML < ymlAllocation! {
                        emptyBaplieContentWithOperators += replaceOperator(container: container, newOperator: "NAD+CA+YML")
                        allocatedYML += 1
                        break
                    }
                }
            }
            
        }
        
        func assignC5(containers: [BaplieContainer], oneKey: String, hlcKey: String, ymlKey: String) {
            
            let oneAllocation = combinedAllocations[oneKey]
            let hlcAllocation = combinedAllocations[hlcKey]
            let ymlAllocation = combinedAllocations[ymlKey]
            var allocatedONE = 0
            var allocatedYML = 0
            var allocatedHLC = 0
            
            for container in containers {
                if allocatedONE < oneAllocation! {
                    while allocatedONE < oneAllocation! {
                        emptyBaplieContentWithOperators += replaceOperator(container: container, newOperator: "NAD+CA+ONE")
                        allocatedONE += 1
                        break
                    }
                } else if allocatedHLC < hlcAllocation! {
                    while allocatedHLC < hlcAllocation! {
                        emptyBaplieContentWithOperators += replaceOperator(container: container, newOperator: "NAD+CA+HLC")
                        allocatedHLC += 1
                        break
                    }
                } else if allocatedYML < ymlAllocation! {
                    while allocatedYML < ymlAllocation! {
                        emptyBaplieContentWithOperators += replaceOperator(container: container, newOperator: "NAD+CA+YML")
                        allocatedYML += 1
                        break
                    }
                }
            }
            
        }
        
        
        func assignOperators() {
            
            var allocationsByPort = [String: Int]()
            
            allocationsByPort.updateValue((combinedAllocations["oneBUSs2"]! + combinedAllocations["hlcBUSs2"]! + combinedAllocations["ymlBUSs2"]!), forKey: "emptyBUSs2")
            allocationsByPort.updateValue((combinedAllocations["oneBUSs4"]! + combinedAllocations["hlcBUSs4"]! + combinedAllocations["ymlBUSs4"]!), forKey: "emptyBUSs4")
            allocationsByPort.updateValue((combinedAllocations["oneBUSc4"]! + combinedAllocations["hlcBUSc4"]! + combinedAllocations["ymlBUSc4"]!), forKey: "emptyBUSc4")
            allocationsByPort.updateValue((combinedAllocations["oneBUSc5"]! + combinedAllocations["hlcBUSc5"]! + combinedAllocations["ymlBUSc5"]!), forKey: "emptyBUSc5")
            
            allocationsByPort.updateValue((combinedAllocations["oneNGBs2"]! + combinedAllocations["hlcNGBs2"]! + combinedAllocations["ymlNGBs2"]!), forKey: "emptyNGBs2")
            allocationsByPort.updateValue((combinedAllocations["oneNGBs4"]! + combinedAllocations["hlcNGBs4"]! + combinedAllocations["ymlNGBs4"]!), forKey: "emptyNGBs4")
            allocationsByPort.updateValue((combinedAllocations["oneNGBc4"]! + combinedAllocations["hlcNGBc4"]! + combinedAllocations["ymlNGBc4"]!), forKey: "emptyNGBc4")
            allocationsByPort.updateValue((combinedAllocations["oneNGBc5"]! + combinedAllocations["hlcNGBc5"]! + combinedAllocations["ymlNGBc5"]!), forKey: "emptyNGBc5")
            
            allocationsByPort.updateValue((combinedAllocations["oneSHGs2"]! + combinedAllocations["hlcSHGs2"]! + combinedAllocations["ymlSHGs2"]!), forKey: "emptySHGs2")
            allocationsByPort.updateValue((combinedAllocations["oneSHGs4"]! + combinedAllocations["hlcSHGs4"]! + combinedAllocations["ymlSHGs4"]!), forKey: "emptySHGs4")
            allocationsByPort.updateValue((combinedAllocations["oneSHGc4"]! + combinedAllocations["hlcSHGc4"]! + combinedAllocations["ymlSHGc4"]!), forKey: "emptySHGc4")
            allocationsByPort.updateValue((combinedAllocations["oneSHGc5"]! + combinedAllocations["hlcSHGc5"]! + combinedAllocations["ymlSHGc5"]!), forKey: "emptySHGc5")
            
            allocationsByPort.updateValue((combinedAllocations["oneTKYs2"]! + combinedAllocations["hlcTKYs2"]! + combinedAllocations["ymlTKYs2"]!), forKey: "emptyTKYs2")
            allocationsByPort.updateValue((combinedAllocations["oneTKYs4"]! + combinedAllocations["hlcTKYs4"]! + combinedAllocations["ymlTKYs4"]!), forKey: "emptyTKYs4")
            allocationsByPort.updateValue((combinedAllocations["oneTKYc4"]! + combinedAllocations["hlcTKYc4"]! + combinedAllocations["ymlTKYc4"]!), forKey: "emptyTKYc4")
            allocationsByPort.updateValue((combinedAllocations["oneTKYc5"]! + combinedAllocations["hlcTKYc5"]! + combinedAllocations["ymlTKYc5"]!), forKey: "emptyTKYc5")
            
            let alert = NSAlert()
            
            let containerTypes = ["emptyBUSs2", "emptyBUSs4", "emptyBUSc4", "emptyBUSc5", "emptyNGBs2", "emptyNGBs4", "emptyNGBc4", "emptyNGBc5", "emptySHGs2", "emptySHGs4", "emptySHGc4", "emptySHGc5", "emptyTKYs2", "emptyTKYs4", "emptyTKYc4", "emptyTKYc5"]
            let containerArrays = [emptyBUSs2, emptyBUSs4, emptyBUSc4, emptyBUSc5, emptyNGBs2, emptyNGBs4, emptyNGBc4, emptyNGBc5, emptySHGs2, emptySHGs4, emptySHGc4, emptySHGc5, emptyTKYs2, emptyTKYs4, emptyTKYc4, emptyTKYc5]
            
            var index = 0
            
            for containerType in containerTypes {
                
                guard allocationsByPort[containerType]! == containerArrays[index].count else {
                    
                    let difference = containerArrays[index].count - allocationsByPort[containerType]!
                    
                    alert.messageText = "Allocation error!"
                
                    if difference < 0 {
                        alert.informativeText = "You have overallocated for \(containerType) preplans. Please adjust the allocation amount for \(containerType) preplans by " + String(abs(difference)) + "."
                    } else {
                        alert.informativeText = "You have underallocated for \(containerType) preplans. Please adjust the allocation amount for \(containerType) preplans by " + String(abs(difference)) + "."
                    }

                    alert.runModal()
                    didFailAllocationCheck = true
                    return
                }
                
                index += 1
            }

            assignS2(containers: emptyBUSs2, oneKey: "oneBUSs2", hlcKey: "hlcBUSs2", ymlKey: "ymlBUSs2")
            assignS4(containers: emptyBUSs4, oneKey: "oneBUSs4", hlcKey: "hlcBUSs4", ymlKey: "ymlBUSs4")
            assignC4(containers: emptyBUSc4, oneKey: "oneBUSc4", hlcKey: "hlcBUSc4", ymlKey: "ymlBUSc4")
            assignC5(containers: emptyBUSc5, oneKey: "oneBUSc5", hlcKey: "hlcBUSc5", ymlKey: "ymlBUSc5")
            
            assignS2(containers: emptyNGBs2, oneKey: "oneNGBs2", hlcKey: "hlcNGBs2", ymlKey: "ymlNGBs2")
            assignS4(containers: emptyNGBs4, oneKey: "oneNGBs4", hlcKey: "hlcNGBs4", ymlKey: "ymlNGBs4")
            assignC4(containers: emptyNGBc4, oneKey: "oneNGBc4", hlcKey: "hlcNGBc4", ymlKey: "ymlNGBc4")
            assignC5(containers: emptyNGBc5, oneKey: "oneNGBc5", hlcKey: "hlcNGBc5", ymlKey: "ymlNGBc5")
            
            assignS2(containers: emptySHGs2, oneKey: "oneSHGs2", hlcKey: "hlcSHGs2", ymlKey: "ymlSHGs2")
            assignS4(containers: emptySHGs4, oneKey: "oneSHGs4", hlcKey: "hlcSHGs4", ymlKey: "ymlSHGs4")
            assignC4(containers: emptySHGc4, oneKey: "oneSHGc4", hlcKey: "hlcSHGc4", ymlKey: "ymlSHGc4")
            assignC5(containers: emptySHGc5, oneKey: "oneSHGc5", hlcKey: "hlcSHGc5", ymlKey: "ymlSHGc5")
            
            assignS2(containers: emptyTKYs2, oneKey: "oneTKYs2", hlcKey: "hlcTKYs2", ymlKey: "ymlTKYs2")
            assignS4(containers: emptyTKYs4, oneKey: "oneTKYs4", hlcKey: "hlcTKYs4", ymlKey: "ymlTKYs4")
            assignC4(containers: emptyTKYc4, oneKey: "oneTKYc4", hlcKey: "hlcTKYc4", ymlKey: "ymlTKYc4")
            assignC5(containers: emptyTKYc5, oneKey: "oneTKYc5", hlcKey: "hlcTKYc5", ymlKey: "ymlTKYc5")

        }
        
        emptyBaplieContentWithOperators = emptyBaplieContentWithOperators.replacingOccurrences(of: "\'\n\'\n", with: "\'\n")
        
        findContainers()
        sortContainersByStatus()
        sortEmptyContainersBySize()
        sortContainerSizesByPort()
        combineAllocations()
        assignOperators()
        
        fullBaplieContent += otherBaplieContent

        if didFailAllocationCheck {
            return (originalBaplieContent, "")
        }
        
        return (fullBaplieContent, emptyBaplieContentWithOperators)
    }
    
    func reset() {
        fullBaplieContent = ""
        emptyBaplieContentWithOperators = ""
        otherBaplieContent = ""
        otherBaplieContentCount = 0
        vesselOperator = ""
        previousOperator = ""
        header = ""
        combinedAllocations = [String: Int]()
    }
    
    
}
