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
    
    var lineChart = LineChartView(frame: CGRectMake(0, 0, 400, 206))

    var question: Question = Question(text: "", id: 0)
    var x_label: String = ""
    var y_label: String = ""
    var x_bounds: [Int] = []
    var y_bounds: [Int] = [0, 10]
    var data: [[Int]] = [[]]
    var days: [String]!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = COLOR_BACKGROUND
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func initializeLineChart(entries: NSMutableArray, questionText: String){
        
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
        lineChart.legend.enabled = false
        lineChart.rightAxis.enabled = false
        lineChart.borderColor = COLOR_BORDER
        lineChart.backgroundColor = COLOR_BACKGROUND
        
        let questionLabel = UILabel(frame: CGRect.init(x: 50, y: -5, width: lineChart.frame.width, height: 100))
        questionLabel.text = questionText
        questionLabel.textColor = COLOR_TEXT
        questionLabel.textAlignment = NSTextAlignment.Left
        
        self.addSubview(lineChart)
        self.addSubview(questionLabel)
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
