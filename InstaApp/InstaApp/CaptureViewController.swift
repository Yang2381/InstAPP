//
//  CaptureViewController.swift
//  InstaApp
//
//  Created by YangSzu Kai on 2017/3/17.
//  Copyright © 2017年 YangSzu Kai. All rights reserved.
//

import UIKit
import MBProgressHUD

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var picimage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
     
    }
    @IBAction func onSend(_ sender: Any) {
        //Show Spinning Circle 
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        if (picimage.image == nil) {
            print("No image")
            
            let alertcontroller = UIAlertController(title: "Error", message: "Unable to send", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction) in
                
            })
            alertcontroller.addAction(action)
            self.present(alertcontroller, animated: true, completion: nil)
            

            //Dismiss The spinning circle
            MBProgressHUD.hide(for: self.view, animated: true)
        }else{
            let image = picimage.image
            let caption = descriptionText.text
            
            Post.postUserImage(image: image, withCaption: caption, withCompletion: { (success: Bool, error: Error?) in
                if success{
                    
                    //Dismiss The spinning circle
                    MBProgressHUD.hide(for: self.view, animated: true)
                    
                    self.picimage.image = nil
                   self.descriptionText.text = ""
                    
                    //Jump to home after sending
                    self.tabBarController?.selectedIndex = 0
                } else{
                    print(error?.localizedDescription ?? 0)
                    let alertcontroller = UIAlertController(title: "Error", message: "Unable to send", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction) in
                        
                    })
                    alertcontroller.addAction(action)
                    self.present(alertcontroller, animated: true, completion: nil)
                }
            })
        }
        
        
    }
    @IBAction func onLibary(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(vc, animated: true, completion: nil)

    }
    
    @IBAction func onCapture(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.camera
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
           
            //Show choosen picture
            let size = CGSize(width: 288, height: 288)
            let newImage = resize(image: originalImage, newSize: size)
            picimage.image = newImage
            
        }else if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
         
          let size = CGSize(width: 288, height: 288)
          let newImage = resize(image: editedImage, newSize: size)
          picimage.image = newImage
            
        }else{
            print(Error.self)
        }
        
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    //Adjust the size of the image to fit in
    func resize(image: UIImage, newSize: CGSize) ->UIImage {
         let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
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
