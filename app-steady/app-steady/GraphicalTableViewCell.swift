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
    
    func initializeLineChart(entries: NSMutableArray){
        
        var xVals:[String] = []
        var yVals : [Double] = []
        for entry in entries {
            xVals.append(entry[0] as! String)
            yVals.append(entry[1] as! Double)
        }
        
        setChart(xVals, values: yVals)
        
        lineChart.dragEnabled = false
        lineChart.doubleTapToZoomEnabled = false
        lineChart.drawBordersEnabled = true
        lineChart.xAxis.enabled = false
        lineChart.descriptionText = ""
        
        
        let legend = ChartLegend()
        let chartViewPortHandler = ChartViewPortHandler()
        let chartLegendRenderer = ChartLegendRenderer(viewPortHandler: chartViewPortHandler, legend: legend)
        
        self.addSubview(lineChart)
    }
    
    func setChart(dataPoints: [String], values: [Double]){
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: "Progress")
        lineChartDataSet.circleHoleRadius = 0.0
        lineChartDataSet.label = ""
        
        let lineChartData = LineChartData(xVals: dataPoints, dataSet: lineChartDataSet)
        lineChartData.setDrawValues(false)
        lineChart.data = lineChartData
        
    }

}
