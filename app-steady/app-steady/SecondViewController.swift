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
    var questions = Array(prompts.keys)
        
    let numberOfPrompts = 3 // TODO make this value dynamic
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = COLOR_BACKGROUND
        func successfulScoresheetFetch(data: NSArray){
            // Update the page with the scoresheet data
            scoresheets = data
            reformatResults(scoresheets)
            self.initializeTableView()
        }
        
        SteadyAPI.getScoresheets(successfulScoresheetFetch, failureCallback: nil)
        
        initializeBackButton()
    }
    
    /*
     * Don't touch this function until API response is adjusted
     */
    func reformatResults(scoresheets: NSArray){
        
        
        var results: Dictionary<Int, Any> = [:]
        for (id, _) in prompts {
            results[id] = []
        }
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
    }
    
    func initializeTableView(){
        tableView.frame         =   CGRectMake(0, 100, self.view.frame.width, self.view.frame.height - 100);
        tableView.delegate      =   self
        tableView.dataSource    =   self
        tableView.registerClass(GraphicalTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = (self.view.frame.height - 120) / 3
        tableView.sectionHeaderHeight = 70
        tableView.backgroundColor = COLOR_BACKGROUND
        tableView.separatorColor = UIColor.clearColor()
        self.view.addSubview(tableView)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : GraphicalTableViewCell = GraphicalTableViewCell.init()
        let index = indexPath.row
        let questionId = Array(prompts.keys)[index]
        let entries = items[questionId] as! NSMutableArray
        
        cell.initializeLineChart(entries, questionText: prompts[questionId]!)
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
    
    func initializeBackButton(){
        let backbutton = UIButton(type: .Custom)
        backbutton.setImage(UIImage(named: "BackButton.png"), forState: .Normal)
        backbutton.setTitle("Back", forState: .Normal)
        backbutton.setTitleColor(backbutton.tintColor, forState: .Normal)
        backbutton.addTarget(self, action: #selector(SecondViewController.backAction), forControlEvents: .TouchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
        self.view.addSubview(backbutton)

    }
    
    func backAction() -> Void {
        self.navigationController?.popViewControllerAnimated(true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
