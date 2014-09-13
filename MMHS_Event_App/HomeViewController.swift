//
//  HomeViewController.swift
//  MMHS_Event_App
//
//  Created by Vik Denic on 9/2/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var eventsArray = [Event]()
    @IBOutlet var tableView: UITableView!
    @IBOutlet var refreshButton: UIBarButtonItem!
    var selectedIndexPath = NSIndexPath()

    //MARK: View Loading
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(true)

        tabBarController?.tabBar.tintColor = UIColor.purpleColor()

        checkForAccountAuthentification()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "checkForAccountAuthentification", name: "opened", object: nil)
    }

    //MARK: Check for iCloud user
    func checkForAccountAuthentification()
    {
        var currentiCloudAccountStatus : Void = CKContainer.defaultContainer().accountStatusWithCompletionHandler { (accessibility, error) -> Void in
            if accessibility == CKAccountStatus.Available
            {

            }
            else{
                self.performSegueWithIdentifier("NoAccountSegue", sender: nil)
            }
        }
    }

    func requestDiscoverability()
    {
        let cloudManager = AAPLCloudManager()

        cloudManager.requestDiscoverabilityPermission { (discoverable) -> Void in
            if discoverable
            {
                cloudManager.discoverUserInfo({ (user) -> Void in

                })
            } else{
                let alert = UIAlertController(title: "CloudKit", message: "Getting your name using Discoverability requires permission", preferredStyle: UIAlertControllerStyle.Alert)

                let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (var act) -> Void in
                    self.dismissViewControllerAnimated(true, completion: nil)
                })
                alert.addAction(action)
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
}
