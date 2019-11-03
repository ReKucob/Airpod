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
    
    init (newTemperature: Double, newAQI: Double){
        self.temperature = newTemperature
        self.AQI = newAQI
    }
}
