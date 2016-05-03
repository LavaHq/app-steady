//
//  Quesiton.swift
//  app-steady
//
//  Created by Daniel.Habib on 4/28/16.
//  Copyright © 2016 Hawt-Lava. All rights reserved.
//

import UIKit

class Question : NSObject {
    var text : String = ""
    var id : NSInteger = 0
    
    init(text: String, id: NSInteger) {
        super.init()
        self.text = text
        self.id = id
    }
    
    static func deserializeQuestion(dict: NSDictionary) -> Question{
        let text: String = dict["text"] as! String
        let id: NSInteger = dict["id"] as! NSInteger
        return Question(text: text, id: id)
    }
}



