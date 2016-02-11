//
//  PostImageViewController.swift
//  InPic
//
//  Created by Jerry on 2/8/16.
//  Copyright © 2016 Ethan Thomas. All rights reserved.
//

import UIKit

class PostImageViewController: UIViewController {
    
    var postImage: UIImage?

    var base64String: NSString!

    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet var captionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.navigationBarHidden = true
        self.tabBarController?.tabBar.hidden = true
        // Do any additional setup after loading the view.
        self.bgImageView.image = postImage
        let doneButton = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: "doneButtonPressed")
        self.navigationItem.rightBarButtonItem = doneButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func doneButtonPressed()
    {
        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)) {
            let imageData: NSData = UIImageJPEGRepresentation(self.postImage!, 1.0)!
            self.base64String = imageData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
            let timestamp = NSDate(timeIntervalSinceNow: NSTimeInterval())
            let uid = NSUserDefaults.standardUserDefaults().valueForKey("uid") as? String
            DataService.dataService.createNewPost(self.captionTextField.text!, timestamp: "\(timestamp)", photo: self.base64String as String, userposted: uid!)
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
