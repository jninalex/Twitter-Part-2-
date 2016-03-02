//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Jeanne Nina on 2/26/16.
//  Copyright © 2016 Nina. All rights reserved.
//

import UIKit
import AFNetworking

class ComposeViewController: UIViewController, UITextViewDelegate  {

    var tweets: Tweet!
    
    @IBOutlet weak var charRemainingLabel: UILabel!
    @IBOutlet weak var profilePhotoView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var composeTweetView: UITextView!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var tweetButton: UIBarButtonItem!
    
    var doneTweet: Tweet?
    
    
    var newLength: Int!
    var remainingChar: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profilePhotoView.layer.cornerRadius = 5
        profilePhotoView.clipsToBounds = true
        
        profilePhotoView.setImageWithURL(NSURL(string:(tweets.user!.profileImageUrl)!)!)
        nameLabel.text = tweets.user!.name!
        screennameLabel.text = "@\(tweets!.user!.screenname!)"
        
        composeTweetView.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textView(textView: UITextView,
        shouldChangeTextInRange range: NSRange,
        replacementText text: String) -> Bool {
            
            newLength = (composeTweetView.text as NSString).length + (text as NSString).length - range.length
            remainingChar = 140 - newLength
            
            charRemainingLabel.text = "\(remainingChar)"
            
            if (newLength > 140) {
                return false
            } else {
                return true
            }
    }
    
/*    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SaveTweet" {
            doneTweet = Tweet(dictionary: composeTweetView.text!)
        }
    } */
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
