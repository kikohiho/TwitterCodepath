//
//  TweetsViewController.swift
//  Twitter Codepath
//
//  Created by Ricardo Vila on 2/24/16.
//  Copyright © 2016 Ricardo Vila. All rights reserved.
//

import UIKit
import AFNetworking

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var TableViewOutlet: UITableView!
    
    var tweets: [Tweet]!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        TwitterClient.sharedInstance.homeTimeline({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            
            for tweet in tweets {
                
                print(tweet.text)
                
            }
        }, failure: { (error: NSError) -> () in
            print(error.localizedDescription)
        })
        
        
        // Do any additional setup after loading the view.
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
        
        cell.selectionStyle = .None
        
        
        print ("row \(indexPath.row)")
        return cell
        
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onLogoutButton(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
        
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
