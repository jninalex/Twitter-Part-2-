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
        
        
       TwitterClient.sharedInstance.homeTimeLine({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            
            for tweet in tweets {
                print(tweet.text)
            }
        }, failure: { (error: NSError) -> () in
                print(error.localizedDescription)
        })

//        client.currentAccount()
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
        let cell = tableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath) as! TweetCell
        
//        cell.nameLabel.text = tweets![indexPath.row].user!.name
        cell.screennameLabel.text = "@\(tweets![indexPath.row].user!.screenname!)"
        cell.tweetLabel.text = tweets![indexPath.row].text
//        cell.profilePhotoView.setImageWithURL(NSURL(string: tweets![indexPath.row].user!.profileUrl!)!)
        
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
