//
//  BaplieContainer.swift
//  BaplieScrubber
//
//  Created by Joshua Kraft on 11/6/18.
//  Copyright © 2018 Joshua Kraft. All rights reserved.
//

import Cocoa

class BaplieContainer: NSObject {

    var containerRecordString: String
    var stowagePosition: String
    var weight: String
    var loadPort: String
    var dischargePort: String
    var containerNumber: String
    var containerISO: String
    var containerSize: String
    var isFull: Bool
    var isPreplan: Bool
    var shippingLine: String
    
    init(container: String) {
        
        self.containerRecordString = container
        self.stowagePosition = String()
        self.weight = String()
        self.loadPort = String()
        self.dischargePort = String()
        self.containerNumber = String()
        self.containerISO = String()
        self.containerSize = String()
        self.isFull = Bool()
        self.isPreplan = Bool()
        self.shippingLine = String()

        var stowagePositionString = String()
        var weightString = String()
        var loadPortString = String()
        var dischargePortString = String()
        var containerInformationString = String()
        var shippingLineString = String()
        
        func getContainerInfo() {
            var baplieRecordArray = self.containerRecordString.components(separatedBy: "'") //Separate container string into array with one line per line break (')
            
            var index = 0
            
            for _ in baplieRecordArray { //Trim extra whitepace, newlines, then replace quotes for line breaks
                baplieRecordArray[index] = baplieRecordArray[index].trimmingCharacters(in: .whitespacesAndNewlines)
                baplieRecordArray[index].append("'\n")
                index += 1
            }
            
            for line in baplieRecordArray {
                if line.contains("LOC+147") {
                    stowagePositionString = line
                    stowagePositionString = stowagePositionString.components(separatedBy: "LOC+147+")[1]
                    self.stowagePosition = stowagePositionString.components(separatedBy: "::")[0]
                }
                else if line.contains("MEA+VGM++") {
                    
                    weightString = line
                    weightString = weightString.components(separatedBy: ":")[1]
                    weightString.removeLast(2)
                    
                    if weightString.count > 4 {
                        weightString.removeLast((weightString.count - 3))
                        let decimalIndex = String.Index(encodedOffset: 2)
                        weightString.insert(".", at: (decimalIndex))
                        self.weight = weightString
                    } else {
                        weightString.removeLast((weightString.count - 2))
                        let decimalIndex = String.Index(encodedOffset: 1)
                        weightString.insert(".", at: (decimalIndex))
                        self.weight = weightString

                    }
                }
                else if line.contains("LOC+9") {
                    loadPortString = line
                    loadPortString = loadPortString.components(separatedBy: "9+")[1]
                    loadPortString.removeLast(2)
                    self.loadPort = loadPortString
                }
                else if line.contains("LOC+11") {
                    dischargePortString = line
                    dischargePortString = dischargePortString.components(separatedBy: "11+")[1]
                    dischargePortString.removeLast(2)
                    self.dischargePort = dischargePortString
                }
                else if line.contains("EQD+CN+") {
                    containerInformationString = line
                    self.containerNumber = containerInformationString.components(separatedBy: "+")[2]
                    self.containerNumber = self.containerNumber.trimmingCharacters(in: .whitespaces)
                    
                    if containerNumber.contains("PPLN") {
                        self.isPreplan = true
                    } else { self.isPreplan = false }
                    
                    self.containerISO = containerInformationString.components(separatedBy: "+")[3]
                    
                    if containerInformationString.components(separatedBy: "+++")[1].contains("4") {
                        self.isFull = false
                    } else {
                        self.isFull = true
                    }
                }
                else if line.contains("NAD+CA") {
                    shippingLineString = line
                    self.shippingLine = shippingLineString.components(separatedBy: "+")[2].components(separatedBy: ":")[0]
                }
            }

        }
        
        
        super.init()
        getContainerInfo()
        
    }
    
}
