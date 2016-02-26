//
//  TweetCell.swift
//  Twitter
//
//  Created by Jeanne Nina on 2/22/16.
//  Copyright © 2016 Nina. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var profilePhotoView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var retweetCountLabel: UILabel!
    
    var retweeted = false
    var favorited = false
    
    var tweet: Tweet! {
        didSet {
            profilePhotoView.setImageWithURL(NSURL(string: (tweet.user!.profileImageUrl)!)!)
            nameLabel.text = tweet.user?.name
            screennameLabel.text = "@\(tweet.user!.screenname!)"
            timestampLabel.text = tweet.timeSince
            tweetLabel.text = tweet.text
            favoriteCountLabel.text = "\(tweet.favoritesCount!)"
            retweetCountLabel.text = "\(tweet.retweetCount!)"
            
            if favoriteCountLabel.text == "0" {
                favoriteCountLabel.hidden = true
            }
            if retweetCountLabel.text == "0" {
                retweetCountLabel.hidden = true
            }
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        profilePhotoView.layer.cornerRadius = 5
        profilePhotoView.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onFavorites(sender: AnyObject) {
        if !favorited {
            favorited  = true
            sender.setImage(UIImage(named: "like-action-on-red"), forState: UIControlState.Normal)
            if favoriteCountLabel.text == "0" {
                favoriteCountLabel.hidden = false
            }
            favoriteCountLabel.text = String(tweet.favoritesCount!+1)
        } else {
            favorited = false
            sender.setImage(UIImage(named: "like-action-off"), forState: UIControlState.Normal)
            favoriteCountLabel.text = String(tweet.favoritesCount!)
        }
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
        if !retweeted {
            retweeted = true
            sender.setImage(UIImage(named: "retweet-action-on-green"), forState: UIControlState.Normal)
            if retweetCountLabel.text == "0" {
                retweetCountLabel.hidden = false
            }
            retweetCountLabel.text = String(tweet.retweetCount!+1)
        } else {
            retweeted = false
            sender.setImage(UIImage(named:"retweet-action_default"), forState: UIControlState.Normal)
            retweetCountLabel.text = String(tweet.retweetCount!)
        }
    }
}