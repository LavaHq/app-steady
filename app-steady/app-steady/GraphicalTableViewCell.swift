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
    
    var lineChart = LineChartView()

    var question: Question = Question(text: "", id: 0)
    var questionLabel = UILabel()
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

    
    func initializeLineChart(entries: [[AnyObject]], questionText: String){
        
        var xVals:[String] = []
        var yVals : [Double] = []
        for entry in entries {
            
            let x = entry[0] as! String
            let y = entry[1] as! Double
            
            xVals.append(x)
            yVals.append(y)
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
        lineChart.translatesAutoresizingMaskIntoConstraints = false
        lineChart.backgroundColor = COLOR_BACKGROUND
        
        questionLabel.text = questionText
        questionLabel.textColor = COLOR_TEXT
        questionLabel.backgroundColor = COLOR_TINT
        questionLabel.font = UIFont(name: FONT_MEDIUM, size: 20.0)
        questionLabel.textAlignment = NSTextAlignment.Center
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        
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
        lineChartDataSet.lineWidth = 5.0
        lineChartDataSet.label = ""
        
        let lineChartData = LineChartData(xVals: dataPoints, dataSet: lineChartDataSet)
        lineChartData.setDrawValues(false)
        lineChart.data = lineChartData
        
    }
    func initializeConstraints() {
        
        var allConstraints = [NSLayoutConstraint]()
        let viewsFromTheSix = [
            "questionLabel": questionLabel,
            "lineChart": lineChart
            ]
        
        // Question Label Button
        
        let horizontalQuestionLabelConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "|[questionLabel]|",
            options: [],
            metrics: nil,
            views: viewsFromTheSix)
        
        allConstraints += horizontalQuestionLabelConstraints
        
        let verticalQuestionLabelConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|[questionLabel(40)]",
            options: [],
            metrics: nil,
            views: viewsFromTheSix)
        
        allConstraints += verticalQuestionLabelConstraints
        
        
        //Results Button
        
        let horizontalLineChartConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "|[lineChart]|",
            options: [],
            metrics: nil,
            views: viewsFromTheSix)
        
        allConstraints += horizontalLineChartConstraints
        
        let verticalLineChartConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[questionLabel]-[lineChart]-|",
            options: [],
            metrics: nil,
            views: viewsFromTheSix)
        
        allConstraints += verticalLineChartConstraints
        
        NSLayoutConstraint.activateConstraints(allConstraints)
    }

}
