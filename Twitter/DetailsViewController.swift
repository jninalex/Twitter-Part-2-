//
//  DetailsViewController.swift
//  Twitter
//
//  Created by Jeanne Nina on 2/25/16.
//  Copyright © 2016 Nina. All rights reserved.
//

import UIKit

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
    
    var retweeted = false
    var favorited = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profilePhotoView.layer.cornerRadius = 5
        profilePhotoView.clipsToBounds = true
        
        profilePhotoView.setImageWithURL(NSURL(string:(tweets.user?.profileImageUrl)!)!)
        nameLabel.text = tweets.user!.name!
        screennameLabel.text = "@\(tweets!.user!.screenname!)"
        tweetLabel.text = tweets.text!
        timestampLabel.text = tweets.createdAt!
        
        favoriteCountLabel.text = "\(tweets.favoritesCount!)"
        retweetCountLabel.text = "\(tweets.retweetCount!)"
        
        
        if favoriteCountLabel.text == "0" {
            favoriteCountLabel.hidden = true
            favoriteLabel.hidden = true
        }
        if retweetCountLabel.text == "0" {
            retweetCountLabel.hidden = true
            retweetLabel.hidden = true
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
            }
            favoriteCountLabel.text = String(tweets.favoritesCount!+1)
        } else {
            favorited = false
            sender.setImage(UIImage(named: "like-action-off"), forState: UIControlState.Normal)
            favoriteCountLabel.text = String(tweets.favoritesCount!)
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
