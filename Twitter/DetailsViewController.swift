//
//  DetailsViewController.swift
//  Twitter
//
//  Created by Jeanne Nina on 2/25/16.
//  Copyright © 2016 Nina. All rights reserved.
//

import UIKit
import AFNetworking

class DetailsViewController: UIViewController {
    
    var tweets: Tweet!
    
    @IBOutlet weak var profilePhotoView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var statsView: UIView!
    
    var retweeted = false
    var favorited = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilePhotoView.layer.cornerRadius = 5
        profilePhotoView.clipsToBounds = true
        
        statsView.layer.borderColor = UIColor.blackColor().CGColor
        
        profilePhotoView.setImageWithURL((tweets.user!.userPhotoUrl)!)
        nameLabel.text = tweets.user!.name!
        screennameLabel.text = "@\(tweets!.user!.screenname!)"
        tweetLabel.text = tweets.text!
        timestampLabel.text = tweets.createdAt!
        
        favoriteCountLabel.text = "\(tweets.favoritesCount!)"
        retweetCountLabel.text = "\(tweets.retweetCount!)"
        
        
        if favoriteCountLabel.text == "0" {
            favoriteCountLabel.hidden = true
            favoriteLabel.hidden = true
        } else if favoriteCountLabel.text == "1" {
            favoriteCountLabel.hidden = false
            favoriteLabel.hidden = false
            favoriteLabel.text = "FAVORITE"
        } else {
            favoriteLabel.text = "FAVORITES"
        }
        
        if retweetCountLabel.text == "0" {
            retweetCountLabel.hidden = true
            retweetLabel.hidden = true
        } else if retweetCountLabel.text == "1" {
            retweetCountLabel.hidden = false
            retweetLabel.hidden = false
            retweetLabel.text = "RETWEET"
        } else {
            retweetLabel.text = "RETWEETS"
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
        if !retweeted {
            retweeted = true
            sender.setImage(UIImage(named: "retweet-action-on-green"), forState: UIControlState.Normal)
            if retweetCountLabel.text == "0" {
                retweetCountLabel.hidden = false
                retweetLabel.hidden = false
            } else if retweetCountLabel.text == "1" {
                retweetCountLabel.hidden = false
                retweetLabel.hidden = false
                retweetLabel.text = "RETWEET"
            }
            retweetCountLabel.text = String(tweets.retweetCount!+1)
        } else {
            retweeted = false
            sender.setImage(UIImage(named:"retweet-action_default"), forState: UIControlState.Normal)
            retweetCountLabel.text = String(tweets.retweetCount!)
        }

    }

    @IBAction func onFavorites(sender: AnyObject) {
        if !favorited {
            favorited  = true
            sender.setImage(UIImage(named: "like-action-on-red"), forState: UIControlState.Normal)
            if favoriteCountLabel.text == "0" {
                favoriteCountLabel.hidden = false
                favoriteLabel.hidden = false
            } else if favoriteCountLabel.text == "1" {
                favoriteCountLabel.hidden = false
                favoriteLabel.hidden = false
                favoriteLabel.text = "FAVORITE"
            }
            favoriteCountLabel.text = String(tweets.favoritesCount!+1)
        } else {
            favorited = false
            sender.setImage(UIImage(named: "like-action-off"), forState: UIControlState.Normal)
            favoriteCountLabel.text = String(tweets.favoritesCount!)
        }

    }
    
    @IBAction func cancelComposedTweet(segue:UIStoryboardSegue) {
    }
    
    @IBAction func saveComposedTweet(segue:UIStoryboardSegue) {
    }
    
   
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ComposeNewTweetSegue" {
        let tweet = tweets!
        
        // Get the new view controller using segue.destinationViewController.
        let composeViewController = segue.destinationViewController as! ComposeViewController
            
        // Pass the selected object to the new view controller.
        composeViewController.tweets = tweet
        }
       
    }
    

}
