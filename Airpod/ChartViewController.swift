//
//  ChartViewController.swift
//  Airpod
//
//  Created by Burns on 3/11/19.
//  Copyright © 2019 Group 6. All rights reserved.
//

import UIKit
import Charts

class ChartViewController: UIViewController, DatabaseListener {
    
    var indexText = "days"
    
    //MARK: - Receive data
    var officerList: [officerData] = []
    weak var firebaseController: DatabaseProtocol?

    //MARK:  - Elements on the screen
    @IBOutlet weak var lineChartVIew: LineChartView!
    
    @IBOutlet weak var segmentC: UISegmentedControl!
    
    @IBAction func switchButton(_ sender: Any) {
        let getIndex = segmentC.selectedSegmentIndex
      
        switch(getIndex){
        case 1:
            indexText = "Week"
        case 2:
            indexText = "month"
        default:
            indexText = "days"
        }
    }
    
    // MARK: - Preparation of Chart view
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        firebaseController = appDelegate.firebaseController
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        firebaseController!.addListener(listener: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        firebaseController!.removeListener(listener: self)
    }

    // MARK: - Chart content for AQI
    var listenerType = ListenerType.officer1
    
    func onOfficer1Change(change: DatabaseChange, OfficerDatas: [officerData]) {
        officerList = OfficerDatas
        var lineChartEntry = [ChartDataEntry]()
        
        if (indexText == "days")
        {
        for data in officerList{
            let xvalue1 = lineChartEntry.count + 1
            let value = ChartDataEntry(x: Double(xvalue1), y: Double(data.AQI!))
            lineChartEntry.append(value)
        }
        
        let line = LineChartDataSet(entries: lineChartEntry, label: "Air Quality")
        line.colors = [NSUIColor.blue]

        let status = LineChartData()
        status.addDataSet(line)
        
        lineChartVIew.data = status
        lineChartVIew.chartDescription?.text = "AQI"
        }
        else if (indexText == "weeks")
        {
            for data in officerList{
                let xvalue1 = lineChartEntry.count + 1
                let value = ChartDataEntry(x: Double(xvalue1), y: Double(data.AQI!))
                lineChartEntry.append(value)
            }
            
            let line = LineChartDataSet(entries: lineChartEntry, label: "Air Quality")
            line.colors = [NSUIColor.green]

            let status = LineChartData()
            status.addDataSet(line)
            
            lineChartVIew.data = status
            lineChartVIew.chartDescription?.text = "AQI"
        }
        else if (indexText == "month")
        {
            for data in officerList{
                let xvalue1 = lineChartEntry.count + 1
                let value = ChartDataEntry(x: Double(xvalue1), y: Double(data.AQI!))
                lineChartEntry.append(value)
            }
            
            let line = LineChartDataSet(entries: lineChartEntry, label: "Air Quality")
            line.colors = [NSUIColor.red]

            let status = LineChartData()
            status.addDataSet(line)
            
            lineChartVIew.data = status
            lineChartVIew.chartDescription?.text = "AQI"
        }
    }
    
    func onOfficer2Change(change: DatabaseChange, OfficerDatas: [officerData]) {
    }
    
    func onwarehouse1Change(change: DatabaseChange, OfficerDatas: [officerData]) {
    }

}
