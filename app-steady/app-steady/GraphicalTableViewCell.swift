//
//  GraphicalTableViewCell.swift
//  app-steady
//
//  Created by daniel.habib on 7/15/16.
//  Copyright © 2016 Hawt-Lava. All rights reserved.
//

import UIKit
import Charts

class GraphicalTableViewCell: UITableViewCell {
    
    var lineChart = LineChartView(frame: CGRectMake(0, 0, 400, 200))

    var question: Question = Question(text: "", id: 0)
    var x_label: String = ""
    var y_label: String = ""
    var x_bounds: [Int] = []
    var y_bounds: [Int] = []
    var data: [[Int]] = [[]]
    
    var days: [String]!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initializeLineChart(){
        let days = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
        let rank = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
        
        
        
        
        setChart(days, values: rank)
        self.addSubview(lineChart)
    }
    
    func setChart(dataPoints: [String], values: [Double]){
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
//            print("Entry: \(dataEntry)")
        }
        print (dataEntries)
        let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: "Units Sold")
        let lineChartData = LineChartData(xVals: dataPoints, dataSet: lineChartDataSet)
        lineChart.data = lineChartData
        
    }

}
