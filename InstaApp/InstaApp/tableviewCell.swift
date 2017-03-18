//
//  tableviewCell.swift
//  InstaApp
//
//  Created by YangSzu Kai on 2017/3/17.
//  Copyright © 2017年 YangSzu Kai. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class tableviewCell: UITableViewCell {

    @IBOutlet weak var picDescription: UILabel!
    @IBOutlet weak var postImage: PFImageView!

    
    var post: PFObject!{
        willSet{
            self.postImage.file = newValue["media"] as? PFFile
            self.postImage.loadInBackground()
            self.picDescription.text = newValue["caption"] as? String
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
