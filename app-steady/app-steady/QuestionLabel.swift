//
//  QuestionLabel.swift
//  app-steady
//
//  Created by Daniel.Habib on 4/29/16.
//  Copyright © 2016 Hawt-Lava. All rights reserved.
//

import UIKit

class QuestionLabel: UILabel {
    
    var question: Question = Question(text: "", id: 0)
    
    
    func updateQuestion (newQuestion : Question)
    {
        question = newQuestion
        text = question.text
    }
}
