//
//  DetailViewController.swift
//  Twitter
//
//  Created by Pat Khai on 10/3/18.
//  Copyright © 2018 Pat Khai. All rights reserved.
//

import UIKit
import Alamofire

class DetailViewController: UIViewController {

    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var replyCount: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var tweetButton: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userID: UILabel!
    
    
    var liked: Bool?
    var retweeted: Bool?
    var commented: Bool?
    
    var tweet: Tweet!
       
    @IBAction func likes(_ sender: UIButton) {
        if tweet.favorited == false {
            tweet.favorited = true
            favoriteTweet()
        }else {
            tweet.favorited = false
            unfavoriteTweet()
        }
        updatePost()
        
    }
    
    
    
    @IBAction func reTweet(_ sender: UIButton) {
        if tweet.retweeted == false {
            tweet.retweeted = true
            retweetTweet()
        } else {
            tweet.retweeted = false
            unretweetTweet()
        }
        updatePost()
    }
    
    func updatePost() {
        //tweets are favorite
        if tweet.favorited == true {
            self.likeButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
        } else {
            self.likeButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
            
        }
        //tweet are retweet
        if tweet.retweeted == true {
            self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
        } else {
            self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
        }
        //show counts of retweet
        if tweet.retweetCount > 0 {
            retweetCount.text = "\(tweet.retweetCount)"
        }else {
            retweetCount.text = ""
        }
        //show counts of favorite
        if tweet.favoriteCount! > 0 {
            likeCount.text = "\(tweet.favoriteCount!)"
        }else {
            likeCount.text = ""
        }
    }
    
    

    
    
    func favoriteTweet() {
        APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
            if let error = error {
                print("Error liking tweet: \(error.localizedDescription)")
            }else if let tweet = tweet {
                print("Liked the tweet NICE!: \n\(tweet.text)")
                tweet.favoriteCount! += 1
                self.likeCount.text = "\(tweet.favoriteCount! + 1)"
                self.updatePost()
            }
        }
    }
    
    func unfavoriteTweet() {
        APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
            if let error = error {
                print("Error liking tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Liked the tweet NICE!:  \n\(tweet.text)")
                tweet.favorited = false
                self.likeCount.text = "\(tweet.favoriteCount! - 1)"
                self.updatePost()
            }
        }
    }
    
    func retweetTweet() {
        APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error retweeting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Retweet the tweet NICE!: \n\(tweet.text)")
                self.retweetCount.text = "\(tweet.retweetCount)"
                self.updatePost()
            }
        }
    }
    
    func unretweetTweet() {
        APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error retweeting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Retweet the tweet NICE!: \n\(tweet.text)")
                self.retweetCount.text = "\(tweet.retweetCount - 1)"
                self.updatePost()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        username.text = tweet.user.name
        userID.text = "@\(tweet.user.screenName)"
        
        
        profileImage.layer.borderWidth = 1
        profileImage.layer.masksToBounds = false
        profileImage.layer.borderColor = UIColor.clear.cgColor
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
        profileImage.af_setImage(withURL: tweet.user.profilePictureURL)
        
        //likes , retweet, comments
        tweetButton.text = tweet.text
        liked = tweet.favorited!
        retweeted = tweet.retweeted
        
        time.text = tweet.createdAtString
        updatePost()
        
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
