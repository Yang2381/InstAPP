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

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var post: [PFObject]?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadImage()
        // Do any additional setup after loading the view.
    }

    //Logout 
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let post = post{
            return post.count
        }else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableviewCell", for: indexPath) as! tableviewCell
        
        cell.post = post![indexPath.row]
       
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadImage()
    }
    
/*******************************************************************************
     loadImage function is to fetch data from parse server using PFQuery.
     PFQuery somewhat like SQL.
     Uses the findobjectsinbackground method to fetch the data
 *******************************************************************************/
    func loadImage(){
        
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.limit = 20
        
        query.findObjectsInBackground { (post: [PFObject]?, error: Error?) in
            if let post = post {
                
                self.post = post
                print(post)
                self.tableView.reloadData()
                
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
