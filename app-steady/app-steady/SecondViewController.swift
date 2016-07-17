//
//  SecondViewController.swift
//  app-steady
//
//  Created by Andrew Demoleas on 4/6/16.
//  Copyright © 2016 Hawt-Lava. All rights reserved.
//

import UIKit
import Charts

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var days: [String]!
    
    var tableView: UITableView  =   UITableView()
    
    var items: [String] = ["Viper", "X", "Games"]
    
    var scoresheets : NSArray = []
    
    let numberOfPrompts = 3 // TODO make this value dynamic
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        func successfulScoresheetFetch(data: NSArray){
            // Update the page with the scoresheet data
            
            print("Data: \(data)")
            scoresheets = data
            self.initializeTableView()
        }
        
        SteadyAPI.getScoresheets(successfulScoresheetFetch, failureCallback: nil)
    }
    
    func reformatResults(scoresheets: NSArray) -> Dictionary<String, Any> {
        
        
        var results: Dictionary<String, Any> = [:
//                    "prompt 1": [[0, 5], [1,2]],
//                    "prompt 2": [[0, 7], [1,6]],
//                    "prompt 3": [[0, 10], [3,4]],
                ]
        for prompt in prompts {
            results[prompt] = []
        }
        for value in scoresheets {
            // Loop through 
        }
        
        
        
        return results
//
//        return [
//            "prompt 1": [[0, 5], [1,2]],
//            "prompt 2": [[0, 7], [1,6]],
//            "prompt 3": [[0, 10], [3,4]],
//        ]
    }
    
    
    func initializeTableView(){
        tableView.frame         =   CGRectMake(0, 100, self.view.frame.width, self.view.frame.height - 100);
        tableView.delegate      =   self
        tableView.dataSource    =   self
        tableView.registerClass(GraphicalTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = (self.view.frame.height - 110) / 3
        self.view.addSubview(tableView)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.scoresheets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell:GraphicalTableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! GraphicalTableViewCell
        
        let cell : GraphicalTableViewCell = GraphicalTableViewCell.init()
        
        
        cell.initializeLineChart()
        cell.backgroundColor = UIColor.redColor()
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
