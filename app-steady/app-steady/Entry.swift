//
//  Entry.swift
//  app-steady
//
//  Created by Daniel.Habib on 4/29/16.
//  Copyright © 2016 Hawt-Lava. All rights reserved.
//

import UIKit

class Entry: NSObject {
    var score : NSInteger
    var id : NSInteger
    var question : Question
    
    init(question: Question, score: NSInteger = 0, id: NSInteger = 0) {
        self.id = id
        self.score = score
        self.question = question
    }
    
    func toDict() -> NSDictionary
    {
        return [
            "score": score,
            "prompt": question.id
        ]
    }
    
}
