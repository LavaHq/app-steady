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

    var scoresheets : [String: Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        func successfulScoresheetFetch(data: NSArray){
            // Update the page with the scoresheet data
            print(data)
            
            
        }
        
        SteadyAPI.getScoresheets(successfulScoresheetFetch, failureCallback: nil)
        
        self.initializeTableView()
    }
    
    func initializeTableView(){
        tableView.frame         =   CGRectMake(0, 100, self.view.frame.width, self.view.frame.height - 100);
        tableView.delegate      =   self
        tableView.dataSource    =   self
//        tableView.backgroundColor = UIColor.blueColor()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = (self.view.frame.height - 110) / 3
        self.view.addSubview(tableView)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell:GraphicalTableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! GraphicalTableViewCell
        
        var cell : GraphicalTableViewCell = GraphicalTableViewCell.init()
//
        cell.initializeLineChart()
        cell.backgroundColor = UIColor.redColor()
        
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
