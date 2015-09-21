//
//  UserInfo.swift
//  Latitude
//
//  Created by Ng Zoujiu on 15/9/14.
//  Copyright (c) 2015年 Ng. All rights reserved.
//

import Foundation

public struct UserInfo {
    static var id: Int!
    static var account: String!
    static var token: String!
    static var name: String!
    static var force: Force!
    static var score: Int!
    static var fscore: Int!
}

enum Force: Int {
    case One = 0
    case Two = 1
}