//
//  UserInfo.swift
//  Latitude
//
//  Created by Ng Zoujiu on 15/9/14.
//  Copyright (c) 2015年 Ng. All rights reserved.
//

import Foundation

public struct UserInfo {
    static var id: Int = -1
    static var account: String = ""
    static var token: String = ""
    static var name: String = "NG"
    static var force: Force!
    static var playerScore: Int = -1
    static var forceScore: Int = -1
}

enum Force: Int {
    case One = 0
    case Two = 1
}