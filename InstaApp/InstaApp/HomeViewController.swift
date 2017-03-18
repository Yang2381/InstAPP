//
//  HomeViewController.swift
//  InstaApp
//
//  Created by YangSzu Kai on 2017/3/17.
//  Copyright © 2017年 YangSzu Kai. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOutInBackground { (error: Error?) in
            if error == nil {
               print("Logged out")
                
                //Once loggedout go to the loginView
               let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginView")
                self.show(vc!, sender: self)
               
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
