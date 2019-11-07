//
//  ViewController.swift
//  Airpod
//
//  Created by Burns on 15/10/19.
//  Copyright © 2019 Group 6. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, DatabaseListener {

    
     var officerList: [officerData] = []
     weak var firebaseController: DatabaseProtocol?
   
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
                print(error)
            }
        }
        
}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        firebaseController!.addListener(listener: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        firebaseController!.removeListener(listener: self)
    }
    
    //MARK: Control the progress bar When getting data
    var listenerType = ListenerType.officer
    
    func onOfficerChange(change: DatabaseChange, OfficerDatas: [officerData]) {
        
        officerList = OfficerDatas
        
        let shapeLayer = CAShapeLayer()
        let backgroundLayer = CAShapeLayer()
        let textLayer = CATextLayer()
        
        let circularPath = UIBezierPath(arcCenter: ProgressBarView.center, radius: 150, startAngle: -CGFloat.pi/2, endAngle: -CGFloat.pi/2 + 2 * CGFloat.pi, clockwise: true)
        backgroundLayer.path = circularPath.cgPath
        backgroundLayer.strokeColor = UIColor.lightGray.cgColor
        backgroundLayer.lineWidth = 20
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.lineCap = .round
        backgroundLayer.strokeEnd = 1
        view.layer.addSublayer(backgroundLayer)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 20
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .round
        shapeLayer.strokeEnd = 0.5
        view.layer.addSublayer(shapeLayer)
        
        textLayer.string = "100"
        textLayer.backgroundColor = UIColor.clear.cgColor
        textLayer.foregroundColor = UIColor.orange.cgColor
        textLayer.alignmentMode = .center
        textLayer.frame = CGRect(x: 100, y: 280, width: 200, height: 140)
        textLayer.fontSize = 100
        view.layer.addSublayer(textLayer)
        
//        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
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

