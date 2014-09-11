//
//  EditProfileViewController.swift
//  MMHS_Event_App
//
//  Created by Johnny Appleseed on 9/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {


    @IBOutlet var bioTextField: UITextField!

    @IBOutlet var hometownTextField: UITextField!

    var imagePicker = UIImagePickerController()

    var settingProfilePic = Bool()

    var profilePic = UIImage?()
    var coverPhoto = UIImage?()

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.allowsEditing = true
    }
    @IBAction func onCancelTapped(sender: UIBarButtonItem)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onSaveButtonTapped(sender: UIBarButtonItem)
    {
        let theUser = Users()

        theUser.bio = bioTextField.text
        theUser.hometown = hometownTextField.text
        theUser.profilePic = CKAsset(fileURL: profilePic?.urlWithImage())
        theUser.coverPhoto = CKAsset(fileURL: coverPhoto?.urlWithImage())

        theUser.save { (succeeded, error) -> Void in
            //
        }
    }


    @IBAction func editProfilePicTapped(sender: UIButton)
    {
        presentViewController(imagePicker, animated: true, completion: nil)
        settingProfilePic = true
    }

    @IBAction func editCoverPhotoTapped(sender: UIButton)
    {
        presentViewController(imagePicker, animated: true, completion: nil)
        settingProfilePic = false
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if settingProfilePic == true
        {
            profilePic = info[UIImagePickerControllerEditedImage] as UIImage!
        }
        else{
            coverPhoto = info[UIImagePickerControllerEditedImage] as UIImage
        }
    }


}
