//
//  Tweet.swift
//  Twitter
//
//  Created by Jeanne Nina on 2/21/16.
//  Copyright © 2016 Nina. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var user: User?
    var text: String?
    var createdAt: String?
    var timestamp: NSDate?
    var tweetId: String?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAt = dictionary["created_at"] as? String
        tweetId = dictionary["id_str"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        
        let timestampString = dictionary["created_at"] as? String
        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        timestamp = formatter.dateFromString(createdAt!)
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Month, .Day, .Year], fromDate: timestamp!)
        createdAt = "\(components.month)/\(components.day)/\(components.year%2000)"
        
    }

    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }
    
    

}
