//
//  SecondViewController.swift
//  app-steady
//
//  Created by Andrew Demoleas on 4/6/16.
//  Copyright © 2016 Hawt-Lava. All rights reserved.
//

import UIKit
import Charts

class SecondViewController: UIViewController {
    
    var lineChart = LineChartView(frame: CGRectMake(100, 100, 400, 400))
    
    var days: [String]!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.initializeLineChart()
    }
    
    func initializeLineChart(){
        days = ["Mon", "Tues", "Wed", "Thurs", "Fri", "Sat", "Sun"]
        let rank = [4.0, 6.0, 8.0, 7.0, 10.0, 10.0, 8.0]
        setChart(days, values: rank)
        self.view.addSubview(lineChart)
    }
    
    func setChart(dataPoints: [String], values: [Double]){
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = LineChartDataSet(yVals: dataEntries, label: "Score")
        let chartData = LineChartData(xVals: days, dataSet: chartDataSet)
        lineChart.data = chartData
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
