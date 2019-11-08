//
//  officerData.swift
//  Airpod
//
//  Created by Burns on 3/11/19.
//  Copyright © 2019 Group 6. All rights reserved.
//

import UIKit

class officerData: NSObject {
    var temperature: Int?
    var AQI: Int?
    var timestamp: Double?
    var colourTemperature: Int?
    
    init (newTemperature: Int, newAQI: Int, newTime: Double, newColourTemp: Int){
        self.temperature = newTemperature
        self.AQI = newAQI
        self.timestamp = newTime
        self.colourTemperature = newColourTemp
    }
}
