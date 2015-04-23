//
//  Favorite.swift
//  SwiftConverxns
//
//  Created by Adam Cherochak on 4/20/15.
//  Copyright (c) 2015 Adam Cherochak. All rights reserved.
//  2015-04-20-1054 wk3
//

import Foundation

class Favorite: NSObject, NSCoding {
    var conversionType: String
    var inputValue: Double
    var inputUnits: String
    var outputValue: Double
    var outputUnits: String
    
    required init(conversionType: String, inputValue: Double, inputUnits: String, outputValue: Double, outputUnits: String) {
        self.conversionType = conversionType
        self.inputValue = inputValue
        self.inputUnits = inputUnits
        self.outputValue = outputValue
        self.outputUnits = outputUnits
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        self.conversionType = aDecoder.decodeObjectForKey("conversionType") as! String
        self.inputValue = aDecoder.decodeDoubleForKey("inputValue")
        self.inputUnits = aDecoder.decodeObjectForKey("inputUnits")as! String
        self.outputValue = aDecoder.decodeDoubleForKey("outputValue")
        self.outputUnits = aDecoder.decodeObjectForKey("outputUnits") as! String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.conversionType, forKey: "conversionType")
        aCoder.encodeDouble(self.inputValue, forKey: "inputValue")
        aCoder.encodeObject(self.inputUnits, forKey: "inputUnits")
        aCoder.encodeDouble(self.outputValue, forKey: "outputValue")
        aCoder.encodeObject(self.outputUnits, forKey: "outputUnits")
    }
}//END class Favorite