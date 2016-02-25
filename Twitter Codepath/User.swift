//
//  User.swift
//  Twitter Codepath
//
//  Created by Ricardo Vila on 2/24/16.
//  Copyright © 2016 Ricardo Vila. All rights reserved.
//

import UIKit

let currentUserKey = "CurrentUserKey"

var _currentUser: User?

class User: NSObject {
    var name: NSString?
    var screenname: NSString?
    var profileURL: NSURL?
    var tagline: NSString?
    
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        
        screenname = dictionary["screen_name"] as? String
        
        let profileURLString = dictionary["profile_image_url_https"] as? String
        if let profileURLString = profileURLString {
            profileURL = NSURL(string: profileURLString)
        }
        
        tagline = dictionary["description"] as? String
        
    }
    
    //static var _currentUser: User?
    
    static let userDidLogoutNotification = "UserDidLogout"
    
    
    class var currentUser: User? {
        get {
        if _currentUser == nil {
        let data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
        
        if data != nil {
        let dictionary: NSDictionary?
        do {
        try dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
        _currentUser = User(dictionary: dictionary!)
    }catch {
        print(error)
        }
    }
        else {
        print("No User data")
        }
        }
        return _currentUser
        }
        set(user) {
            _currentUser = user
            if _currentUser != nil {
                var data: NSData?
                
                do {
                    try data = NSJSONSerialization.dataWithJSONObject(user!.dictionary!, options: .PrettyPrinted)
                    NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
                } catch {
                    print(error)
                }
            }
            else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
}
