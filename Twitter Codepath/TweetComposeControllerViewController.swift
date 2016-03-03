//
//  TweetComposeControllerViewController.swift
//  Twitter Codepath
//
//  Created by Ricardo Vila on 2/28/16.
//  Copyright © 2016 Ricardo Vila. All rights reserved.
//

import UIKit
import DoneHUD

class TweetComposeControllerViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var twitterusernameLabel: UILabel!
    @IBOutlet weak var tweettextView: UITextView!
    
    var replyhandle: String?
    var tweetId: String?
    var isReply: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let profileURL = User.currentUser!.profileURL
        profileImage.setImageWithURL(profileURL!)
        
        usernameLabel.text = User.currentUser!.name
        twitterusernameLabel.text = User.currentUser!.screenname 
        
        tweettextView.delegate = self
        tweettextView.becomeFirstResponder()
        
        // Do any additional setup after loading the view.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func postTweet(sender: AnyObject) {
        DoneHUD.showInView(self.view, message: "Done")
        
        if isReply == true {
            TwitterClient.sharedInstance.replyTweet(tweetId, userID: "\(tweettextView.text)")
        } else {
            TwitterClient.sharedInstance.composeTweet(tweettextView.text)
        }
        
        replyhandle = ""
        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 2 * Int64(NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) {
            //put your code which should be executed with a delay here
            self.dismissViewControllerAnimated(true, completion: nil)
        }

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
