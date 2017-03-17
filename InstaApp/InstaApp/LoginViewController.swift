//
//  LoginViewController.swift
//  InstaApp
//
//  Created by YangSzu Kai on 2017/3/17.
//  Copyright © 2017年 YangSzu Kai. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordFiled: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignin(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordFiled.text!) { (user: PFUser?, error: Error?) in
            if user != nil{
                print("Login")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    @IBAction func onSignup(_ sender: Any) {
        let newUser = PFUser()
        
        newUser.username = usernameField.text
        newUser.password = passwordFiled.text
        
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if success {
                print("User Created")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }else{
                let code = (error as! NSError).code
                print(error?.localizedDescription ?? 0)
                if code == 202{
                    print("User already exist")
                }
            }
        }
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
