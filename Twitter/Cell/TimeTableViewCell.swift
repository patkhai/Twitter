//
//  TimeTableViewCell.swift
//  Twitter
//
//  Created by Pat Khai on 9/24/18.
//  Copyright © 2018 Pat Khai. All rights reserved.
//

import UIKit
import AlamofireImage

class TimeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var status: UILabel!
    
    @IBOutlet weak var likeButtom: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var likesID: UILabel!
    @IBOutlet weak var retweetID: UILabel!
    
    @IBOutlet weak var userID: UILabel!
    @IBOutlet weak var username: UILabel!
    
    
    @IBOutlet weak var commentID: UILabel!
    
    
    var liked: Bool?
    var retweeted: Bool?
    var commented: Bool?
    
    var tweet: Tweet! {
        didSet {
            //username and @
            username.text = tweet.user.name
            userID.text = "@\(tweet.user.screenName)"
            
            //Image Id
            imageProfile.af_setImage(withURL: tweet.user.profilePictureURL)
            
            //likes , retweet, comments
            status.text = tweet.text
            liked = tweet.favorited!
            retweeted = tweet.retweeted
            
            date.text = tweet.timeAgoSinceNow
          updatePost()
            
            
            
        }
    }
    
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
    }
    
    func updatePost() {
        //tweets are favorite
        if tweet.favorited == true {
            self.likeButtom.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
        } else {
            self.likeButtom.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
            
        }
        //tweet are retweet
        if tweet.retweeted == true {
            self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
        } else {
            self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
        }
        //show counts of retweet
        if tweet.retweetCount > 0 {
            retweetID.text = "\(tweet.retweetCount)"
        }else {
            retweetID.text = ""
        }
        //show counts of favorite
        if tweet.favoriteCount! > 0 {
            likesID.text = "\(tweet.favoriteCount!)"
        }else {
            likesID.text = ""
        }
    }
    
    
        
    
    @IBAction func comment(_ sender: Any) {
    }
    
    
    func favoriteTweet() {
        APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
            if let error = error {
                print("Error liking tweet: \(error.localizedDescription)")
            }else if let tweet = tweet {
                print("Liked the tweet NICE!: \n\(tweet.text)")
                tweet.favoriteCount! += 1
                self.likesID.text = "\(tweet.favoriteCount! + 1)"
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
                self.likesID.text = "\(tweet.favoriteCount! - 1)"
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
                self.retweetID.text = "\(tweet.retweetCount)"
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
                 self.retweetID.text = "\(tweet.retweetCount - 1)"
                self.updatePost()
            }
        }
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
