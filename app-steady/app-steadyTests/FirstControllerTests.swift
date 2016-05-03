//
//  FirstControllerTests.swift
//  app-steady
//
//  Created by Daniel.Habib on 5/2/16.
//  Copyright © 2016 Hawt-Lava. All rights reserved.
//

import XCTest


@testable import app_steady

class FirstControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
//        self.faker = Faker(locale: "nb-NO")
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBuildQuestions() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let fcv = FirstViewController()
        
        let questions = [
            QuestionStub.generateStub()
        ]
        
        let result = fcv.buildQuestions(questions)
        XCTAssertEqual(result[0].text, questions[0]["text"] as? String)
        XCTAssertEqual(result[0].id, questions[0]["id"] as? Int)
    }
//TODO: Implemet Tests for Next Button
//    func testNextButtonPressed() {
//        let fcv = FirstViewController()
//        fcv.
//        fcv.nextQuestionButtonPressed(UIButton())
//        
//    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
