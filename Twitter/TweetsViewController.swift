//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Jeanne Nina on 2/22/16.
//  Copyright © 2016 Nina. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tweets: [Tweet]!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        
        TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
            self.tweets = tweets
            
            self.tableView.reloadData()
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutButton(sender: AnyObject) {
        User.currentUser?.logout()
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
            let tweetInfo = tweets![indexPath.row]
            cell.profilePhotoView.setImageWithURL(NSURL(string: (tweetInfo.user?.profileImageUrl)!)!)
            cell.nameLabel.text = tweetInfo.user?.name
            cell.screennameLabel.text = "@" + (tweetInfo.user?.screenname)!
            cell.timestampLabel.text = tweetInfo.createdAt
            cell.tweetLabel.text = tweetInfo.text
//            cell.retweetCountLabel.text = tweetInfo.retweetCount!
//            cell.favoriteCountLabel.text = tweetInfo.favoriteCount!
//            cell.tweetId = tweetInfo.tweetId
//            cell.reTweetButton.setTitle(tweetInfo.tweetId, forState: .Normal)
//            cell.favoriteButton.setTitle(tweetInfo.tweetId, forState: .Normal)
            
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
