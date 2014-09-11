//
//  HomeViewController.swift
//  MMHS_Event_App
//
//  Created by Mobile Makers on 9/2/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    var eventsArray = [Event]()

    //MARK: View Loading
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(true)

        checkForAccountAuthentification()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "checkForAccountAuthentification", name: "opened", object: nil)
    }

    func retrieveEvents()
    {
        getAllEvents { (events, result, error) -> Void in
            self.eventsArray = events
            self.tableView.reloadData()
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventsArray.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FeedCell") as HomeFeedTableViewCell

        let event = eventsArray[indexPath.row]

        let hostReference = event.host

        getUserFromReference(hostReference, { (user, result, error) -> Void in
            cell.hostImageView.image = imageFromAsset(user!.profilePic)
        })

        cell.eventImageView.image = imageFromAsset(event.eventPhoto)

        cell.titleLabel.text = event.title

        let date = event.date
        cell.dateLabel.text = date.toNiceString()

        return cell
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 320
    }


    //MARK: Check for iCloud user
    func checkForAccountAuthentification()
    {
        var currentiCloudAccountStatus : Void = CKContainer.defaultContainer().accountStatusWithCompletionHandler { (accessibility, error) -> Void in
            if accessibility == CKAccountStatus.Available
            {
                self.requestDiscoverability()
                self.retrieveEvents()
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
