//
//  Questions.swift
//  app-steady
//
//  Created by Andrew Demoleas on 4/6/16.
//  Copyright © 2016 Hawt-Lava. All rights reserved.
//

import Foundation

struct Question {
    var askQuestion: String
}

//List of questions
let q1 = Question(askQuestion: "Did you do your best to be happy?")
let q2 = Question(askQuestion: "Did you do your best to find meaning?")
let q3 = Question(askQuestion: "Did you do your best to set clear goals?")
let q4 = Question(askQuestion: "Did you do your best to reach your goals?")
let q5 = Question(askQuestion: "Did you do your best to build positive relationships?")
let q6 = Question(askQuestion: "Did you do your best to be fully engaged?")
let q7 = Question(askQuestion: "Did you do your best to eat healthy?")
let q8 = Question(askQuestion: "Did you do your best to keep a good posture?")
let q9 = Question(askQuestion: "Did you do your best to get a good night's sleep?")
let q0 = Question(askQuestion: "Did you do your best to work on programming?")

let finished = Question(askQuestion: "All Done!")

let questionsList = [q1, q2, q3, q4, q5, q6, q7, q8, q9, q0]

var questionIndex = 0

func nextQuestion() -> Question {
    if questionIndex == questionsList.count{
        return finished
    }
        let question = questionsList[questionIndex]
        questionIndex += 1
        return question
}
