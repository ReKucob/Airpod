//
//  officerData.swift
//  Airpod
//
//  Created by Burns on 3/11/19.
//  Copyright © 2019 Group 6. All rights reserved.
//

import UIKit

class officerData: NSObject {
    var temperature: Double?
    var AQI: Double?
    var timestamp: Int?
    
    init (newTemperature: Double, newAQI: Double, newTime: Int){
        self.temperature = newTemperature
        self.AQI = newAQI
        self.timestamp = newTime
    }
}
