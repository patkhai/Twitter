//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Pat Khai on 10/4/18.
//  Copyright © 2018 Pat Khai. All rights reserved.
//

import UIKit
import Alamofire

class ProfileViewController: UIViewController {

    @IBOutlet weak var usernameID: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var tweetCount: UILabel!
    
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var followerCount: UILabel!
    let user = User.current!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        username.text = user.name
        usernameID.text = "@\(user.screenName)"
        
        tweetCount.text = "\(user.tweetsCount)"
        followingCount.text = "\(user.followingCount)"
        followerCount.text = "\(user.followersCount)"
        
        profileImage.layer.borderWidth = 1
        profileImage.layer.masksToBounds = false
        profileImage.layer.borderColor = UIColor.clear.cgColor
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
        profileImage.af_setImage(withURL: user.profilePictureURL)

        // Do any additional setup after loading the view.
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
