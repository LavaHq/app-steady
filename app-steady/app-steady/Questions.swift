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
var q1 = Question(askQuestion: "Did you do your best to be happy?")
var q2 = Question(askQuestion: "Did you do your best to find meaning?")
var q3 = Question(askQuestion: "Did you do your best to set clear goals?")
var q4 = Question(askQuestion: "Did you do your best to reach your goals?")
var q5 = Question(askQuestion: "Did you do your best to build positive relationships?")
var q6 = Question(askQuestion: "Did you do your best to be fully engaged?")
var q7 = Question(askQuestion: "Did you do your best to eat healthy?")
var q8 = Question(askQuestion: "Did you do your best to keep a good posture?")
var q9 = Question(askQuestion: "Did you do your best to get a good night's sleep?")
var q0 = Question(askQuestion: "Did you do your best to work on programming?")

var questionsList = [q1, q2, q3, q4, q5, q6, q7, q8, q9, q0]

var questionIndex = -1

func nextQuestion() -> Question {
        questionIndex += 1
        return questionsList[questionIndex]
}