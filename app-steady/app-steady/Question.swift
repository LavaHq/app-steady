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
}



