//
//  IndividualEventViewController.swift
//  MMHS_Event_App
//
//  Created by Johnny Appleseed on 9/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

import UIKit

class IndividualEventViewController: UIViewController, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {

    var event = Event?()
    let imagePicker = UIImagePickerController()

    var photosArray = [Photo]()
    var selectedPhoto = UIImage?()

    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        imagePicker.allowsEditing = true


        getPhotosForEvent(event!, { (photos, result, error) -> Void in
            for photo in photos
            {
                self.photosArray.append(photo)
                self.tableView.reloadData()
            }
        })
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosArray.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StreamCell") as PhotoStreamTableViewCell

        let photo = photosArray[indexPath.row] as Photo

        cell.streamImageView.image = imageFromAsset(photo.image)

        getPhotographersProfilePic(fromPhoto: photo) { (image, result, error) -> Void in
            cell.photographerImageView.image = image
        }

        cell.dateLabel.text = photo.dateTaken.toOtherString()
        cell.likesLabel.text = "\(photo.likesCount)"
        cell.likeButton.tag = indexPath.row

        return cell
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 390
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject])
    {
        selectedPhoto = info[UIImagePickerControllerEditedImage] as UIImage!

        let photo = Photo()
        var currentUser = Users()

        currentUser.setRecordToCurrentUsersRecordWithBlock { (succeeded, error) -> Void in

            photo.photographer = CKReference(record: currentUser.record, action: CKReferenceAction.None)
            photo.event = CKReference(record: self.event?.recordValue(), action: CKReferenceAction.DeleteSelf)
            photo.image = CKAsset(fileURL: self.selectedPhoto?.urlWithImage())
            photo.dateTaken = NSDate()
            photo.likesCount = 0

            photo.save({ (succeeded, error) -> Void in
                self.photosArray.append(photo)
                self.tableView.reloadData()
            })
        }
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onCameraButtonTapped(sender: UIBarButtonItem)
    {
        actionSheet()
    }

    func actionSheet()
    {
        let actionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Camera", "Photo Library")
        actionSheet.showInView(view)
    }

    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 1
        {
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            presentViewController(imagePicker, animated: true, completion: nil)
        }
        else if buttonIndex == 2{
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
}
