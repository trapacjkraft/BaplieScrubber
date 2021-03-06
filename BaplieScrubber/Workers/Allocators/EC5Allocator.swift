//
//  EC5Allocator.swift
//  BaplieScrubber
//
//  Created by Joshua Kraft on 12/21/18.
//  Copyright © 2018 Joshua Kraft. All rights reserved.
//

import Cocoa

class EC5Allocator: NSObject {
    
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
        
        
        var emptyCMBs2 = [BaplieContainer]()
        var emptyCMBs4 = [BaplieContainer]()
        var emptyCMBc4 = [BaplieContainer]()
        var emptyCMBc5 = [BaplieContainer]()
        
        var emptyHALs2 = [BaplieContainer]()
        var emptyHALs4 = [BaplieContainer]()
        var emptyHALc4 = [BaplieContainer]()
        var emptyHALc5 = [BaplieContainer]()
        
        var emptyHCMs2 = [BaplieContainer]()
        var emptyHCMs4 = [BaplieContainer]()
        var emptyHCMc4 = [BaplieContainer]()
        var emptyHCMc5 = [BaplieContainer]()
        
        var emptyJEBs2 = [BaplieContainer]()
        var emptyJEBs4 = [BaplieContainer]()
        var emptyJEBc4 = [BaplieContainer]()
        var emptyJEBc5 = [BaplieContainer]()
        
        var emptyLLLs2 = [BaplieContainer]()
        var emptyLLLs4 = [BaplieContainer]()
        var emptyLLLc4 = [BaplieContainer]()
        var emptyLLLc5 = [BaplieContainer]()
        
        var emptySPRs2 = [BaplieContainer]()
        var emptySPRs4 = [BaplieContainer]()
        var emptySPRc4 = [BaplieContainer]()
        var emptySPRc5 = [BaplieContainer]()
        
