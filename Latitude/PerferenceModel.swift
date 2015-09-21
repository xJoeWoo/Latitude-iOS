//
//  UserDefaultsModel.swift
//  Latitude
//
//  Created by Ng Zoujiu on 15/9/16.
//  Copyright (c) 2015年 Ng. All rights reserved.
//

import Foundation

class PreferenceModel {
    
    struct Keys {
        static let UserName = "username"
    }
    
    class func getString(key: String) -> String? {
        return NSUserDefaults.standardUserDefaults().valueForKey(key) as? String
    }
    
    class func getBool(key: String) -> Bool? {
        return NSUserDefaults.standardUserDefaults().boolForKey(key)
    }
    
    class func saveString(key: String, value: String) {
        NSUserDefaults.standardUserDefaults().setObject(value, forKey: key)
    }
    
    class func saveBool(key: String, value: Bool) {
        NSUserDefaults.standardUserDefaults().setBool(value, forKey: key)
    }
}
