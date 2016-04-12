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
    
    var mainQuestion = nextQuestion()
    
    let pickerData = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let questionLabel = UILabel(frame: CGRectMake(0, 0, 200, 21))
        questionLabel.textAlignment = NSTextAlignment.Center
        questionLabel.text = mainQuestion.askQuestion
        
        let answerLabel = UILabel(frame: CGRectMake(0, 100, 200, 21))
        answerLabel.textAlignment = NSTextAlignment.Center
        answerLabel.text = ""
        
        let nextQuestionButton = UIButton(type: UIButtonType.System)
        nextQuestionButton.setTitle("Next Question", forState: UIControlState.Normal)
        nextQuestionButton.frame = CGRectMake(0, 200, 200, 21)
        nextQuestionButton.addTarget(self, action: #selector(FirstViewController.nexQuestionButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(nextQuestionButton)
        
        answerPicker.dataSource = self
        answerPicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func nextQuestionButtonPressed(sender: UIButton!) {
        mainQuestion = nextQuestion()
        questionLabel.text = mainQuestion.askQuestion
        NSLog(answerLabel.text)
        answerLabel.text = ""
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

