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
    var officer1Ref: CollectionReference?
    var officer2Ref: CollectionReference?
    var warehouse1Ref: CollectionReference?
    var officer1SensorDataList:[officerData]
    var officer2SensorDataList:[officerData]
    var warehouse1SensorDataList:[officerData]
    
    override init() {
        authController = Auth.auth()
        database = Firestore.firestore()
        officer1SensorDataList = [officerData]()
        officer2SensorDataList = [officerData]()
        warehouse1SensorDataList = [officerData]()
        
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
        officer1Ref = database.collection("office1")
        officer1Ref?.addSnapshotListener{(querySnapshot,error) in
            guard (querySnapshot?.documents) != nil
                       else
                       {
                       print("Error fetching documents:\(error!)")
                           return
            }
            self.parseOfficer1Snapshot(snapshot: querySnapshot!)
        }
        
        officer2Ref = database.collection("office2")
        officer2Ref?.addSnapshotListener{(querySnapshot,error) in
            guard (querySnapshot?.documents) != nil
                       else
                       {
                       print("Error fetching documents:\(error!)")
                           return
            }
            self.parseOfficer2Snapshot(snapshot: querySnapshot!)
        }
        
        warehouse1Ref = database.collection("warehouse1")
        warehouse1Ref?.addSnapshotListener{(querySnapshot,error) in
            guard (querySnapshot?.documents) != nil
                       else
                       {
                       print("Error fetching documents:\(error!)")
                           return
            }
            self.parseWarehouse1Snapshot(snapshot: querySnapshot!)
        }
        
    }
    
    //MARK: -  START TO GET DATA FROM DATABASE: collection "office1"
    func parseOfficer1Snapshot(snapshot: QuerySnapshot)
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
                    print("office1Add Data: \(change.document.data())")
                    let newSensorData = officerData(newTemperature: temperatureData, newAQI: AQIData, newTime: timestampData, newColourTemp: colourTempData)
                    
                    officer1SensorDataList.append(newSensorData)
                }
                
                if change.type == .modified{
                    print("office1Edit Data: \(change.document.data())")
                        let newSensorData = officerData(newTemperature: temperatureData, newAQI: AQIData, newTime: timestampData, newColourTemp: colourTempData)

                    officer1SensorDataList.append(newSensorData)

                }
            }
        }
        listeners.invoke{(listener) in
        if listener.listenerType == ListenerType.officer1{
            listener.onOfficer1Change(change: .update, OfficerDatas: officer1SensorDataList)
            }
    }
    }
    
    //MARK: -  START TO GET DATA FROM DATABASE: collection "office2"
    func parseOfficer2Snapshot(snapshot: QuerySnapshot)
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
                       print("office2ADD Data: \(change.document.data())")
                       let newSensorData = officerData(newTemperature: temperatureData, newAQI: AQIData, newTime: timestampData, newColourTemp: colourTempData)
                       
                       officer2SensorDataList.append(newSensorData)
                   }
                   
                   if change.type == .modified{
                       print("office2Edit Data: \(change.document.data())")
                           let newSensorData = officerData(newTemperature: temperatureData, newAQI: AQIData, newTime: timestampData, newColourTemp: colourTempData)

                       officer2SensorDataList.append(newSensorData)

                   }
               }
           }
           listeners.invoke{(listener) in
           if listener.listenerType == ListenerType.officer2{
               listener.onOfficer2Change(change: .update, OfficerDatas: officer2SensorDataList)
               }
       }
       }
    
    //MARK: -  START TO GET DATA FROM DATABASE: collection "warehouse1"
    func parseWarehouse1Snapshot(snapshot: QuerySnapshot)
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
                       print("warehouseADD data: \(change.document.data())")
                       let newSensorData = officerData(newTemperature: temperatureData, newAQI: AQIData, newTime: timestampData, newColourTemp: colourTempData)
                       
                       warehouse1SensorDataList.append(newSensorData)
                   }
                   
                   if change.type == .modified{
                       print("warehouserEdit data: \(change.document.data())")
                           let newSensorData = officerData(newTemperature: temperatureData, newAQI: AQIData, newTime: timestampData, newColourTemp: colourTempData)

                       warehouse1SensorDataList.append(newSensorData)

                   }
               }
           }
           listeners.invoke{(listener) in
           if listener.listenerType == ListenerType.warehouse1{
               listener.onWarehouse1Change(change: .update, OfficerDatas: warehouse1SensorDataList)
               }
       }
       }
    
    
    //MARK: -  ADD AND REMOVE LISTENER FOR DATABASE
    func addListener(listener: DatabaseListener) {
        listeners.addDelegate(listener)
        
        if listener.listenerType == ListenerType.officer1{
        listener.onOfficer1Change(change: .update, OfficerDatas: officer1SensorDataList)
        }
        
        if listener.listenerType == ListenerType.officer2{
        listener.onOfficer2Change(change: .update, OfficerDatas: officer2SensorDataList)
        }
        
        if listener.listenerType == ListenerType.warehouse1{
        listener.onWarehouse1Change(change: .update, OfficerDatas: warehouse1SensorDataList)
        }
     
    }
    
    func removeListener(listener: DatabaseListener) {
        listeners.removeDelegate(listener)
    }
    
    
}
