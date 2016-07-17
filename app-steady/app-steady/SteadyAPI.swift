//
//  SteadyAPI.swift
//  app-steady
//
//  Created by Daniel.Habib on 5/2/16.
//  Copyright © 2016 Hawt-Lava. All rights reserved.
//

import UIKit
import Alamofire

let API_URI = "http://localhost:8000"
let ENDPOINT_PROMPTS = "/prompts"
let ENDPOINT_ENTRIES = "/entries"
let ENDPOINT_SCORESHEETS = "/scoresheets"

class SteadyAPI: NSObject {

    /**
     * Handles saving the Scoresheet of the days
     *
     * - Parameters:
     *   - Scoresheet: A populated scoresheet that is ready to be saved
     */
    static func postScoresheet(scoresheet: Scoresheet,
                               successCallback: (NSDictionary -> Void)?,
                               failureCallback: (NSError -> Void)?) {
        
        let params = scoresheet.toDict()
        let url = self.generateUrlForPostingScoresheet()
        self.POST(url,
                  params: params,
                  successCallback: successCallback,
                  failureCallback: failureCallback)
    }
    /**
     * Get Scoresheets for the specific user to this device from the api
     *
     */
    static func getScoresheets() {
        let url = self.generateUrlForGettingScoresheets()
        
        func success (data: NSArray) {
            // This function should trigger graphs to update here when successful
            
        }
        func fail (error: NSError) {
            // Some Issue occured
        }
        
        self.GET(url, successCallback: success, failureCallback: fail)
    }
    
    static func generateUrlForGettingScoresheets() -> String {
        let device_id = ""
        return "\(API_URI)\(ENDPOINT_PROMPTS)?device_id=\(device_id)"
    }
    static func generateUrlForPostingScoresheet() -> String{
        return "\(API_URI)\(ENDPOINT_SCORESHEETS)"
    }
    
    static func GET(endpoint: String, successCallback: ((NSArray) -> Void)?, failureCallback: ((NSError) -> Void)?){
        
        Alamofire.request(.GET, API_URI + endpoint) .responseJSON { response in switch response.result{
        case.Success(_):
            
            let results :NSArray = response.result.value!["results"] as! NSArray
            
            if (successCallback != nil)
            {
                successCallback!(results)
            }
            
        case.Failure(let error):
            print("Request failed with error: \(error)")
            if (failureCallback != nil){
                failureCallback!(error)
            }
            }
        }
    }
    
    static func POST(endpoint: String, params: NSDictionary, successCallback: ((NSDictionary) -> Void)?, failureCallback: ((NSError) -> Void)?){
        
        Alamofire.request(.POST, API_URI + endpoint, parameters: params as? [String : AnyObject], encoding: .JSON).responseJSON
            { response in switch response.result {
            case .Success(let JSON):
                print("Success with JSON: \(JSON)")
                
                let result = JSON as! NSDictionary
                if (successCallback != nil)
                {
                    successCallback!(result)
                }
            case .Failure(let error):
                print("Request failed with error: \(error)")
                if (failureCallback != nil){
                    failureCallback!(error)
                }
            }
        }
    }
}
