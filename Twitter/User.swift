//
//  User.swift
//  Twitter
//
//  Created by 蔡 侑儒 on 2017/9/13.
//  Copyright © 2017年 UzooStudio. All rights reserved.
//

import UIKit
import SwiftyJSON
struct User {
    let name:String
    let title:String
    let bioText:String
    let profileImage:UIImage
    init(json:JSON) {
        self.name = json["name"].stringValue
        self.title = json["username"].stringValue
        self.bioText = json["bio"].stringValue
        self.profileImage = UIImage()
        
    }
}
