//
//  CreateEventViewController.swift
//  MMHS_Event_App
//
//  Created by Johnny Appleseed on 9/10/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

import UIKit
import MapKit

class CreateEventViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var selectPhotoButton: UIButton!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var detailsTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!

    let imagePicker = UIImagePickerController()
    var selectedImage = UIImage?()
    var selectedImagePath = NSURL?()

    var location = CLLocation?()

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.allowsEditing = true

        selectPhotoButton.layer.cornerRadius = selectPhotoButton.frame.height / 2
    }

    func geoCodeLocationWithBlock(located : (succeeded : Bool, error : NSError!) -> Void)
    {
        var geocode = CLGeocoder()
        geocode.geocodeAddressString(locationTextField.text, completionHandler: { (placemarks, error) -> Void in
            if error == nil
            {
                let locations : [CLPlacemark] = placemarks as [CLPlacemark]
                self.location = locations[0].location
                located(succeeded: true, error: error)
            }
            else{
                self.showErrorAlert("Oops!", message: "Couldn't get location. Please enter a different address.")
            }
        })
    }

    @IBAction func onDoneButtonTapped(sender: UIBarButtonItem)
    {
        dismissViewControllerAnimated(true, completion: { () -> Void in
            self.geoCodeLocationWithBlock { (succeeded, error) -> Void in
                self.setDataAndSave()
            }
        })
    }

    func setDataAndSave()
    {
        let newEvent = Event()
        newEvent.title = titleTextField.text
        newEvent.details = detailsTextField.text
        newEvent.location = location
        newEvent.date = datePicker.date

        if selectedImage != nil
        {
        newEvent.eventPhoto = CKAsset(fileURL: selectedImage?.urlWithImage())
        }
        else{
            showErrorAlert("Oops!", message: "Don't Forget to Select a Photo")
        }

        var currentUser = Users()
        currentUser.setRecordToCurrentUsersRecordWithBlock { (succeeded, error) -> Void in

            newEvent.host = CKReference(record: currentUser.record, action: CKReferenceAction.DeleteSelf)

            newEvent.save({ (succeeded, error) -> Void in

                if succeeded
                {
                NSNotificationCenter.defaultCenter().postNotificationName("savedEvent", object: self)
                    println("saved")
                }
                else{
                    self.showErrorAlert("Oops!", message: "Something didn't work. Try again later")
                }
            })
        }
    }

    @IBAction func onCancelButtonTapped(sender: UIBarButtonItem)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onSelectPhotoButtonTapped(sender: UIButton)
    {
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject])
    {
        dismissViewControllerAnimated(true, completion: { () -> Void in
            self.selectedImage = info[UIImagePickerControllerEditedImage] as UIImage!
            self.selectedImagePath = self.selectedImage?.urlWithImage()
        })
    }

    func showErrorAlert(withTitle : String, message : String)
    {
        let alert = UIAlertController(title: withTitle, message: message, preferredStyle: UIAlertControllerStyle.Alert)

        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)

        alert.addAction(action)
        self.presentViewController(alert, animated: true, completion: nil)
    }

}
