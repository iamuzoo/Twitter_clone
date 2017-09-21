//
//  Tweet.swift
//  Twitter
//
//  Created by 蔡 侑儒 on 2017/9/14.
//  Copyright © 2017年 UzooStudio. All rights reserved.
//

import UIKit
import SwiftyJSON
struct Tweet {
    let user:User
    let tweet:String
    
    init(json:JSON) {
        self.user = User(json:json["user"])
        self.tweet = json["message"].stringValue
    }
}

