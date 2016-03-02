//
//  User.swift
//  Twitter
//
//  Created by Jeanne Nina on 2/21/16.
//  Copyright © 2016 Nina. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "kCurrentUserKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"

class User: NSObject {
    
    var name: String?
    var screenname: String?
    var profileImageUrl: String?
    var userPhotoUrl: NSURL?
    var tagline: String?
    var dictionary: NSDictionary?

    
    var userTweetCount: Int?
    var userFollowerCount: Int?
    var userFollowingCount: Int?
    var profileBackgroundImageUrl: String?
    var coverPhotoUrl: NSURL?
    
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        profileImageUrl = dictionary["profile_image_url_https"] as? String
        tagline = dictionary["description"] as? String
        
        profileBackgroundImageUrl = dictionary["profile_background_image_url_https"] as? String
        
        userTweetCount = dictionary["statuses_count"] as? Int
        userFollowerCount = dictionary["friends_count"] as? Int
        userFollowingCount = dictionary["followers_count"] as? Int
        
        if profileImageUrl != nil {
            userPhotoUrl = NSURL(string: profileImageUrl!)!
        } else {
            userPhotoUrl = nil
        }
        
        if profileBackgroundImageUrl != nil {
            coverPhotoUrl = NSURL(string: profileBackgroundImageUrl!)!
        } else {
            coverPhotoUrl = nil
        }
    }
    
    func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }

    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = NSUserDefaults.standardUserDefaults()
                let userData = defaults.objectForKey(currentUserKey) as? NSData
        
                if userData != nil {
                    let dictionary: NSDictionary?
                    
                    do {
                        try dictionary = NSJSONSerialization.JSONObjectWithData(userData!, options: .MutableContainers) as? NSDictionary
                        _currentUser = User(dictionary: dictionary!)
                    } catch {
                        print(error)
                    }
                }
            }
            return _currentUser
        }
        
        set(user) {
            _currentUser = user
            //User needs to implement NSCoding but JSON has it serialized by default
            if let _ = _currentUser {
                var userData: NSData?
                do {
                    try userData = NSJSONSerialization.dataWithJSONObject(user!.dictionary!, options: .PrettyPrinted)
                    NSUserDefaults.standardUserDefaults().setObject(userData, forKey: currentUserKey)
                } catch {
                    print(error)
                }
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
}