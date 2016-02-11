//
//  CreateAccountViewController.swift
//  InPic
//
//  Created by Ethan Thomas on 2/8/16.
//  Copyright © 2016 Ethan Thomas. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    @IBOutlet var usernameText: UITextField!
    @IBOutlet var emailText: UITextField!
    @IBOutlet var passwordText: UITextField!
    let loggedInUser = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func backToLogin(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func createAccount(sender: AnyObject) {
        let email = emailText.text
        let username = usernameText.text
        let password = passwordText.text

        if email != "" && username != "" && password != "" {
            DataService.dataService.USER_REF.createUser(email, password: password, withValueCompletionBlock: { (error, result) in
                if error != nil {
                    let alert = UIAlertController(title: "Sorry!", message: error.localizedDescription, preferredStyle: .Alert)
                    let ok = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    alert.addAction(ok)
                    self.presentViewController(alert, animated: true, completion: nil)
                } else {
                    DataService.dataService.USER_REF.authUser(email, password: password, withCompletionBlock: { (error, authData) in
                        let user = ["provider": authData.provider!, "email": email!, "username": username!]
                        DataService.dataService.createNewAccount(authData.uid, user: user)
                        self.loggedInUser.setValue(authData.uid!, forKey: "uid")
                        print("AUTH DATA UID: \(authData.uid)")
                        dispatch_async(dispatch_get_main_queue(), { 
                            self.performSegueWithIdentifier("unwindToMain", sender: nil)
                        })
                    })
                }
            })
        } else {
            self.showErrorAlert("Sorry!", message: "Be sure to fill in all of the text fields with your user information you'd like to register as!")
        }
    }

    func showErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let ok = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(ok)
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
