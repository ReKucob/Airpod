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
  
    
    var listenerType = ListenerType.officer1
    var indexText = "days"
    
    let today = Double(NSDate().timeIntervalSince1970)
    var thatDay: Double? = nil
    
    //MARK: - Receive data
    var officerList: [officerData] = []
    weak var firebaseController: DatabaseProtocol?

    //MARK:  - Elements on the screen
    
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
        case office1 = "office1"
        case office2 = "office2"
        case warehouse1 = "warehouse"
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
            print(Double(NSDate().timeIntervalSince1970))
            listenerType = ListenerType.officer1
        case .office2:
            locationButtons.forEach{ (button) in
                UIView.animate(withDuration: 0.3, animations:{
                    button.isHidden = !button.isHidden
                    self.view.layoutIfNeeded()
                } )
                
            }
            print(Calendar.autoupdatingCurrent.isDateInToday(Date(timeIntervalSince1970: 1573306652)))
            listenerType = ListenerType.officer2
        case .warehouse1:
            locationButtons.forEach{ (button) in
                UIView.animate(withDuration: 0.3, animations:{
                    button.isHidden = !button.isHidden
                    self.view.layoutIfNeeded()
                } )
                
            }
            print(Int(NSDate().timeIntervalSince1970) - (7*24*60*60))
            print(Date(timeIntervalSince1970: TimeInterval(Int(NSDate().timeIntervalSince1970) - (30*24*60*60))))
            listenerType = ListenerType.warehouse1
        }
    }
    
    @IBOutlet weak var lineChartVIew: LineChartView!
    
    @IBOutlet weak var segmentC: UISegmentedControl!
    
    @IBAction func switchButton(_ sender: Any) {
        let getIndex = segmentC.selectedSegmentIndex
      
        switch(getIndex){
        case 1:
            indexText = "days"
        case 2:
            indexText = "week"
        default:
            indexText = "month"
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

    // MARK: - Chart contents for days chart for each location
    func onOfficer1Change(change: DatabaseChange, OfficerDatas: [officerData]) {
        drawChart(officerList: OfficerDatas)
    }
    
    // MARK: - chart contents for location 2
    func onOfficer2Change(change: DatabaseChange, OfficerDatas: [officerData]) {
        drawChart(officerList: OfficerDatas)
    }
    
    //MARK: - chart contents for the location 3
   func onWarehouse1Change(change: DatabaseChange, OfficerDatas: [officerData]) {
         drawChart(officerList: OfficerDatas)
    }
    
    //MARK: - create and draw a line chart
    func drawChart(officerList: [officerData])
    {
        var lineChartEntry = [ChartDataEntry]()
        var colourLine = [ChartDataEntry]()
        var tempLine = [ChartDataEntry]()
        
        // add chart content for days
        if (indexText == "days")
        {
        thatDay = today - (24*60*60)
        for data in officerList{
            if (Int(data.timestamp!) >= Int(thatDay!))
            {
            let xvalue1 = lineChartEntry.count + 1
            let value = ChartDataEntry(x: Double(xvalue1), y: Double(data.AQI!))
            lineChartEntry.append(value)
            
            let xvalue2 = lineChartEntry.count + 1
            let value2 = ChartDataEntry(x: Double(xvalue2), y: Double(data.colourTemperature!))
            colourLine.append(value2)
            
            let xvalue3 = lineChartEntry.count + 1
            let value3 = ChartDataEntry(x: Double(xvalue3), y: Double(data.temperature!))
            tempLine.append(value3)
            }
        }
        
        let line = LineChartDataSet(entries: lineChartEntry, label: "Air Quality")
        line.colors = [NSUIColor.blue]

        let line2 = LineChartDataSet(entries: colourLine, label: "Colour temperature")
        line2.colors = [NSUIColor.red]
        
        let line3 = LineChartDataSet(entries: tempLine, label: "Temperature")
        line3.colors = [NSUIColor.green]
        
        let status = LineChartData()
        status.addDataSet(line)
        status.addDataSet(line2)
        status.addDataSet(line3)
        
        lineChartVIew.data = status
        lineChartVIew.chartDescription?.text = "Location Sensor records"
        }
            
        // add chart content for weeks
        else if (indexText == "week")
        {
            let count = 7.0
            var number: Int? = 0
            var totalaqi: Int? = 0
            var totalTemp: Int? = 0
            var totalColourTemp: Int? = 0
            while count >= 0.0 {
                let rangeMax = today - ((count - 1)*24*60*60)
                let rangeMin = today - (count*24*60*60)
                for data in officerList
                {
                    if (Int(data.timestamp!) >= Int(rangeMin) && Int(data.timestamp!) <= Int(rangeMax))
                    {
                        number = number! + 1
                        totalaqi = totalaqi! + data.AQI!
                        totalTemp = totalTemp! + data.temperature!
                        totalColourTemp = totalColourTemp! + data.colourTemperature!
                        
                        let xvalue1 = lineChartEntry.count + 1
                        let value = ChartDataEntry(x: Double(xvalue1), y: Double(totalaqi! / number!))
                        lineChartEntry.append(value)
                        
                        let xvalue2 = lineChartEntry.count + 1
                        let value2 = ChartDataEntry(x: Double(xvalue2), y: Double(totalTemp! / number!))
                        colourLine.append(value2)
                        
                        let xvalue3 = lineChartEntry.count + 1
                        let value3 = ChartDataEntry(x: Double(xvalue3), y: Double(totalColourTemp! / number!))
                        tempLine.append(value3)
                        
                    }
                }
        }
            let line = LineChartDataSet(entries: lineChartEntry, label: "Air Quality")
            line.colors = [NSUIColor.blue]

            let line2 = LineChartDataSet(entries: colourLine, label: "Colour temperature")
            line2.colors = [NSUIColor.red]
            
            let line3 = LineChartDataSet(entries: tempLine, label: "Temperature")
            line3.colors = [NSUIColor.green]
            
            let status = LineChartData()
            status.addDataSet(line)
            status.addDataSet(line2)
            status.addDataSet(line3)
            
            lineChartVIew.data = status
            lineChartVIew.chartDescription?.text = "AQI"
        }
            
        // add chart contents for month
        else if (indexText == "month")
        {
            let count = 30.0
            var number: Int? = 0
            var totalaqi: Int? = 0
            var totalTemp: Int? = 0
            var totalColourTemp: Int? = 0
            while count >= 0.0 {
                let rangeMax = today - ((count - 1)*24*60*60)
                let rangeMin = today - (count*24*60*60)
                for data in officerList
                {
                    if (Int(data.timestamp!) >= Int(rangeMin) && Int(data.timestamp!) <= Int(rangeMax))
                    {
                        number = number! + 1
                        totalaqi = totalaqi! + data.AQI!
                        totalTemp = totalTemp! + data.temperature!
                        totalColourTemp = totalColourTemp! + data.colourTemperature!
                        
                        let xvalue1 = lineChartEntry.count + 1
                        let value = ChartDataEntry(x: Double(xvalue1), y: Double(totalaqi! / number!))
                        lineChartEntry.append(value)
                        
                        let xvalue2 = lineChartEntry.count + 1
                        let value2 = ChartDataEntry(x: Double(xvalue2), y: Double(totalTemp! / number!))
                        colourLine.append(value2)
                        
                        let xvalue3 = lineChartEntry.count + 1
                        let value3 = ChartDataEntry(x: Double(xvalue3), y: Double(totalColourTemp! / number!))
                        tempLine.append(value3)
                        
                    }
                }
                
            }
            
            let line = LineChartDataSet(entries: lineChartEntry, label: "Air Quality")
            line.colors = [NSUIColor.blue]

            let line2 = LineChartDataSet(entries: colourLine, label: "Colour temperature")
            line2.colors = [NSUIColor.red]
            
            let line3 = LineChartDataSet(entries: tempLine, label: "Temperature")
            line3.colors = [NSUIColor.green]
            
            let status = LineChartData()
            status.addDataSet(line)
            status.addDataSet(line2)
            status.addDataSet(line3)
            
            lineChartVIew.data = status
            lineChartVIew.chartDescription?.text = "AQI"
        }
    }
}
