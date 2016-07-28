//
//  FirstViewController.swift
//  app-steady
//
//  Created by Andrew Demoleas on 4/6/16.
//  Copyright © 2016 Hawt-Lava. All rights reserved.
//

import UIKit
import Alamofire

var prompts: Dictionary<Int, String> = [:]

class FirstViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    
    var questionList:[Question] = []
    var answerPicker = UIPickerView(frame: CGRectMake(100, 300, 200, 100))
    var questionLabel = QuestionLabel(frame: CGRectMake(0, 100, 400, 100))
    var answerData = 1
    var mainQuestionIndex = 0
    var scoresheet = Scoresheet(entries: [])
    
    let nextQuestionButton = UIButton(type: UIButtonType.System)
    let resultsButton = UIButton(type: UIButtonType.System)
    
    let pickerData = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.hidden = true 
        SteadyAPI.GET(ENDPOINT_PROMPTS, successCallback: initializeUIComponents, failureCallback: nil)
        self.view.backgroundColor = COLOR_BACKGROUND
    }
    
    override func viewWillAppear(animated: Bool) {
        mainQuestionIndex = 0
        scoresheet = Scoresheet(entries: [])
        if (questionList.count > 0) {
            questionLabel.updateQuestion(questionList[0])
        }
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
            
            let id = result["id"] as! Int
            let text = result["text"] as! String
            
            prompts[id] = text
            
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
        self.initializeResultsButton()
    }
    
    func initializeQuestionLabel() {
        questionLabel.textAlignment = NSTextAlignment.Center
        questionLabel.updateQuestion(questionList[0])
        questionLabel.textColor = COLOR_TEXT
        questionLabel.numberOfLines = 0
        questionLabel.font = UIFont(name: FONT_MEDIUM, size: 25.0)
        self.view.addSubview(questionLabel)
    }
    
    func initializeNextQuestionButton () {
        nextQuestionButton.setTitle("Next Question", forState: UIControlState.Normal)
        nextQuestionButton.setTitleColor(COLOR_TEXT, forState: UIControlState.Normal)
        nextQuestionButton.backgroundColor = COLOR_BUTTON
        nextQuestionButton.titleLabel?.font = UIFont(name: FONT_MEDIUM , size: 20.0)
        nextQuestionButton.frame = CGRectMake(50, 600, 300, 50)
        nextQuestionButton.layer.cornerRadius = 5.0
        nextQuestionButton.addTarget(self, action: #selector(self.nextQuestionButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(nextQuestionButton)
    }
    
    func initializeAnswerPicker() {
        self.view.addSubview(answerPicker)
        answerPicker.tintColor = COLOR_TINT
        answerPicker.dataSource = self
        answerPicker.delegate = self
    }
    
    func initializeResultsButton(){
        resultsButton.setTitle("Results", forState: UIControlState.Normal)
        resultsButton.frame = CGRectMake(300, 12, 75, 50)
        resultsButton.layer.cornerRadius = 5.0
        resultsButton.titleLabel?.font = UIFont(name: FONT_MEDIUM , size: 20.0)
        resultsButton.setTitleColor(COLOR_TEXT, forState: UIControlState.Normal)
        resultsButton.backgroundColor = COLOR_TINT
        
        resultsButton.addTarget(self, action: #selector(self.segueToChart), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(resultsButton)
    }
    
    /**
     * When the Submit Button is pressed, present the next question. If we are out of questions, segue to the next controller
     *
     * - Parameters:
     *   - UIButton: The Button that is pressed
     */
    func nextQuestionButtonPressed(sender: UIButton!) {
        
        let score: NSInteger? = self.answerData
        let entry = Entry(question: questionList[mainQuestionIndex], score: score!)
        
        scoresheet.entries.append(entry)

        mainQuestionIndex += 1
        
        if (mainQuestionIndex == questionList.count)  {
            SteadyAPI.postScoresheet(scoresheet,
                                     successCallback:successfulPostCallback,
                                     failureCallback: nil)
            return
        }
        
        self.questionLabel.updateQuestion(questionList[mainQuestionIndex])

    }
    
    func successfulPostCallback(data: NSDictionary) {
        segueToChart()
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
        answerData = Int(pickerData[row])!
    }
}

