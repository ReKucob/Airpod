//
//  FirebaseController.swift
//  Airpod
//
//  Created by Burns on 3/11/19.
//  Copyright © 2019 Group 6. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class FirebaseController: NSObject, DatabaseProtocol {
    
    var listeners = MulticastDelegate<DatabaseListener>()
    var authController: Auth
    var database:Firestore
    var officerRef: CollectionReference?
    var AQISensorDataList:[officerData]
    
    override init() {
        authController = Auth.auth()
        database = Firestore.firestore()
        AQISensorDataList = [officerData]()
        
        super.init()
        
        authController.signInAnonymously(){(authResult,error) in
            guard authResult != nil else{
                fatalError("Firebase athentication failes")
            }
            self.setUpListeners()
        }
    }
    
    //MARK:  - SETUP A LISTENER FOR DATABASE TO MONITOR OFFICER DATA
    func setUpListeners(){
        officerRef = database.collection("office1")
        officerRef?.addSnapshotListener{(querySnapshot,error) in
            guard (querySnapshot?.documents) != nil
                       else
                       {
                       print("Error fetching documents:\(error!)")
                           return
            }
            self.parseOfficerSnapshot(snapshot: querySnapshot!)
        }
    }
    
    //MARK: -  START TO GET DATA FROM DATABASE
    func parseOfficerSnapshot(snapshot: QuerySnapshot)
    {
        snapshot.documentChanges.forEach{
            change in
            
            let documentRef = change.document.documentID
            if (documentRef != "Default")
            {
                let AQIData = change.document.data()["aqi"] as! Int
                let temperatureData = change.document.data()["temp"] as! Int
                let timestampData = change.document.data()["timestamp"] as! Double
                let colourTempData = change.document.data()["colour_temp"] as! Int
                print(documentRef)
                
                
                if change.type == .added{
                    print("New sensor data: \(change.document.data())")
                    let newSensorData = officerData(newTemperature: temperatureData, newAQI: AQIData, newTime: timestampData, newColourTemp: colourTempData)
                    
                    AQISensorDataList.append(newSensorData)
                }
                
                if change.type == .modified{
                    print("New sensor Data: \(change.document.data())")
                        let newSensorData = officerData(newTemperature: temperatureData, newAQI: AQIData, newTime: timestampData, newColourTemp: colourTempData)

                    AQISensorDataList.append(newSensorData)

                }
            }
        }
        listeners.invoke{(listener) in
        if listener.listenerType == ListenerType.all || listener.listenerType == ListenerType.officer1{
            listener.onOfficer1Change(change: .update, OfficerDatas: AQISensorDataList)
            }
    }
    }
    
    
    //MARK: -  ADD AND REMOVE LISTENER FOR DATABASE
    func addListener(listener: DatabaseListener) {
        listeners.addDelegate(listener)
        
        if listener.listenerType == ListenerType.all || listener.listenerType == ListenerType.officer1{
        listener.onOfficer1Change(change: .update, OfficerDatas: AQISensorDataList)
        }
     
    }
    
    func removeListener(listener: DatabaseListener) {
        listeners.removeDelegate(listener)
    }
    
    
}
