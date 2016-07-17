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
        let days = ["Mon", "Tues", "Wed", "Thurs", "Fri", "Sat", "Sun"]
        
        let rank = [4.0, 6.0, 8.0, 7.0, 10.0, 10.0, 8.0]
        
        setChart(days, values: rank)
        self.addSubview(lineChart)
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

}
