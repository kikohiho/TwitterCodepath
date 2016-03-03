//
//  ProfileViewController.swift
//  Twitter Codepath
//
//  Created by Ricardo Vila on 3/1/16.
//  Copyright © 2016 Ricardo Vila. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var tweetsCount: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var TableViewOutlet: UITableView!
    
    var tweets: [Tweet]!
    var indexrow: Int?
    var screenname: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        /**
            self.nameLabel.text = String(tweets.user?.name)
            self.usernameLabel.text = String(user?.screenname)
            self.tweetsCount.text = String(user?.tweetsCount)
            self.followersCount.text = String(user?.followersCount)
            self.followingCount.text = String(user?.followingCount)
        **/
        
        
        let tweet = tweets![indexrow!]
        screenname = tweet.user?.screenname
        
        nameLabel.text = (tweet.user?.name)!
        nameLabel.sizeToFit()
        usernameLabel.text = ("@\((tweet.user?.screenname)!)")
        usernameLabel.sizeToFit()
        followersCount.text = (String(Int((tweet.user?.followersCount)!)))
        followingCount.text = String(Int((tweet.user?.followingCount)!))
        tweetsCount.text = String(Int((tweet.user?.tweetsCount)!))
        
        let profileURL = tweet.user?.profileURL
        profileImage.setImageWithURL(profileURL!)
        
        TableViewOutlet.dataSource = self
        TableViewOutlet.delegate = self
        TableViewOutlet.estimatedRowHeight = 150
        TableViewOutlet.rowHeight = UITableViewAutomaticDimension
        
        getUserTweets(screenname!)
        
        print("name: \(nameLabel.text)")
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getUserTweets(screenname: String) {
        TwitterClient.sharedInstance.userTimeline(screenname) { (tweets, error) -> () in
            self.tweets = tweets
            self.TableViewOutlet.reloadData()
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tweets != nil {
            return tweets!.count
        } else {
            return 0
        }
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = TableViewOutlet.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCellTableViewCell
        
        cell.tweet = tweets![indexPath.row]
        
        nameLabel.sizeToFit()
        usernameLabel.sizeToFit()
        tweetsCount.sizeToFit()
        followingCount.sizeToFit()
        followersCount.sizeToFit()
        
        self.TableViewOutlet.rowHeight = UITableViewAutomaticDimension
        cell.selectionStyle = .None
        
        
        print ("row \(indexPath.row)")
        return cell
        
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
