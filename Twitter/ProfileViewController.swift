//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Jeanne Nina on 2/25/16.
//  Copyright © 2016 Nina. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tweets: [Tweet]!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var headerPhotoView: UIImageView!
    @IBOutlet weak var profilePhotoView: UIImageView!
    @IBOutlet weak var headerControl: UIPageControl!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var settingsButtonView: UIView!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var accountsButtonView: UIView!
    @IBOutlet weak var accountsButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
/*        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension */
        
        
        TwitterClient.sharedInstance.userTimelineWithParams(nil) { (tweets, error) -> () in
            self.tweets = tweets
            
            self.tableView.reloadData()
            
        }
        
        self.settingsButtonView.layer.borderColor = UIColor.blackColor().CGColor
        self.settingsButtonView.layer.cornerRadius = 5
        self.settingsButtonView.clipsToBounds = true
        
        profilePhotoView.layer.cornerRadius = 5
        profilePhotoView.clipsToBounds = true
        
//        profilePhotoView.setImageWithURL(NSURL(string:(tweets.user!.profileImageUrl)!)!)
        
        
//        favoriteCountLabel.text = "\(tweets.favoritesCount!)"
//        retweetCountLabel.text = "\(tweets.retweetCount!)"
        
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ProfileTweetCell", forIndexPath: indexPath) as! ProfileTweetCell
        
        cell.selectionStyle = .None
        cell.tweet = tweets![indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            return tweets.count
        } else {
            return 0
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
