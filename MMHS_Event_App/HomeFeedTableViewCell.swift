//
//  HomeFeedTableViewCell.swift
//  MMHS_Event_App
//
//  Created by Johnny Appleseed on 9/10/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

import UIKit

class HomeFeedTableViewCell: UITableViewCell {

    @IBOutlet var eventImageView: UIImageView!
    @IBOutlet var hostImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        hostImageView.layer.cornerRadius = hostImageView.frame.size.height / 2
        hostImageView.clipsToBounds = true
    }
}
