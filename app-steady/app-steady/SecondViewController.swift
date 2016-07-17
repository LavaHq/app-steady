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
    
    var items: Dictionary<Int, Any> = [:]
    
    var scoresheets : NSArray = []
    
    let numberOfPrompts = 3 // TODO make this value dynamic
    
    var questions = Array(prompts.keys)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("start prompts: \(Array(prompts.keys))")
        // Do any additional setup after loading the view, typically from a nib.
        func successfulScoresheetFetch(data: NSArray){
            // Update the page with the scoresheet data
            scoresheets = data
            reformatResults(scoresheets)
            self.initializeTableView()
        }
        
        SteadyAPI.getScoresheets(successfulScoresheetFetch, failureCallback: nil)
    }
    
    func reformatResults(scoresheets: NSArray) -> Dictionary<Int, Any> {
        
        
        var results: Dictionary<Int, Any> = [:]
        for (id, _) in prompts {
            results[id] = []
        }
        print(scoresheets)
        for scoresheet in scoresheets  {
            // Loop through
        let date = scoresheet["created"] as! String
            for entry in scoresheet["entries"] as! NSArray {
                let promptId = entry["prompt"] as! NSInteger
                let score = entry["score"] as! NSInteger
                let promptValues = results[promptId] as! NSArray
                let mutable = NSMutableArray.init(array: promptValues)
                mutable.addObject([date, score])
                results[promptId] = mutable
            }
        }
        items = results
        return results
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
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell:GraphicalTableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! GraphicalTableViewCell
        
        let cell : GraphicalTableViewCell = GraphicalTableViewCell.init()
        let index = indexPath.row
        let questionId = Array(prompts.keys)[index]
        let entries = items[questionId] as! NSMutableArray
        
        cell.initializeLineChart(entries)
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
