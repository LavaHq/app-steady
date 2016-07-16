//
//  SecondViewController.swift
//  app-steady
//
//  Created by Andrew Demoleas on 4/6/16.
//  Copyright © 2016 Hawt-Lava. All rights reserved.
//

import UIKit
import Charts

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var lineChart = LineChartView(frame: CGRectMake(100, 100, 400, 400))
    
    var days: [String]!
    
    var tableView: UITableView  =   UITableView()
    
    var items: [String] = ["Viper", "X", "Games"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.initializeTableView()
        self.initializeLineChart()
    }
    
    func initializeTableView(){
        tableView.frame         =   CGRectMake(0, 50, 320, 200);
        tableView.delegate      =   self
        tableView.dataSource    =   self
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.view.addSubview(tableView)
    }
    
    func initializeLineChart(){
        days = ["Mon", "Tues", "Wed", "Thurs", "Fri", "Sat", "Sun"]
        
//        print(scores) // Use The Sucecssful Call Backs in SteadyApi.GET to correctly access the values
        
        let rank = [4.0, 6.0, 8.0, 7.0, 10.0, 10.0, 8.0]
        
        setChart(days, values: rank)
        self.view.addSubview(lineChart)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        cell.textLabel?.text = self.items[indexPath.row]
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
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
