//
//  ViewController.swift
//  Airpod
//
//  Created by Burns on 15/10/19.
//  Copyright © 2019 Group 6. All rights reserved.
//

import UIKit
import UserNotifications
import Firebase

class ViewController: UIViewController, DatabaseListener {
    
     var officerList: [officerData] = []
     weak var firebaseController: DatabaseProtocol?
     var listenerType = ListenerType.officer1
     var realtimeDB = Database.database().reference()
   
    @IBAction func handleSelector(_ sender: UIButton) {
        locationButtons.forEach{ (button) in
            UIView.animate(withDuration: 0.3, animations:{
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            } )
            
        }
    }
    @IBOutlet var locationButtons: [UIButton]!
    
    enum Locations: String {
        case office1 = "Officer1"
        case office2 = "Officer2"
        case warehouse1 = "Warehouse"
    }
    
    @IBAction func LocationTapped(_ sender: UIButton) {
        guard let title = sender.currentTitle,
        let location = Locations(rawValue: title)
        else {return}
        
        switch location {
        case .office1:
            locationButtons.forEach{ (button) in
                       UIView.animate(withDuration: 0.3, animations:{
                           button.isHidden = !button.isHidden
                           self.view.layoutIfNeeded()
                       } )
                       
                   }
            print("Location1")
            listenerType = ListenerType.officer1
            realtimeDB.child("office1").child("aqi").observe(.value, with: {(snapshot) in
            self.aqiLabel.text = "\(snapshot.value as? Int)"
                
            })
        case .office2:
            locationButtons.forEach{ (button) in
                UIView.animate(withDuration: 0.3, animations:{
                    button.isHidden = !button.isHidden
                    self.view.layoutIfNeeded()
                } )
                
            }
            print("Location2")
            listenerType = ListenerType.officer2
            
        case .warehouse1:
            locationButtons.forEach{ (button) in
                UIView.animate(withDuration: 0.3, animations:{
                    button.isHidden = !button.isHidden
                    self.view.layoutIfNeeded()
                } )
                
            }
            print("Loccation3")
            listenerType = ListenerType.warehouse1
        }
    }
    
    @IBOutlet weak var colourLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var aqiLabel: UILabel!
    
    
    @IBOutlet weak var ProgressBarView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        firebaseController = appDelegate.firebaseController
        
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        
        content.title = "High AQI Warning"
        content.subtitle = "AQI has some stranges"
        content.body = "YOur AQI in officer is high, please check that"
        content.sound = UNNotificationSound.default
        content.threadIdentifier = "local-notifications temp"
        
