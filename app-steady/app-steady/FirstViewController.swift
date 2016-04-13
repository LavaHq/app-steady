//
//  FirstViewController.swift
//  app-steady
//
//  Created by Andrew Demoleas on 4/6/16.
//  Copyright © 2016 Hawt-Lava. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    @IBOutlet weak var answerPicker: UIPickerView!
    var questionLabel = UILabel(frame: CGRectMake(50, 150, 200, 21))
    var answerLabel = UILabel(frame: CGRectMake(50, 200, 200, 21))
    let nextQuestionButton = UIButton(type: UIButtonType.System)
    
    var mainQuestion = nextQuestion()
    
    let pickerData = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        questionLabel.textAlignment = NSTextAlignment.Center
        questionLabel.text = "testing"
        
        answerLabel.textAlignment = NSTextAlignment.Center
        answerLabel.text = ""
        
        nextQuestionButton.setTitle("Next Question", forState: UIControlState.Normal)
        nextQuestionButton.frame = CGRectMake(50, 400, 200, 21)
        nextQuestionButton.addTarget(self, action: #selector(self.nextQuestionButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(nextQuestionButton)
        self.view.addSubview(questionLabel)
        answerPicker.dataSource = self
        answerPicker.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func nextQuestionButtonPressed(sender: UIButton!) {
        mainQuestion = nextQuestion()
        if (mainQuestion == nil)  {
            tabBarController?.selectedIndex = 1
            return
        }
        
        self.questionLabel.text = mainQuestion!.askQuestion
        NSLog(self.answerLabel.text!)
        self.answerLabel.text = ""
    }
    
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        answerLabel.text = pickerData[row]
    }
}