        func sortContainerSizesByPort() {
            
            for container in emptyS2 {
                
                guard !emptyS2.isEmpty else { return }
                
                switch container.dischargePort {
                    
                case "LKCMB":
                    emptyCMBs2.append(container)
                case "CAHAL":
                    emptyHALs2.append(container)
                case "VNVUT":
                    emptyHCMs2.append(container)
                case "AEJEA":
                    emptyJEBs2.append(container)
                case "THLCH":
                    emptyLLLs2.append(container)
                case "SGSIN":
                    emptySPRs2.append(container)
                    
                default:
                    otherBaplieContent += container.containerRecordString
                    otherBaplieContentCount += 1
                }
            }
            
            for container in emptyS4 {
                
                guard !emptyS4.isEmpty else { return }
                
                switch container.dischargePort {
                    
                case "LKCMB":
                    emptyCMBs4.append(container)
                case "CAHAL":
                    emptyHALs4.append(container)
                case "VNVUT":
                    emptyHCMs4.append(container)
                case "AEJEA":
                    emptyJEBs4.append(container)
                case "THLCH":
                    emptyLLLs4.append(container)
                case "SGSIN":
                    emptySPRs4.append(container)
                    
                default:
                    otherBaplieContent += container.containerRecordString
                    otherBaplieContentCount += 1
                }
            }
            
            for container in emptyC4 {
                
                guard !emptyC4.isEmpty else { return }
                
                switch container.dischargePort {
                    
                case "LKCMB":
                    emptyCMBc4.append(container)
                case "CAHAL":
                    emptyHALc4.append(container)
                case "VNVUT":
                    emptyHCMc4.append(container)
                case "AEJEA":
                    emptyJEBc4.append(container)
                case "THLCH":
                    emptyLLLc4.append(container)
                case "SGSIN":
                    emptySPRc4.append(container)
                    
                default:
                    otherBaplieContent += container.containerRecordString
                    otherBaplieContentCount += 1
                }
            }
            
            for container in emptyC5 {
                
                guard !emptyC5.isEmpty else { return }
                
                switch container.dischargePort {
                    
                case "LKCMB":
                    emptyCMBc5.append(container)
                case "CAHAL":
                    emptyHALc5.append(container)
                case "VNVUT":
                    emptyHCMc5.append(container)
                case "AEJEA":
                    emptyJEBc5.append(container)
                case "THLCH":
                    emptyLLLc5.append(container)
                case "SGSIN":
                    emptySPRc5.append(container)
                    
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
            
            var allocSum = 0
            let emptyCount = emptyPreplans.count - otherBaplieContentCount
            
            
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
            
            assignS2(containers: emptyCMBs2, oneKey: "oneCMBs2", hlcKey: "hlcCMBs2", ymlKey: "ymlCMBs2")
            assignS4(containers: emptyCMBs4, oneKey: "oneCMBs4", hlcKey: "hlcCMBs4", ymlKey: "ymlCMBs4")
            assignC4(containers: emptyCMBc4, oneKey: "oneCMBc4", hlcKey: "hlcCMBc4", ymlKey: "ymlCMBc4")
            assignC5(containers: emptyCMBc5, oneKey: "oneCMBc5", hlcKey: "hlcCMBc5", ymlKey: "ymlCMBc5")
            
            assignS2(containers: emptyHALs2, oneKey: "oneHALs2", hlcKey: "hlcHALs2", ymlKey: "ymlHALs2")
            assignS4(containers: emptyHALs4, oneKey: "oneHALs4", hlcKey: "hlcHALs4", ymlKey: "ymlHALs4")
            assignC4(containers: emptyHALc4, oneKey: "oneHALc4", hlcKey: "hlcHALc4", ymlKey: "ymlHALc4")
            assignC5(containers: emptyHALc5, oneKey: "oneHALc5", hlcKey: "hlcHALc5", ymlKey: "ymlHALc5")
            
            assignS2(containers: emptyHCMs2, oneKey: "oneHCMs2", hlcKey: "hlcHCMs2", ymlKey: "ymlHCMs2")
            assignS4(containers: emptyHCMs4, oneKey: "oneHCMs4", hlcKey: "hlcHCMs4", ymlKey: "ymlHCMs4")
            assignC4(containers: emptyHCMc4, oneKey: "oneHCMc4", hlcKey: "hlcHCMc4", ymlKey: "ymlHCMc4")
            assignC5(containers: emptyHCMc5, oneKey: "oneHCMc5", hlcKey: "hlcHCMc5", ymlKey: "ymlHCMc5")
            
            assignS2(containers: emptyJEBs2, oneKey: "oneJEBs2", hlcKey: "hlcJEBs2", ymlKey: "ymlJEBs2")
            assignS4(containers: emptyJEBs4, oneKey: "oneJEBs4", hlcKey: "hlcJEBs4", ymlKey: "ymlJEBs4")
            assignC4(containers: emptyJEBc4, oneKey: "oneJEBc4", hlcKey: "hlcJEBc4", ymlKey: "ymlJEBc4")
            assignC5(containers: emptyJEBc5, oneKey: "oneJEBc5", hlcKey: "hlcJEBc5", ymlKey: "ymlJEBc5")
            
            assignS2(containers: emptyLLLs2, oneKey: "oneLLLs2", hlcKey: "hlcLLLs2", ymlKey: "ymlLLLs2")
            assignS4(containers: emptyLLLs4, oneKey: "oneLLLs4", hlcKey: "hlcLLLs4", ymlKey: "ymlLLLs4")
            assignC4(containers: emptyLLLc4, oneKey: "oneLLLc4", hlcKey: "hlcLLLc4", ymlKey: "ymlLLLc4")
            assignC5(containers: emptyLLLc5, oneKey: "oneLLLc5", hlcKey: "hlcLLLc5", ymlKey: "ymlLLLc5")
            
            assignS2(containers: emptySPRs2, oneKey: "oneSPRs2", hlcKey: "hlcSPRs2", ymlKey: "ymlSPRs2")
            assignS4(containers: emptySPRs4, oneKey: "oneSPRs4", hlcKey: "hlcSPRs4", ymlKey: "ymlSPRs4")
            assignC4(containers: emptySPRc4, oneKey: "oneSPRc4", hlcKey: "hlcSPRc4", ymlKey: "ymlSPRc4")
            assignC5(containers: emptySPRc5, oneKey: "oneSPRc5", hlcKey: "hlcSPRc5", ymlKey: "ymlSPRc5")
            
            
        }
        
        emptyBaplieContentWithOperators = emptyBaplieContentWithOperators.replacingOccurrences(of: "\'\n\'\n", with: "\'\n")
        fullBaplieContent += otherBaplieContent
        
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
        otherBaplieContent = ""
        otherBaplieContentCount = 0
        vesselOperator = ""
        previousOperator = ""
        header = ""
        combinedAllocations = [String: Int]()
    }
    
    
    
}