        let date = Date(timeIntervalSinceNow: 10)
        
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: "content", content: content, trigger: trigger)
        
        center.add(request) {(error) in
            if error != nil{
                print(error as Any)
            }
        }
        realtimeDB.child("office1").child("aqi").observeSingleEvent(of: .value, with: {(snapshot) in
        self.aqiLabel.text = "\(snapshot.value as! Int)"
            print(snapshot.value as! Int)
        })
        
        
}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        firebaseController!.addListener(listener: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        firebaseController!.removeListener(listener: self)
    }
    
    //MARK: Control the progress bar When getting data from officer 1 collection
    func onOfficer1Change(change: DatabaseChange, OfficerDatas: [officerData]) {
        
        officerList = OfficerDatas
        
        let shapeLayer = CAShapeLayer()
        let backgroundLayer = CAShapeLayer()
        let minLayer = CAShapeLayer()
        let textLayer = CATextLayer()
        let coverlayer = CATextLayer()
        
        if(!officerList.isEmpty)
        {
            //cover the previous layer
            coverlayer.string = "100"
            coverlayer.backgroundColor = UIColor.white.cgColor
            coverlayer.foregroundColor = UIColor.white.cgColor
            coverlayer.alignmentMode = .center
            coverlayer.frame = CGRect(x: 0, y: 0, width: 700, height: 1200)
            ProgressBarView.layer.addSublayer(coverlayer)
            
         // the biggest circle to represent the number of colourtemperature
        let circularPath = UIBezierPath(arcCenter: ProgressBarView.center, radius: 150, startAngle: -CGFloat.pi/2, endAngle: -CGFloat.pi/2 + 2 * CGFloat.pi, clockwise: true)
        backgroundLayer.path = circularPath.cgPath
        backgroundLayer.strokeColor = UIColor.red.cgColor
        backgroundLayer.lineWidth = 20
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.lineCap = .round
            backgroundLayer.strokeEnd = CGFloat(Float(officerList.last!.colourTemperature!) / Float(10000))
        ProgressBarView.layer.addSublayer(backgroundLayer)
        
            //the mid circle to represent th number of temperature
        let circularPath2 = UIBezierPath(arcCenter: ProgressBarView.center, radius: 130, startAngle: -CGFloat.pi/2, endAngle: -CGFloat.pi/2 + 2 * CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath2.cgPath
        shapeLayer.strokeColor = UIColor.green.cgColor
        shapeLayer.lineWidth = 20
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .round
            shapeLayer.strokeEnd = CGFloat(Float(officerList.last!.temperature!) / Float(35))
        ProgressBarView.layer.addSublayer(shapeLayer)
        
            //the min circle to represent th number of aqi
        let circularPath3 = UIBezierPath(arcCenter: ProgressBarView.center, radius: 110, startAngle: -CGFloat.pi/2, endAngle: -CGFloat.pi/2 + 2 * CGFloat.pi, clockwise: true)
        minLayer.path = circularPath3.cgPath
        minLayer.strokeColor = UIColor.blue.cgColor
        minLayer.lineWidth = 20
        minLayer.fillColor = UIColor.clear.cgColor
        minLayer.lineCap = .round
        minLayer.strokeEnd = CGFloat(Float(officerList.last!.AQI!) / Float(50))
        ProgressBarView.layer.addSublayer(minLayer)
        
//add the text of AQI number in the center of circle
        textLayer.string = "\(officerList.last!.AQI!)"
        textLayer.backgroundColor = UIColor.clear.cgColor
        textLayer.foregroundColor = UIColor.orange.cgColor
        textLayer.alignmentMode = .center
        textLayer.frame = CGRect(x: 100, y: 280, width: 200, height: 140)
        textLayer.fontSize = 100
        ProgressBarView.layer.addSublayer(textLayer)
            
            
            
        colourLabel.text = "\(officerList.last!.colourTemperature!)"
        tempLabel.text = "\(officerList.last!.temperature!)"
      //  aqiLabel.text = "\(officerList.last!.AQI!)"
            
        
        }
        else
        {
            
        }
      }
    
    //MARK: - get data from the collection "office 2"
    func onOfficer2Change(change: DatabaseChange, OfficerDatas: [officerData]) {
        
        officerList = OfficerDatas
               
               let shapeLayer = CAShapeLayer()
               let backgroundLayer = CAShapeLayer()
               let minLayer = CAShapeLayer()
               let textLayer = CATextLayer()
               let coverlayer = CATextLayer()
               
               
               if(!officerList.isEmpty)
               {
                   //cover the previous layer
                   coverlayer.string = "100"
                   coverlayer.backgroundColor = UIColor.white.cgColor
                   coverlayer.foregroundColor = UIColor.white.cgColor
                   coverlayer.alignmentMode = .center
                   coverlayer.frame = CGRect(x: 0, y: 0, width: 700, height: 1200)
                   ProgressBarView.layer.addSublayer(coverlayer)
                   
                // the biggest circle to represent the number of colourtemperature
               let circularPath = UIBezierPath(arcCenter: ProgressBarView.center, radius: 150, startAngle: -CGFloat.pi/2, endAngle: -CGFloat.pi/2 + 2 * CGFloat.pi, clockwise: true)
               backgroundLayer.path = circularPath.cgPath
               backgroundLayer.strokeColor = UIColor.red.cgColor
               backgroundLayer.lineWidth = 20
               backgroundLayer.fillColor = UIColor.clear.cgColor
               backgroundLayer.lineCap = .round
                   backgroundLayer.strokeEnd = CGFloat(Float(officerList.last!.colourTemperature!) / Float(10000))
               ProgressBarView.layer.addSublayer(backgroundLayer)
               
               //the mid circle to represent th number of temperature
               let circularPath2 = UIBezierPath(arcCenter: ProgressBarView.center, radius: 130, startAngle: -CGFloat.pi/2, endAngle: -CGFloat.pi/2 + 2 * CGFloat.pi, clockwise: true)
               shapeLayer.path = circularPath2.cgPath
               shapeLayer.strokeColor = UIColor.green.cgColor
               shapeLayer.lineWidth = 20
               shapeLayer.fillColor = UIColor.clear.cgColor
               shapeLayer.lineCap = .round
                   shapeLayer.strokeEnd = CGFloat(Float(officerList.last!.temperature!) / Float(35))
               ProgressBarView.layer.addSublayer(shapeLayer)
               
               //the min circle to represent aqi number
               let circularPath3 = UIBezierPath(arcCenter: ProgressBarView.center, radius: 110, startAngle: -CGFloat.pi/2, endAngle: -CGFloat.pi/2 + 2 * CGFloat.pi, clockwise: true)
               minLayer.path = circularPath3.cgPath
               minLayer.strokeColor = UIColor.blue.cgColor
               minLayer.lineWidth = 20
               minLayer.fillColor = UIColor.clear.cgColor
               minLayer.lineCap = .round
               minLayer.strokeEnd = CGFloat(Float(officerList.last!.AQI!) / Float(50))
               ProgressBarView.layer.addSublayer(minLayer)
               
               //add the text of AQI number in the center of circle
               textLayer.string = "\(officerList.last!.AQI!)"
               textLayer.backgroundColor = UIColor.clear.cgColor
               textLayer.foregroundColor = UIColor.orange.cgColor
               textLayer.alignmentMode = .center
               textLayer.frame = CGRect(x: 100, y: 280, width: 200, height: 140)
               textLayer.fontSize = 100
               ProgressBarView.layer.addSublayer(textLayer)
               }
               else
               {
                   
               }
    }
    
        //MARK: - get data from the collection "warehouse 1"
     func onWarehouse1Change(change: DatabaseChange, OfficerDatas: [officerData]) {
        
        officerList = OfficerDatas
               
               let shapeLayer = CAShapeLayer()
               let backgroundLayer = CAShapeLayer()
               let minLayer = CAShapeLayer()
               let textLayer = CATextLayer()
               let coverlayer = CATextLayer()
               
               if(!officerList.isEmpty)
               {
                    //cover the previous layer
                   coverlayer.string = "100"
                   coverlayer.backgroundColor = UIColor.white.cgColor
                   coverlayer.foregroundColor = UIColor.white.cgColor
                   coverlayer.alignmentMode = .center
                   coverlayer.frame = CGRect(x: 0, y: 0, width: 700, height: 1200)
                   ProgressBarView.layer.addSublayer(coverlayer)
                   
                  // the biggest circle to represent the number of colourtemperature
               let circularPath = UIBezierPath(arcCenter: ProgressBarView.center, radius: 150, startAngle: -CGFloat.pi/2, endAngle: -CGFloat.pi/2 + 2 * CGFloat.pi, clockwise: true)
               backgroundLayer.path = circularPath.cgPath
               backgroundLayer.strokeColor = UIColor.red.cgColor
               backgroundLayer.lineWidth = 20
               backgroundLayer.fillColor = UIColor.clear.cgColor
               backgroundLayer.lineCap = .round
                   backgroundLayer.strokeEnd = CGFloat(Float(officerList.last!.colourTemperature!) / Float(10000))
               ProgressBarView.layer.addSublayer(backgroundLayer)
               
                //the mid circle to represent th number of temperature
               let circularPath2 = UIBezierPath(arcCenter: ProgressBarView.center, radius: 130, startAngle: -CGFloat.pi/2, endAngle: -CGFloat.pi/2 + 2 * CGFloat.pi, clockwise: true)
               shapeLayer.path = circularPath2.cgPath
               shapeLayer.strokeColor = UIColor.green.cgColor
               shapeLayer.lineWidth = 20
               shapeLayer.fillColor = UIColor.clear.cgColor
               shapeLayer.lineCap = .round
                   shapeLayer.strokeEnd = CGFloat(Float(officerList.last!.temperature!) / Float(35))
               ProgressBarView.layer.addSublayer(shapeLayer)
               
                //the min circle to represent aqi number
               let circularPath3 = UIBezierPath(arcCenter: ProgressBarView.center, radius: 110, startAngle: -CGFloat.pi/2, endAngle: -CGFloat.pi/2 + 2 * CGFloat.pi, clockwise: true)
               minLayer.path = circularPath3.cgPath
               minLayer.strokeColor = UIColor.blue.cgColor
               minLayer.lineWidth = 20
               minLayer.fillColor = UIColor.clear.cgColor
               minLayer.lineCap = .round
               minLayer.strokeEnd = CGFloat(Float(officerList.last!.AQI!) / Float(50))
               ProgressBarView.layer.addSublayer(minLayer)
               
//add the text of AQI number in the center of circle
               textLayer.string = "\(officerList.last!.AQI!)"
               textLayer.backgroundColor = UIColor.clear.cgColor
               textLayer.foregroundColor = UIColor.orange.cgColor
               textLayer.alignmentMode = .center
               textLayer.frame = CGRect(x: 100, y: 280, width: 200, height: 140)
               textLayer.fontSize = 100
               ProgressBarView.layer.addSublayer(textLayer)
               }
               else
               {
                   
               }
          
      }
    
//    @objc private func handleTap(){
//        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
//
//        basicAnimation.toValue = 1
//
//        basicAnimation.duration = 2
//
//        basicAnimation.fillMode = .forwards
//        basicAnimation.isRemovedOnCompletion = false
//
//        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
//    }
}
