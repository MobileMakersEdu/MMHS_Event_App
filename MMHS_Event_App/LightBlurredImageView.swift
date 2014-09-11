//
//  LighterBlurredImageView.swift
//  MMHS_Event_App
//
//  Created by Mobile Makers on 9/4/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

import UIKit

class LightBlurredImageView: UIImageView {

    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)

        var blur : UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
        var effectView : UIVisualEffectView = UIVisualEffectView(effect: blur)
        effectView.frame = frame
        addSubview(effectView)
    }
}