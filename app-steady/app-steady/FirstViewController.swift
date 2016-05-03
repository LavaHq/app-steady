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
    
    
    var questionList:[Question] = []
    var answerPicker = UIPickerView(frame: CGRectMake(100, 300, 200, 100))
    var questionLabel = QuestionLabel(frame: CGRectMake(0, 100, 400, 21))
    var answerLabel = UILabel(frame: CGRectMake(100, 200, 200, 21))
    var mainQuestionIndex = 0
    var scoresheet = Scoresheet(entries: [])
    
    let UUID = UIDevice.currentDevice().identifierForVendor!.UUIDString
    let nextQuestionButton = UIButton(type: UIButtonType.System)
    let pickerData = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.hidden = true 
        SteadyAPI.GET(ENDPOINT_PROMPTS, successCallback: initializeUIComponents, failureCallback: nil)
    }
    
    /**
     * Converts the list of questions from the api into a collection of Question objects
     *
     * - Parameters:
     *   - NSArray: The Results from querying the API
     * - Returns: A list of Question Objects That will be presented
     */
    func buildQuestions(results :NSArray) -> [Question]{
        var  questions: [Question] = []
        for result in results{
            let question = Question.deserializeQuestion(result as! NSDictionary)
            questions.append(question)
        }
        return questions
    }
    
    //MARK: - UIComponent Customization
    func initializeUIComponents(results: NSArray)
    {
        questionList = self.buildQuestions(results)
        self.initializeQuestionLabel()
        self.initializeAnswerPicker()
        self.initializeNextQuestionButton()
        
    }
    
    func initializeQuestionLabel() {
        questionLabel.textAlignment = NSTextAlignment.Center
        questionLabel.updateQuestion(questionList[0])
        self.view.addSubview(questionLabel)
    }
    
    func initializeAnswerLabel() {
        answerLabel.textAlignment = NSTextAlignment.Center
        answerLabel.hidden = true
        self.view.addSubview(answerLabel)
    }
    
    func initializeNextQuestionButton () {
        nextQuestionButton.setTitle("Next Question", forState: UIControlState.Normal)
        nextQuestionButton.frame = CGRectMake(100, 500, 200, 21)
        nextQuestionButton.addTarget(self, action: #selector(self.nextQuestionButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(nextQuestionButton)
    }
    
    func initializeAnswerPicker() {
        self.view.addSubview(answerPicker)
        answerPicker.dataSource = self
        answerPicker.delegate = self
    }
    
    /**
     * When the Submit Button is pressed, present the next question. If we are out of questions, segue to the next controller
     *
     * - Parameters:
     *   - UIButton: The Button that is pressed
     */
    func nextQuestionButtonPressed(sender: UIButton!) {
        print(self.UUID, self.questionLabel.text!, self.answerLabel.text!)
        
        let score: NSInteger? = Int(self.answerLabel.text!)
        let entry = Entry(question: questionList[mainQuestionIndex], score: score!)
        
        scoresheet.entries.append(entry)

        mainQuestionIndex += 1
        
        if (mainQuestionIndex == questionList.count)  {
            let params = scoresheet.toDict()
            SteadyAPI.POST(ENDPOINT_SCORESHEETS,
                           params: params,
                           successCallback: nil,
                           failureCallback: nil)
            segueToChart()
            
            return
        }
        
        self.questionLabel.updateQuestion(questionList[mainQuestionIndex])
        self.answerLabel.hidden = true

    }
    
    func segueToChart()
    {
        tabBarController?.selectedIndex = 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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

