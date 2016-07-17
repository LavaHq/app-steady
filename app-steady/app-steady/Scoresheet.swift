//
//  Scoresheet.swift
//  app-steady
//
//  Created by Daniel.Habib on 4/29/16.
//  Copyright © 2016 Hawt-Lava. All rights reserved.
//

import UIKit

class Scoresheet: NSObject {
    var entries : [Entry]
    var id : NSInteger
    
    init(entries: [Entry], id: NSInteger = 0) {
        self.entries = entries
        self.id = id
    }
    
    func toDict() -> NSDictionary
    {

        var dictEntryList : [NSDictionary] = []
        
        for entry in entries
        {
            dictEntryList.append(entry.toDict())
        }
        
        let dict = ["entries" : dictEntryList, "device_id": device_id]
        
        return dict
    }
}
