//
//  HttpModel.swift
//  Latitude
//
//  Created by Ng Zoujiu on 15/9/13.
//  Copyright (c) 2015年 Ng. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class HttpModel {
    
    enum Result {
        case Value(JSON)
        case Error(NSError)
        init(_ e: NSError?, _ v: JSON) {
            if let ex = e {
                self = Result.Error(ex)
            } else {
                self = Result.Value(v)
            }
        }
    }
    
    class func getJson(url: String, _ params: Dictionary<String,String>, completionHandler: (result: Result) -> Void) {
        doPost(url, params) { (data, error) -> Void in
            var json: JSON?
            if let jsonData = data{
                
                var s = NSString(data: jsonData, encoding: NSUTF8StringEncoding)!
                NSLog("%@", s)
                
                let jsonObject: AnyObject! = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)
                json = JSON(jsonObject)
            }
            
            completionHandler(result: Result(error, json!))
            
            
        }
    }
    
    class func doPost(url: String, _ params: Dictionary<String,String>, result: (data: NSData?, error: NSError?) -> Void) {
        Alamofire.request(Alamofire.Method.POST, url, parameters: params, encoding: ParameterEncoding.URL, headers: nil).response { (_, _, data, error) -> Void in
            result(data: data, error: error)
        }
    }
    
    struct Urls {
        static let Login = "http://114.215.80.157/Home/Game/login"                     // account | password
        static let Logon = "http://114.215.80.157/Home/Game/register"                  // account | password | force | n
        static let ChangeName = "http://114.215.80.157/Home/Game/name"                // name | token
        static let SetSpot = "http://114.215.80.157/Home/Game/setpoint"               // uid | title | snippet | latitude | longitude | force
        static let GetSpots = "http://114.215.80.157/Home/Game/getpoint"              // 4 location
        static let CaptureSpot = "http://114.215.80.157/Home/Game/grabpoint"          // spotid | uid | force
        static let GetScore = "http://114.215.80.157/Home/Game/getscore"              // uid | group
    }
    
    struct Params {
        static let Account = "account"
        static let Password = "password"
        static let Force = "group"
        static let Token = "token"
        static let State = "state"
        static let Name = "name"
        static let Latitude = "latitude"
        static let Longitude = "longitude"
        static let Id = "id"
        static let UserId = "uid"
        static let SpotTitle = "title"
        static let SpotSnippet = "context"
        static let LeftTopLatitude = "maxlatitude"
        static let LeftTopLongitude = "minlongitude"
        static let RightBottomLatitude = "minlatitude"
        static let RightBottomLongitude = "maxlongitude"
        static let ScorePlayer = "score"
        static let ScoreForce = "gscore"
    }
}