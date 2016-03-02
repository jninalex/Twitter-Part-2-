//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Jeanne Nina on 2/22/16.
//  Copyright © 2016 Nina. All rights reserved.
//

import UIKit
import AFNetworking

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tweets: [Tweet]!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        // Initialize a UIRefreshControl
       let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshTimeline:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
       TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
            self.tweets = tweets
            
            self.tableView.reloadData()
            
        }
        
/*        let logo = UIImage(named: "Twitter_logo_blue_48")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView */

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
        
        cell.selectionStyle = .None
        cell.tweet = tweets![indexPath.row]
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: cell, action: "onProfileImageTap:")
        cell.profilePhotoView.addGestureRecognizer(tapGestureRecognizer)
        
            return cell
        }
        
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if let tweets = tweets {
                return tweets.count
            } else {
                return 0
            }
        }
    
        
    
    func refreshTimeline(refreshControl: UIRefreshControl) {
        
        TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
            self.tweets = tweets
            
            // Reload the tableView now that there is new data
            self.tableView.reloadData()
            
            // Tell the refreshControl to stop spinning
            refreshControl.endRefreshing()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
/*        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        let tweet = tweets![indexPath!.row] */
        if segue.identifier == "MoreDetailsSegue" {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let tweet = tweets![indexPath!.row]
            
            let detailsViewController = segue.destinationViewController as! DetailsViewController
            detailsViewController.tweets = tweet
           
        } else if segue.identifier == "ProfileSegue" {
            let tweet = tweets!
            let profileViewController = segue.destinationViewController as! ProfileViewController
            profileViewController.tweets = tweet
        }
         print("prepare for segue called")
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
