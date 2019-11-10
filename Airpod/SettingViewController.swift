//
//  SettingViewController.swift
//  Airpod
//
//  Created by Burns on 10/11/19.
//  Copyright © 2019 Group 6. All rights reserved.
//

import UIKit
import Firebase

class SettingViewController: UIViewController {
    
    private var realtimeDB = Database.database().reference()
    

    //MARK: - office1 AQI stack field eontent
    @IBOutlet weak var office1AQI: UIView!
    @IBOutlet weak var office1AQIText: UITextField!
    @IBOutlet weak var office1AQILabel: UILabel!
    @IBAction func btnTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, animations: { self.office1AQI.isHidden = !self.office1AQI.isHidden
            self.view.layoutIfNeeded()
        self.realtimeDB.child("office1").child("aqi").observeSingleEvent(of: .value, with: {(snapshot) in
                    self.office1AQILabel.text = "\(snapshot.value as! Int)"
               })
        })
        office1AQIText.text = ""
    }
    @IBAction func office1AQIBtn(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, animations: { self.office1AQI.isHidden = !self.office1AQI.isHidden
            self.view.layoutIfNeeded()
        })
        if (!(office1AQIText!.text!.isEmpty) && Int(office1AQIText.text!)! != 0){
            realtimeDB.child("office1").updateChildValues(["aqi": Int(office1AQIText!.text!)])
        }
        office1AQIText.text = ""
        realtimeDB.child("office1").child("aqi").observeSingleEvent(of: .value, with: {(snapshot) in
         self.office1AQILabel.text = "\(snapshot.value as! Int)"
    })
            self.view.endEditing(true)
}
    
    //MARK: - office1 temp setting contents
    @IBOutlet weak var ofice1TempLabel: UILabel!
    @IBOutlet weak var office1Temp: UIView!
    @IBOutlet weak var office1TempText: UITextField!
    
    @IBAction func office1TempEdit(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, animations: { self.office1Temp.isHidden = !self.office1Temp.isHidden
            self.view.layoutIfNeeded()
        self.realtimeDB.child("office1").child("temp").observeSingleEvent(of: .value, with: {(snapshot) in
                    self.ofice1TempLabel.text = "\(snapshot.value as! Int)"
               })
        })
        office1TempText.text = ""
    }
    
    @IBAction func officeTempSub(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, animations: { self.office1Temp.isHidden = !self.office1Temp.isHidden
                self.view.layoutIfNeeded()
            })
            if (!(office1TempText!.text!.isEmpty) && Int(office1TempText.text!)! != 0){
                realtimeDB.child("office1").updateChildValues(["temp": Int(office1TempText!.text!)])
            }
            office1TempText.text = ""
            realtimeDB.child("office1").child("temp").observeSingleEvent(of: .value, with: {(snapshot) in
             self.ofice1TempLabel.text = "\(snapshot.value as! Int)"
        })
         self.view.endEditing(true)
    }
    
    //MARK: - office 1 colour temperature contents setting
    @IBOutlet weak var office1ColLabel: UILabel!
    @IBOutlet weak var office1Col: UIView!
    @IBOutlet weak var office1ColText: UITextField!
    @IBAction func office1ColEdit(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, animations: { self.office1Col.isHidden = !self.office1Col.isHidden
            self.view.layoutIfNeeded()
        self.realtimeDB.child("office1").child("colour_temp").observeSingleEvent(of: .value, with: {(snapshot) in
                    self.office1ColLabel.text = "\(snapshot.value as! Int)"
               })
        })
        
        office1ColText.text = ""

    }
    
    @IBAction func office1ColSub(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, animations: { self.office1Col.isHidden = !self.office1Col.isHidden
                self.view.layoutIfNeeded()
            })
            if (!(office1ColText!.text!.isEmpty) && Int(office1ColText.text!)! != 0){
    realtimeDB.child("office1").updateChildValues(["colour_temp": Int(office1ColText!.text!)])
            }
            office1ColText.text = ""
            realtimeDB.child("office1").child("colour_temp").observeSingleEvent(of: .value, with: {(snapshot) in
             self.office1ColLabel.text = "\(snapshot.value as! Int)"
        })
         self.view.endEditing(true)
    }
   
    //MARK: - office 2 aqi setting content
    @IBOutlet weak var office2aqiLabel: UILabel!
    @IBOutlet weak var office2AQI: UIView!
    @IBOutlet weak var office2AQIText: UITextField!
    @IBAction func office2AQIEdit(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, animations: { self.office2AQI.isHidden = !self.office2AQI.isHidden
            self.view.layoutIfNeeded()
        self.realtimeDB.child("office2").child("aqi").observeSingleEvent(of: .value, with: {(snapshot) in
                    self.office1ColLabel.text = "\(snapshot.value as! Int)"
               })
        })
        office2AQIText.text = ""
    }
    
    @IBAction func office2AQISub(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, animations: { self.office2AQI.isHidden = !self.office2AQI.isHidden
                    self.view.layoutIfNeeded()
                })
                if (!(office2AQIText!.text!.isEmpty) && Int(office2AQIText.text!)! != 0){
        realtimeDB.child("office2").updateChildValues(["aqi": Int(office2AQIText!.text!)])
                }
        office2AQIText.text = ""
        realtimeDB.child("office2").child("aqi").observeSingleEvent(of: .value, with: {(snapshot) in
                 self.office2aqiLabel.text = "\(snapshot.value as! Int)"
            })
         self.view.endEditing(true)
    }
    
    //MARK: - office2 temperature setting contents
    
    @IBOutlet weak var office2TempText: UITextField!
    @IBOutlet weak var office2Temp: UIView!
    @IBOutlet weak var office2TempLabel: UILabel!
    
    @IBAction func office2TempEdit(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, animations: { self.office2Temp.isHidden = !self.office2Temp.isHidden
            self.view.layoutIfNeeded()
        self.realtimeDB.child("office2").child("temp").observeSingleEvent(of: .value, with: {(snapshot) in
                    self.office2TempLabel.text = "\(snapshot.value as! Int)"
               })
        })
        office2TempText.text = ""
    }
    
    @IBAction func office2TempSub(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, animations: { self.office2Temp.isHidden = !self.office2Temp.isHidden
                    self.view.layoutIfNeeded()
                })
                if (!(office2TempText!.text!.isEmpty) && Int(office2TempText.text!)! != 0){
        realtimeDB.child("office2").updateChildValues(["temp": Int(office2TempText!.text!)])
                }
        office2TempText.text = ""
        realtimeDB.child("office2").child("temp").observeSingleEvent(of: .value, with: {(snapshot) in
                 self.office2TempLabel.text = "\(snapshot.value as! Int)"
            })
         self.view.endEditing(true)
    }
    
    //MARK: - office 2 colour temperature setting contents
    
    @IBOutlet weak var office2ColLabel: UILabel!
    @IBOutlet weak var office2ColText: UITextField!
    @IBOutlet weak var office2Col: UIView!
    
    @IBAction func office2ColEdit(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: { self.office2Col.isHidden = !self.office2Col.isHidden
            self.view.layoutIfNeeded()
        self.realtimeDB.child("office2").child("colour_temp").observeSingleEvent(of: .value, with: {(snapshot) in
                    self.office2ColLabel.text = "\(snapshot.value as! Int)"
               })
        })
        office2ColText.text = ""
        
    }
    
    @IBAction func office2ColSub(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: { self.office2Col.isHidden = !self.office2Col.isHidden
                    self.view.layoutIfNeeded()
                })
                if (!(office2ColText!.text!.isEmpty) && Int(office2ColText.text!)! != 0){
        realtimeDB.child("office2").updateChildValues(["colour_temp": Int(office2ColText!.text!)])
                }
        office2ColText.text = ""
        realtimeDB.child("office2").child("colour_temp").observeSingleEvent(of: .value, with: {(snapshot) in
                 self.office2ColLabel.text = "\(snapshot.value as! Int)"
            })
         self.view.endEditing(true)
    }
    
    
    //MARK: - warehouse 1 setting contents
    
    @IBOutlet weak var ware1AQILabel: UILabel!
    @IBOutlet weak var ware1AQI: UIView!
    @IBOutlet weak var ware1AQIText: UITextField!
    
    @IBAction func ware1AQIEdit(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, animations: { self.ware1AQI.isHidden = !self.ware1AQI.isHidden
            self.view.layoutIfNeeded()
        self.realtimeDB.child("warehouse").child("aqi").observeSingleEvent(of: .value, with: {(snapshot) in
                    self.ware1AQILabel.text = "\(snapshot.value as! Int)"
               })
        })
        ware1AQIText.text = ""
    }
    @IBAction func ware1AQISub(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, animations: { self.ware1AQI.isHidden = !self.ware1AQI.isHidden
                    self.view.layoutIfNeeded()
                })
                if (!(ware1AQIText!.text!.isEmpty) && Int(ware1AQIText.text!)! != 0){
        realtimeDB.child("warehouse").updateChildValues(["aqi": Int(ware1AQIText!.text!)])
                }
        ware1AQIText.text = ""
        realtimeDB.child("warehouse").child("aqi").observeSingleEvent(of: .value, with: {(snapshot) in
                 self.ware1AQILabel.text = "\(snapshot.value as! Int)"
            })
        ware1AQIText.text = ""
         self.view.endEditing(true)
    }
    
    //MARK: warehouse1 setting contents about temperature
    @IBOutlet weak var ware1TempLabel: UILabel!
    @IBOutlet weak var ware1Temp: UIView!
    @IBOutlet weak var ware1TempText: UITextField!
    
    @IBAction func ware1TempEdit(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, animations: { self.ware1Temp.isHidden = !self.ware1Temp.isHidden
            self.view.layoutIfNeeded()
        self.realtimeDB.child("warehouse").child("temp").observeSingleEvent(of: .value, with: {(snapshot) in
                    self.ware1TempLabel.text = "\(snapshot.value as! Int)"
               })
        })
        ware1TempText.text = ""
        
    }
    
    @IBAction func ware1TempSub(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, animations: { self.ware1Temp.isHidden = !self.ware1Temp.isHidden
                           self.view.layoutIfNeeded()
                       })
                       if (!(ware1TempText!.text!.isEmpty) && Int(ware1TempText.text!)! != 0){
               realtimeDB.child("warehouse").updateChildValues(["temp": Int(ware1TempText!.text!)])
                       }
               ware1AQIText.text = ""
               realtimeDB.child("warehouse").child("temp").observeSingleEvent(of: .value, with: {(snapshot) in
                        self.ware1TempLabel.text = "\(snapshot.value as! Int)"
                   })
        ware1TempText.text = ""
         self.view.endEditing(true)
    }
    
    //MARK: warehouse1 colour temperature setting
    @IBOutlet weak var ware1ColLabel: UILabel!
    @IBOutlet weak var ware1View: UIView!
    @IBOutlet weak var ware1ColText: UITextField!
    
    @IBAction func ware1ColEdit(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, animations: { self.ware1View.isHidden = !self.ware1View.isHidden
            self.view.layoutIfNeeded()
        self.realtimeDB.child("warehouse").child("colour_temp").observeSingleEvent(of: .value, with: {(snapshot) in
                    self.ware1ColLabel.text = "\(snapshot.value as! Int)"
               })
        })
        ware1ColText.text = ""
        
    }
    
    @IBAction func ware1ColSub(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, animations: { self.ware1View.isHidden = !self.ware1View.isHidden
                           self.view.layoutIfNeeded()
                       })
                       if (!(ware1ColText!.text!.isEmpty) && Int(ware1ColText.text!)! != 0){
               realtimeDB.child("warehouse").updateChildValues(["colour_temp": Int(ware1ColText!.text!)])
                       }
               ware1ColText.text = ""
               realtimeDB.child("warehouse").child("colour_temp").observeSingleEvent(of: .value, with: {(snapshot) in
                        self.ware1ColLabel.text = "\(snapshot.value as! Int)"
                   })
        ware1ColText.text = ""
        self.view.endEditing(true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        realtimeDB.child("office1").child("aqi").observeSingleEvent(of: .value, with: {(snapshot) in
             self.office1AQILabel.text = "\(snapshot.value as! Int)"
        })
        realtimeDB.child("office1").child("temp").observeSingleEvent(of: .value, with: {(snapshot) in
                    self.ofice1TempLabel.text = "\(snapshot.value as! Int)"
               })
        realtimeDB.child("office1").child("colour_temp").observeSingleEvent(of: .value, with: {(snapshot) in
             self.office1ColLabel.text = "\(snapshot.value as! Int)"
        })
        realtimeDB.child("office2").child("aqi").observeSingleEvent(of: .value, with: {(snapshot) in
                        self.office2aqiLabel.text = "\(snapshot.value as! Int)"
                   })
        realtimeDB.child("office2").child("temp").observeSingleEvent(of: .value, with: {(snapshot) in
             self.office2TempLabel.text = "\(snapshot.value as! Int)"
        })
        realtimeDB.child("office2").child("colour_temp").observeSingleEvent(of: .value, with: {(snapshot) in
             self.office2ColLabel.text = "\(snapshot.value as! Int)"
        })
        realtimeDB.child("warehouse").child("aqi").observeSingleEvent(of: .value, with: {(snapshot) in
             self.ware1AQILabel.text = "\(snapshot.value as! Int)"
        })
        realtimeDB.child("warehouse").child("temp").observeSingleEvent(of: .value, with: {(snapshot) in
             self.ware1TempLabel.text = "\(snapshot.value as! Int)"
        })
        realtimeDB.child("warehouse").child("colour_temp").observeSingleEvent(of: .value, with: {(snapshot) in
             self.ware1ColLabel.text = "\(snapshot.value as! Int)"
        })

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
