//
//  TimelineViewController.swift
//  Twitter
//
//  Created by Pat Khai on 9/24/18.
//  Copyright © 2018 Pat Khai. All rights reserved.
//

import UIKit
import AlamofireImage

class TimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tweets: [Tweet] = [] {
        didSet {
            
            tableView.dataSource = self
            tableView.delegate = self
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 190
        }
    }
    var refreshControl = UIRefreshControl()
    
    @IBAction func compose(_ sender: Any) {
         performSegue(withIdentifier: "compose", sender: sender)
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
   

        
        setUpRefreshControl()
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimeCell", for: indexPath) as! TimeTableViewCell
        cell.tweet = tweets[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
 
    func getTimeLine() {
        APIManager.shared.getHomeTimeLine { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
        }
        tableView.reloadData()
        
    }
    
    @objc func refreshTweets(_ refreshControl: UIRefreshControl) {
        getTimeLine()
        refreshControl.endRefreshing()
    }
    
    func setUpRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshTweets(_:)), for: UIControlEvents.valueChanged)
        refreshTweets(refreshControl)
        tableView.insertSubview(refreshControl, at: 0)
    }
    
    
    
    @IBAction func didSignout(_ sender: Any) {
        APIManager.shared.logout()
        User.current = nil
        self.performSegue(withIdentifier: "signout", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            let cell = sender as! UITableViewCell
            if let indexPath = tableView.indexPath(for: cell) {
                let tweet = tweets[indexPath.row]
                let vc = segue.destination as! DetailViewController
                vc.tweet = tweet
            }
        }
        else if segue.identifier == "compose" {
            let vc = segue.destination as! ComposeTweetViewController
            vc.delegate = self
        }
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


extension TimelineViewController: ComposeTweetViewControllerDelegate {
    func did(post: Tweet) {
        self.getTimeLine()
    }
    
    
}
