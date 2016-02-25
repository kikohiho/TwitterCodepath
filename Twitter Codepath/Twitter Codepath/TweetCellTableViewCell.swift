//
//  TweetCellTableViewCell.swift
//  Twitter Codepath
//
//  Created by Ricardo Vila on 2/24/16.
//  Copyright © 2016 Ricardo Vila. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    
    var dateString: String?
    var tweet: Tweet! {
        didSet {
            
            usernameLabel.text = tweet.user?.name as? String
            tweetText.text = tweet.text as? String
           // usernameLabel.text = "@\((tweet.user?.screenname)!)"
            
            dateString = Tweet.stringFromTimeInterval(tweet.readDate!)
            
            timestamp.text = "\(dateString!)"
            
            
            let imageUrl = tweet.user?.profileURL
            
            profileImage.setImageWithURL(imageUrl!)
            
        }
        
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
