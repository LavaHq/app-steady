//
//  SteadyAPI.swift
//  
//
//  Created by Daniel.Habib on 5/2/16.
//
//

import UIKit
import Alamofire

let API_URI = "http://localhost:8000"
let ENDPOINT_PROMPTS = "/prompts"
let ENDPOINT_ENTRIES = "/entries"
let ENDPOINT_SCORESHEETS = "/scoresheets"

class SteadyAPI: NSObject {
    
    
    static func GET(endpoint: String, successCallback: (NSArray) -> Void){
        
        Alamofire.request(.GET, API_URI + endpoint) .responseJSON { response in // 1
    
            let results :NSArray = response.result.value!["results"] as! NSArray
    
            successCallback(results)
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
                
                //example if there is an id
                //                let userId = response.objectForKey("id")!
            case .Failure(let error):
                print("Request failed with error: \(error)")
                if (failureCallback != nil){
                    failureCallback!(error)
                }
            }
        }
    }
}
