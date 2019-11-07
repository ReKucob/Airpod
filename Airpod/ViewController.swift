//
//  ViewController.swift
//  Airpod
//
//  Created by Burns on 15/10/19.
//  Copyright © 2019 Group 6. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DatabaseListener {
    
     var officerList: [officerData] = []
     weak var firebaseController: DatabaseProtocol?
   
    @IBOutlet weak var ProgressBarView: ProgressView!
    
    var countFIeld: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        firebaseController = appDelegate.firebaseController
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
        
        self.ProgressBarView.getNumber(AQIData: 93)
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true)
          {
            (timer) in self.countFIeld += 0.5
              DispatchQueue.main.async {
                  self.ProgressBarView.progress = min(0.03 * self.countFIeld, 1)
                  
                  if self.ProgressBarView.progress == 1{
                      timer.invalidate()
                  }
              }
          }
      }
}

