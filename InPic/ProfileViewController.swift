//
//  ProfileViewController.swift
//  InPic
//
//  Created by Jerry on 2/4/16.
//  Copyright © 2016 Ethan Thomas. All rights reserved.
//

import UIKit
import ImagePicker

class ProfileViewController: UIViewController, ImagePickerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    let imagePicker = ImagePickerController()


    var profileArray = [UIImage]()

    @IBOutlet weak var buttonImage: UIButton!

    override func viewDidLoad() {

        super.viewDidLoad()

        self.profileArray.append(UIImage(named: "image")!)

        self.imagePicker.delegate = self

//        self.collectionView.reloadData()

        // Do any additional setup after loading the view, typically from a nib.
        self.buttonImage.setImage(UIImage(named: "image"), forState: UIControlState.Normal)    }


    @IBAction func editProfilePicTapped(sender: AnyObject) {

        //        imagePicker.allowsEditing = true
        //        imagePicker.sourceType = .PhotoLibrary

        //        presentViewController(imagePicker, animated: true, completion: nil)
        self.imagePicker.delegate = self
        self.imagePicker.imageLimit = 1
        presentViewController(self.imagePicker, animated: true, completion: nil)

    }

    func wrapperDidPress(images: [UIImage]) {

    }

    func doneButtonDidPress(images: [UIImage]) {
        self.imagePicker.dismissViewControllerAnimated(true) { () -> Void in
            if images.count > 0 {
                self.buttonImage.imageView!.contentMode = .ScaleAspectFit
                self.buttonImage.setImage(images[0], forState: UIControlState.Normal)
            }
        }
    }

    func cancelButtonDidPress() {
    }

    //    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    //        dismissViewControllerAnimated(true, completion: nil)
    //    }
    //
    //    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    //        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
    //            self.buttonImage.imageView!.contentMode = .ScaleAspectFit
    //            self.buttonImage.setImage(pickedImage, forState: UIControlState.Normal)
    //        }
    //
    //        dismissViewControllerAnimated(true, completion: nil)
    //
    //    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "logoutSegue" {
            let appDomain = NSBundle.mainBundle().bundleIdentifier
            NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ProfileCell", forIndexPath: indexPath) as? ProfileCollectionViewCell
        
        
        
        
        
            
        cell!.cellImage.image = self.profileArray[indexPath.row]
        
        
//        cell!.backgroundColor = UIColor.purpleColor()


        
        return cell!
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.profileArray.count
        
    
    
    
    
    
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
}
