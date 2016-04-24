//
//  FirstViewController.swift
//  app-steady
//
//  Created by Andrew Demoleas on 4/6/16.
//  Copyright © 2016 Hawt-Lava. All rights reserved.
//

import UIKit
import Alamofire

class FirstViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    let UUID = UIDevice.currentDevice().identifierForVendor!.UUIDString
    
    var answerPicker = UIPickerView(frame: CGRectMake(100, 400, 200, 100))
    var questionLabel = UILabel(frame: CGRectMake(100, 100, 200, 21))
    var answerLabel = UILabel(frame: CGRectMake(100, 200, 200, 21))
    let nextQuestionButton = UIButton(type: UIButtonType.System)
    
    var mainQuestion = nextQuestion()
    
    let pickerData = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.initializeQuestionLabel()
        self.initializeAnswerPicker()
        self.initializeNextQuestionButton()
        self.initializeAnswerPicker()
        self.initializeAlamofire()
    }
    
    func initializeQuestionLabel() {
        questionLabel.textAlignment = NSTextAlignment.Center
        questionLabel.text = mainQuestion!.askQuestion
        self.view.addSubview(questionLabel)
    }
    
    func initializeAnswerLabel() {
        answerLabel.textAlignment = NSTextAlignment.Center
        answerLabel.hidden = true
        self.view.addSubview(answerLabel)
    }
    
    func initializeNextQuestionButton () {
        nextQuestionButton.setTitle("Next Question", forState: UIControlState.Normal)
        nextQuestionButton.frame = CGRectMake(100, 600, 200, 21)
        nextQuestionButton.addTarget(self, action: #selector(self.nextQuestionButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(nextQuestionButton)
    }
    
    func initializeAnswerPicker() {
        self.view.addSubview(answerPicker)
        answerPicker.dataSource = self
        answerPicker.delegate = self
    }
    
    func initializeAlamofire() {
        Alamofire.request(.GET, "http://localhost:8000/prompts") .responseJSON { response in // 1
            if let httpError = response.result.error {
                let statusCode = httpError.code
            } else { //no errors
                let statusCode = (response.response?.statusCode)!
            }
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
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
        self.answerLabel.hidden = true
        print(self.UUID, self.questionLabel.text!, self.answerLabel.text!)
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
        answerLabel.hidden = false
    }
}

