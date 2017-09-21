//
//  Service.swift
//  Twitter
//
//  Created by 蔡 侑儒 on 2017/9/16.
//  Copyright © 2017年 UzooStudio. All rights reserved.
//

import Foundation
import SwiftyJSON
import TRON

class Service{
    static let shardInstance = Service()
    
    let tron = TRON(baseURL: "https://api.letsbuildthatapp.com")
    
    class Home:JSONDecodable{
        var users:[User]
        var tweets:[Tweet]
        required init(json: JSON) throws {
            guard let _ = json["users"].array else {
                throw NSError(domain: "com.letbuildthatapp", code: 1, userInfo: ["message":"The Json format is incorrect"])
                print("ready to parse json object \(json)")
            }
            
            let usersJsonArray = json["users"].array
            self.users = (usersJsonArray?.map({return User(json:$0)}))!
            
            
            let tweetArray = json["tweets"].array
            self.tweets = (tweetArray?.map({return Tweet(json: $0)}))!
        }
    }
    class JsonError:JSONDecodable{
        required init(json: JSON) throws {
            print("yo, this is json error object")
        }
    }

    
    
    func fetchFeeds(completion:@escaping ([User]?,[Tweet]?,APIError<JsonError>?)->()){
        let request:APIRequest<Home,JsonError> = tron.request("/twitter/home_with_error")
        request.perform(withSuccess: { (home) in
            // parse json and turn to caller
            print("parse success")
            completion(home.users,home.tweets,nil)
        }) { (error) in
            print("something wrong, error=\(error)")
            completion(nil,nil,error)
        }

    }
}
