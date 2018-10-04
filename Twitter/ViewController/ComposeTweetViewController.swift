//
//  ComposeTweetViewController.swift
//  Twitter
//
//  Created by Pat Khai on 10/4/18.
//  Copyright © 2018 Pat Khai. All rights reserved.
//

import UIKit
import Alamofire

class ComposeTweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var tweetCount: UILabel!
    @IBOutlet weak var composeTitle: UILabel!
    
    @IBOutlet weak var photoImage: UIImageView!
    
    @IBOutlet weak var tweetCompose: UITextView! {
        didSet {
            tweetCompose.becomeFirstResponder()
            tweetCompose.delegate = self
        }
    }
    
    let user = User.current!
    
    var delegate: ComposeTweetViewControllerDelegate?
    
    let charCount = 280
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        photoImage.layer.borderWidth = 1
        photoImage.layer.masksToBounds = false
        photoImage.layer.borderColor = UIColor.clear.cgColor
        photoImage.layer.cornerRadius = photoImage.frame.height/2
        photoImage.clipsToBounds = true
         photoImage.af_setImage(withURL: user.profilePictureURL)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//
       
        // Do any additional setup after loading the view.
    }
    
    @IBAction func shareTweet(_ sender: Any) {
        APIManager.shared.composeTweet(with: tweetCompose.text) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        tweetCount.text = "\(charCount - tweetCompose.text.count)"
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        return newText.count <= charCount
    }
    

    @IBAction func cancelCompose(_ sender: Any) {  self.dismiss(animated: true, completion: nil)
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


protocol ComposeTweetViewControllerDelegate {
    func did(post: Tweet)
}
