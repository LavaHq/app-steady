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
    let backButton = UIButton(type: UIButtonType.System)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = COLOR_BACKGROUND
        func successfulScoresheetFetch(data: NSArray){
            // Update the page with the scoresheet data
            scoresheets = data
            reformatResults(scoresheets)
            self.initializeTableView()
            self.initializeConstraints()
        }
        SteadyAPI.getScoresheets(successfulScoresheetFetch, failureCallback: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        func successfulUpdateScoresheetFetch(data: NSArray){
            // Update the page with the scoresheet data
            scoresheets = data
            reformatResults(scoresheets)
            tableView.reloadData()
        }
        if (scoresheets.count > 0) {
            SteadyAPI.getScoresheets(successfulUpdateScoresheetFetch, failureCallback: nil)
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return navigationController?.hidesBarsOnSwipe ?? true
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
        tableView.delegate      =   self
        tableView.dataSource    =   self
        tableView.registerClass(GraphicalTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = (self.view.frame.height - 120) / 2
        tableView.sectionHeaderHeight = 70
        tableView.translatesAutoresizingMaskIntoConstraints = false
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
        let entries = items[questionId] as! [[AnyObject]]
        
        cell.initializeLineChart(entries, questionText: prompts[questionId]!)
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.backgroundColor = COLOR_BACKGROUND
        cell.initializeConstraints()
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 60))
        
        initializeBackButton(headerView)
        return headerView
    }
    func initializeBackButton(parentView: UIView){
        let origImage = UIImage(named: "BackButton.png");
        let tintedImage = origImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        backButton.setImage(tintedImage, forState: .Normal)
        backButton.tintColor = COLOR_TEXT
        backButton.frame = CGRectMake(0, 20, 40, 40)
        backButton.addTarget(self, action: #selector(self.backAction), forControlEvents: .TouchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        parentView.addSubview(backButton)

    }
    
    func backAction() -> Void {
        tabBarController?.selectedIndex = 0
    }
    
    func initializeConstraints() {
        
        var allConstraints = [NSLayoutConstraint]()
        let viewsFromTheSix = [
            "tableView": tableView,

        ]
    
        //Results Button
        
        let horizontalTableViewConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "|[tableView]|",
            options: [],
            metrics: nil,
            views: viewsFromTheSix)
        
        allConstraints += horizontalTableViewConstraints
        
        let verticalTableViewConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|[tableView]|",
            options: [],
            metrics: nil,
            views: viewsFromTheSix)
        
        allConstraints += verticalTableViewConstraints
        NSLayoutConstraint.activateConstraints(allConstraints)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
