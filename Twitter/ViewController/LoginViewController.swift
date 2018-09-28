//
//  LoginViewController.swift
//  Twitter
//
//  Created by Pat Khai on 9/24/18.
//  Copyright © 2018 Pat Khai. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func login(_ sender: Any) {
            APIManager.shared.login(success: {
            self.performSegue(withIdentifier: "login", sender: nil)
                
            }) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
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
