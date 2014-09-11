//
//  ProfileViewController.swift
//  MMHS_Event_App
//
//  Created by Johnny Appleseed on 9/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet var profilePic: UIImageView!
    @IBOutlet var coverPhoto: UIImageView!
    @IBOutlet var hometownLabel: UILabel!
    @IBOutlet var bioLabel: UILabel!


    @IBOutlet var tableView: UITableView!

    var eventsArray = [Event]()

    override func viewDidLoad() {
        super.viewDidLoad()

        retrieveDataAndSetViews()
        retrieveEvents()
        // Do any additional setup after loading the view.
    }

    func retrieveEvents()
    {
        getAllEvents { (events, result, error) -> Void in
            self.eventsArray = events
            self.tableView.reloadData()
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsArray.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ProfileCell") as ProfileTableViewCell
        let eventRecord = eventsArray[indexPath.row]

        cell.titleLabel.text = eventRecord.title
        let date = eventRecord.date
        cell.dateLabel.text = date.toNiceString()
        cell.eventImageView.image = imageFromAsset(eventRecord.eventPhoto as CKAsset)

        return cell
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 160
    }

    func retrieveDataAndSetViews()
    {
        var theUser = Users()
        theUser.setRecordToCurrentUsersRecordWithBlock { (succeeded, error) -> Void in
            self.hometownLabel.text = theUser.hometown
            self.bioLabel.text = theUser.bio

            if theUser.profilePic != nil
            {
                self.profilePic.image = imageFromAsset(theUser.profilePic as CKAsset)
            }

            if theUser.coverPhoto != nil
            {
                self.coverPhoto.image = imageFromAsset(theUser.coverPhoto as CKAsset)
            }
        }
    }



}
