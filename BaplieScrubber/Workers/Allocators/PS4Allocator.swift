//
//  PS4Allocator.swift
//  BaplieScrubber
//
//  Created by Joshua Kraft on 12/11/18.
//  Copyright © 2018 Joshua Kraft. All rights reserved.
//

import Cocoa

class PS4Allocator: NSObject {
    
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
        "S4":"4300",
        "C4":"4500",
        "C5":"9500"
    ]
    
    var vesselOperator = ""
    var previousOperator = ""
    var header = ""
    var combinedAllocations = [String: Int]()
    var fullBaplieContent = String()
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
                        break //Should not be reached.
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
                        break //Should not be reached.
                    }
                }
                
            case "ONE":
                
                for container in emptyPreplans {
                    
                    switch container.containerISO {
                        
                    case oneISOcodes["S2"]:
                        emptyS2.append(container)
                    case oneISOcodes["S4"]:
                        emptyS4.append(container)
                    case oneISOcodes["C4"]:
                        emptyC4.append(container)
                    case oneISOcodes["C5"]:
                        emptyC5.append(container)
                    default:
                        break //Should not be reached.
                    }
                }
                
                
            default:
                break //Reached if vessel operator line is malformed. Program needs to know vessel operator to decide which ISO codes to use. Should not be reached considering export features are for TraPac-generated Baplies.
            }
            
        }
        
        
        var emptyHKGs2 = [BaplieContainer]()
        var emptyHKGs4 = [BaplieContainer]()
        var emptyHKGc4 = [BaplieContainer]()
        var emptyHKGc5 = [BaplieContainer]()
        
        var emptyKAOs2 = [BaplieContainer]()
        var emptyKAOs4 = [BaplieContainer]()
        var emptyKAOc4 = [BaplieContainer]()
        var emptyKAOc5 = [BaplieContainer]()
        
        var emptyKEEs2 = [BaplieContainer]()
        var emptyKEEs4 = [BaplieContainer]()
        var emptyKEEc4 = [BaplieContainer]()
        var emptyKEEc5 = [BaplieContainer]()
        
        var emptyYTIs2 = [BaplieContainer]()
        var emptyYTIs4 = [BaplieContainer]()
        var emptyYTIc4 = [BaplieContainer]()
        var emptyYTIc5 = [BaplieContainer]()

        func sortContainerSizesByPort() {
            
            for container in emptyS2 {
                
                guard !emptyS2.isEmpty else { return }
                
                switch container.dischargePort {
                    
                case "HKHKG":
                    emptyHKGs2.append(container)
                case "TWKHH":
                    emptyKAOs2.append(container)
                case "TWKEL":
                    emptyKEEs2.append(container)
                case "CNYTN":
                    emptyYTIs2.append(container)
                    
                default:
                    break //Should not be reached if Baplie is properly formed. Only standard mtys to ports should be left ZZ.
                }
            }
            
            for container in emptyS4 {
                
                guard !emptyS4.isEmpty else { return }
                
                switch container.dischargePort {
                    
                case "HKHKG":
                    emptyHKGs4.append(container)
                case "TWKHH":
                    emptyKAOs4.append(container)
                case "TWKEL":
                    emptyKEEs4.append(container)
                case "CNYTN":
                    emptyYTIs4.append(container)
                    
                default:
                    break //Should not be reached if Baplie is properly formed. Only standard mtys to ports should be left ZZ.
                }
            }
            
            for container in emptyC4 {
                
                guard !emptyC4.isEmpty else { return }
                
                switch container.dischargePort {
                    
                case "HKHKG":
                    emptyHKGc4.append(container)
                case "TWKHH":
                    emptyKAOc4.append(container)
                case "TWKEL":
                    emptyKEEc4.append(container)
                case "CNYTN":
                    emptyYTIc4.append(container)
                    
                default:
                    break //Should not be reached if Baplie is properly formed. Only standard mtys to ports should be left ZZ.
                }
            }
            
            for container in emptyC5 {
                
                guard !emptyC5.isEmpty else { return }
                
                switch container.dischargePort {
                    
                case "HKHKG":
                    emptyHKGc5.append(container)
                case "TWKHH":
                    emptyKAOc5.append(container)
                case "TWKEL":
                    emptyKEEc5.append(container)
                case "CNYTN":
                    emptyYTIc5.append(container)
                    
                default:
                    break //Should not be reached if Baplie is properly formed. Only standard mtys to ports should be left ZZ.
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
            
            var allocSum = 0
            let emptyCount = emptyPreplans.count
            
            for (_, alloc) in combinedAllocations {
                allocSum += alloc
            }
            
            guard allocSum == emptyCount else {
                let alert = NSAlert()
                alert.messageText = "Allocation Error!"
                alert.informativeText = "Sum of allocations does not match sum of empty preplans on the Baplie. Please re-enter allocations."
                alert.runModal()
                return
            }
            
            assignS2(containers: emptyHKGs2, oneKey: "oneHKGs2", hlcKey: "hlcHKGs2", ymlKey: "ymlHKGs2")
            assignS4(containers: emptyHKGs4, oneKey: "oneHKGs4", hlcKey: "hlcHKGs4", ymlKey: "ymlHKGs4")
            assignC4(containers: emptyHKGc4, oneKey: "oneHKGc4", hlcKey: "hlcHKGc4", ymlKey: "ymlHKGc4")
            assignC5(containers: emptyHKGc5, oneKey: "oneHKGc5", hlcKey: "hlcHKGc5", ymlKey: "ymlHKGc5")
            
            assignS2(containers: emptyKAOs2, oneKey: "oneKAOs2", hlcKey: "hlcKAOs2", ymlKey: "ymlKAOs2")
            assignS4(containers: emptyKAOs4, oneKey: "oneKAOs4", hlcKey: "hlcKAOs4", ymlKey: "ymlKAOs4")
            assignC4(containers: emptyKAOc4, oneKey: "oneKAOc4", hlcKey: "hlcKAOc4", ymlKey: "ymlKAOc4")
            assignC5(containers: emptyKAOc5, oneKey: "oneKAOc5", hlcKey: "hlcKAOc5", ymlKey: "ymlKAOc5")
            
            assignS2(containers: emptyKEEs2, oneKey: "oneKEEs2", hlcKey: "hlcKEEs2", ymlKey: "ymlKEEs2")
            assignS4(containers: emptyKEEs4, oneKey: "oneKEEs4", hlcKey: "hlcKEEs4", ymlKey: "ymlKEEs4")
            assignC4(containers: emptyKEEc4, oneKey: "oneKEEc4", hlcKey: "hlcKEEc4", ymlKey: "ymlKEEc4")
            assignC5(containers: emptyKEEc5, oneKey: "oneKEEc5", hlcKey: "hlcKEEc5", ymlKey: "ymlKEEc5")
            
            assignS2(containers: emptyYTIs2, oneKey: "oneYTIs2", hlcKey: "hlcYTIs2", ymlKey: "ymlYTIs2")
            assignS4(containers: emptyYTIs4, oneKey: "oneYTIs4", hlcKey: "hlcYTIs4", ymlKey: "ymlYTIs4")
            assignC4(containers: emptyYTIc4, oneKey: "oneYTIc4", hlcKey: "hlcYTIc4", ymlKey: "ymlYTIc4")
            assignC5(containers: emptyYTIc5, oneKey: "oneYTIc5", hlcKey: "hlcYTIc5", ymlKey: "ymlYTIc5")

        }
        
        emptyBaplieContentWithOperators = emptyBaplieContentWithOperators.replacingOccurrences(of: "\'\n\'\n", with: "\'\n")
        
        findContainers()
        sortContainersByStatus()
        sortEmptyContainersBySize()
        sortContainerSizesByPort()
        combineAllocations()
        assignOperators()
        
        
        
        
        return (fullBaplieContent, emptyBaplieContentWithOperators)
    }
    
    func reset() {
        fullBaplieContent = ""
        emptyBaplieContentWithOperators = ""
        vesselOperator = ""
        previousOperator = ""
        header = ""
        combinedAllocations = [String: Int]()
    }
    
    
    
}
