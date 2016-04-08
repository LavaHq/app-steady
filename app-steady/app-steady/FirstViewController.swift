//
//  FirstViewController.swift
//  app-steady
//
//  Created by Andrew Demoleas on 4/6/16.
//  Copyright © 2016 Hawt-Lava. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var nextQuestionButton: UIButton!
    @IBOutlet weak var answerPicker: UIPickerView!
    @IBOutlet weak var answerLabel: UILabel!
    
    var mainQuestion = nextQuestion()
    
    let pickerData = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        questionLabel.text = mainQuestion.askQuestion
        answerPicker.dataSource = self
        answerPicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextQuestionButtonPressed(sender: AnyObject) {
        self.mainQuestion = nextQuestion()
        self.questionLabel.text = mainQuestion.askQuestion
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

