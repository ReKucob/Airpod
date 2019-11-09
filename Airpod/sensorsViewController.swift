//
//  sensorsViewController.swift
//  Airpod
//
//  Created by Burns on 9/11/19.
//  Copyright © 2019 Group 6. All rights reserved.
//

import UIKit

class sensorsViewController: UIViewController,DatabaseListener {
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var listenerType = ListenerType.all
    
    func onOfficer1Change(change: DatabaseChange, OfficerDatas: [officerData]) {
        
    }
    
    func onOfficer2Change(change: DatabaseChange, OfficerDatas: [officerData]) {
    
    }
    
    func onWarehouse1Change(change: DatabaseChange, OfficerDatas: [officerData]) {
        
       }
    

}
