//
//  PhotoStreamTableViewCell.swift
//  MMHS_Event_App
//
//  Created by Johnny Appleseed on 9/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

import UIKit

class PhotoStreamTableViewCell: UITableViewCell {

    @IBOutlet var streamImageView: UIImageView!
    @IBOutlet var photographerImageView: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var likesLabel: UILabel!
    
    @IBOutlet var likeButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        photographerImageView.layer.cornerRadius = photographerImageView.frame.height / 2
        photographerImageView.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onLikeButtonTapped(sender: UIButton)
    {
    }
}
