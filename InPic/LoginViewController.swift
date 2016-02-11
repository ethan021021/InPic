//
//  ViewController.swift
//  InPic
//
//  Created by Ethan Thomas on 2/4/16.
//  Copyright © 2016 Ethan Thomas. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    //properties
    @IBOutlet var emailText: UITextField!
    @IBOutlet var passwordText: UITextField!
    let loggedInUser = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loginUser(sender: AnyObject) {
        let email = emailText.text
        let password = passwordText.text

        if email != "" && password != "" {
            DataService.dataService.BASE_REF.authUser(email, password: password, withCompletionBlock: { (error, authData) in
                if error != nil {
                    let alert = UIAlertController(title: "Sorry!", message: error.localizedDescription, preferredStyle: .Alert)
                    let ok = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    alert.addAction(ok)
                    self.presentViewController(alert, animated: true, completion: nil)
                } else {
                    self.loggedInUser.setValue(authData.uid!, forKey: "uid")
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            })
        } else {
            self.signupErrorAlert("Sorry!", message: "Don't forget to enter your email and password!")
        }
    }

    func signupErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let ok = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(ok)
        presentViewController(alert, animated: true, completion: nil)
    }
}

