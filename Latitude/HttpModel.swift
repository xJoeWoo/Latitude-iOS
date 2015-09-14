//
//  HttpModel.swift
//  Latitude
//
//  Created by Ng Zoujiu on 15/9/13.
//  Copyright (c) 2015年 Ng. All rights reserved.
//

import Foundation
import SwiftyJSON

class HttpModel {
    
    enum Result {
        case Value(JSON)
        case Error(NSError)
        init(_ e: NSError!, _ v: JSON) {
            if let ex = e {
                self = Result.Error(ex)
            } else {
                self = Result.Value(v)
            }
        }
    }
    
    class func getJson(url: String, _ params: Dictionary<String,String>, completionHandler: (result: Result) -> Void) {
        asyncPost(url, params) { (response, data, error) -> Void in
            
            var json: JSON!
            
            if let jsonData = data{
                
                var s = NSString(data: data, encoding: NSUTF8StringEncoding)!
                NSLog("%@", s)
                
                let jsonObject : AnyObject! = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)
                
                json = JSON(jsonObject)

                
            }
            
            completionHandler(result: Result(error, json))
            
        }
    }
    
    class func asyncPost(url: String, _ params: Dictionary<String,String>, result: (NSURLResponse!, NSData!, NSError!) -> Void) {
        var url = NSURL(string: url)!
        var request = NSMutableURLRequest(URL: url)
        request.timeoutInterval = 6
        request.HTTPMethod = "POST"
        request.HTTPBody = convertDictToData(params)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(),completionHandler: result)
    }
    
    private class func convertDictToData(params: Dictionary<String,String>) -> NSData {
        var dataStr = ""
        
        for (param, value) in params {
            if count(dataStr) > 0{
                dataStr += "&"
            }
            dataStr += (param + "=" + value)
        }
        return dataStr.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
    }
    
    struct Urls {
        static let LOGIN = "http://114.215.80.157/Home/Game/login"                     // account | password
        static let LOGON = "http://114.215.80.157/Home/Game/register"                  // account | password
        static let CHANGE_NAME = "http://114.215.80.157/Home/Game/name"                // name | token
        static let SET_SPOT = "http://114.215.80.157/Home/Game/setpoint"               // uid | title | snippet | latitude | longitude | force
        static let GET_SPOTS = "http://114.215.80.157/Home/Game/getpoint"              // 4 location
        static let CAPTURE_SPOT = "http://114.215.80.157/Home/Game/grabpoint"          // spotid | uid | force
        static let GET_SCORE = "http://114.215.80.157/Home/Game/getscore"              // uid | group
    }
    
    struct Params {
        static let ACCOUNT = "account"
        static let PASSWORD = "password"
        static let FORCE = "group"
        static let TOKEN = "token"
        static let STATE = "stete"
        static let NAME = "name"
        static let LATITUDE = "latitude"
        static let LONGITUDE = "longitude"
        static let ID = "id"
        static let USER_ID = "uid"
        static let SPOT_TITLE = "title"
        static let SPOT_SNIPPET = "context"
        static let LEFT_TOP_LATITUDE = "maxlatitude"
        static let LEFT_TOP_LONGITUDE = "minlongitude"
        static let RIGHT_BOTTOM_LATITUDE = "minlatitude"
        static let RIGHT_BOTTOM_LONGITUDE = "maxlongitude"
        static let SCORE_PLAYER = "score"
        static let SCORE_FORCE = "gscore"
    }
}