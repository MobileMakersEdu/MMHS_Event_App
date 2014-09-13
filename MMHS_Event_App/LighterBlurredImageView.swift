//
//  LighterBlurredImageView.swift
//  MMHS_Event_App
//
//  Created by Johnny Appleseed on 9/13/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

import UIKit

class LighterBlurredImageView: UIImageView {

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
