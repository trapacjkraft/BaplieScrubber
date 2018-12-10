//
//  EC1Allocator.swift
//  BaplieScrubber
//
//  Created by Joshua Kraft on 12/10/18.
//  Copyright © 2018 Joshua Kraft. All rights reserved.
//

import Cocoa

class EC1Allocator: NSObject {
    
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
        
        
        var emptyBUSs2 = [BaplieContainer]()
        var emptyBUSs4 = [BaplieContainer]()
        var emptyBUSc4 = [BaplieContainer]()
        var emptyBUSc5 = [BaplieContainer]()
        
        var emptyKBEs2 = [BaplieContainer]()
        var emptyKBEs4 = [BaplieContainer]()
        var emptyKBEc4 = [BaplieContainer]()
        var emptyKBEc5 = [BaplieContainer]()
        
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
                case "JPUKB":
                    emptyKBEs2.append(container)
                case "CNNGB":
                    emptyNGBs2.append(container)
                case "CNSHA":
                    emptySHGs2.append(container)
                case "JPTYO":
                    emptyTKYs2.append(container)
                    
                default:
                    break //Should not be reached if Baplie is properly formed. Only standard mtys to ports should be left ZZ.
                }
            }
            
            for container in emptyS4 {
                
                guard !emptyS4.isEmpty else { return }
                
                switch container.dischargePort {
                    
                case "KRPUS":
                    emptyBUSs4.append(container)
                case "JPUKB":
                    emptyKBEs4.append(container)
                case "CNNGB":
                    emptyNGBs4.append(container)
                case "CNSHA":
                    emptySHGs4.append(container)
                case "JPTYO":
                    emptyTKYs4.append(container)
                    
                default:
                    break //Should not be reached if Baplie is properly formed. Only standard mtys to ports should be left ZZ.
                }
            }
            
            for container in emptyC4 {
                
                guard !emptyC4.isEmpty else { return }
                
                switch container.dischargePort {
                    
                case "KRPUS":
                    emptyBUSc4.append(container)
                case "JPUKB":
                    emptyKBEc4.append(container)
                case "CNNGB":
                    emptyNGBc4.append(container)
                case "CNSHA":
                    emptySHGc4.append(container)
                case "JPTYO":
                    emptyTKYc4.append(container)
                    
                default:
                    break //Should not be reached if Baplie is properly formed. Only standard mtys to ports should be left ZZ.
                }
            }
            
            for container in emptyC5 {
                
                guard !emptyC5.isEmpty else { return }
                
                switch container.dischargePort {
                    
                case "KRPUS":
                    emptyBUSc5.append(container)
                case "JPUKB":
                    emptyKBEc5.append(container)
                case "CNNGB":
                    emptyNGBc5.append(container)
                case "CNSHA":
                    emptySHGc5.append(container)
                case "JPTYO":
                    emptyTKYc5.append(container)
                    
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
            
            assignS2(containers: emptyBUSs2, oneKey: "oneBUSs2", hlcKey: "hlcBUSs2", ymlKey: "ymlBUSs2")
            assignS4(containers: emptyBUSs4, oneKey: "oneBUSs4", hlcKey: "hlcBUSs4", ymlKey: "ymlBUSs4")
            assignC4(containers: emptyBUSc4, oneKey: "oneBUSc4", hlcKey: "hlcBUSc4", ymlKey: "ymlBUSc4")
            assignC5(containers: emptyBUSc5, oneKey: "oneBUSc5", hlcKey: "hlcBUSc5", ymlKey: "ymlBUSc5")

            assignS2(containers: emptyKBEs2, oneKey: "oneKBEs2", hlcKey: "hlcKBEs2", ymlKey: "ymlKBEs2")
            assignS4(containers: emptyKBEs4, oneKey: "oneKBEs4", hlcKey: "hlcKBEs4", ymlKey: "ymlKBEs4")
            assignC4(containers: emptyKBEc4, oneKey: "oneKBEc4", hlcKey: "hlcKBEc4", ymlKey: "ymlKBEc4")
            assignC5(containers: emptyKBEc5, oneKey: "oneKBEc5", hlcKey: "hlcKBEc5", ymlKey: "ymlKBEc5")

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
