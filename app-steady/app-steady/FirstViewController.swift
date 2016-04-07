//
//  FirstViewController.swift
//  app-steady
//
//  Created by Andrew Demoleas on 4/6/16.
//  Copyright © 2016 Hawt-Lava. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var nextQuestionButton: UIButton!
    
    var mainQuestion = nextQuestion()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        questionLabel.text = mainQuestion.askQuestion
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextQuestionButtonPressed(sender: AnyObject) {
        self.mainQuestion = nextQuestion()
        self.questionLabel.text = mainQuestion.askQuestion
    }
}

