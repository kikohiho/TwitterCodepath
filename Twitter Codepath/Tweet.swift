//
//  Tweet.swift
//  Twitter Codepath
//
//  Created by Ricardo Vila on 2/24/16.
//  Copyright © 2016 Ricardo Vila. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: NSString?
    var timestamp: NSDate?
    var retweetCount: Int?
    var favoritesCount: Int?
    var readDate: NSTimeInterval?
    var retweetState: Bool?
    var tweetId: String?
    
    init(dictionary: NSDictionary) {
        
        
        user = User(dictionary: (dictionary["user"] as? NSDictionary)!)
        
        
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        
        let timeStampString = dictionary["created_at"] as? String
        
        
        if let timeStampString = timeStampString {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.dateFromString(timeStampString)
            readDate = timestamp?.timeIntervalSinceNow
        }
        
        retweetState = dictionary["retweeted"] as? Bool
        
        tweetId = dictionary["id_str"] as? String
        
        
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            
            tweets.append(tweet)
        }
        
        return tweets
    }
    
    static func stringFromTimeInterval(interval:NSTimeInterval) -> String {
        
        let ti = NSInteger(interval)
        
        //let ms = Int((interval % 1) * 1000)
        
        let seconds = ti % 60
        let minutes = (ti / 60) % 60
        let hours = (ti / 3600)
        if(-hours > 0)
        {
            return String(format: "%0.2d" + "h", -hours)
        } else if(-minutes > 0)
        {
            return String(format: "%0.2d" + "m", -minutes)
        } else
        {
            return String(format: "%0.2d" + "s", -seconds)
        }
        
        
        
    }
}
