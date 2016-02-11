//
//  DataService.swift
//  InPic
//
//  Created by Ethan Thomas on 2/8/16.
//  Copyright © 2016 Ethan Thomas. All rights reserved.
//

import Foundation
import Firebase

class DataService {
    static let dataService = DataService()

    private var _BASE_REF = Firebase(url: "\(BASE_URL)")
    private var _USER_REF = Firebase(url: "\(BASE_URL)/users")
    private var _PHOTO_REF = Firebase(url: "\(BASE_URL)/photos")
    private var _POST_REF = Firebase(url: "\(BASE_URL)/posts")

    var BASE_REF: Firebase {
        return _BASE_REF
    }

    var USER_REF: Firebase {
        return _USER_REF
    }

    var PHOTO_REF: Firebase {
        return _PHOTO_REF
    }

    var POST_REF: Firebase {
        return _POST_REF
    }

    var CURRENT_USER_REF: Firebase {
        let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String

        let currentUser = Firebase(url: "\(BASE_REF)").childByAppendingPath("users").childByAppendingPath(userID)

        return currentUser!
    }

    func createNewAccount(uid: String, user: Dictionary<String, String>) {
        USER_REF.childByAppendingPath(uid).setValue(user)
    }

    func createNewPost(photo: String, caption: String) {
        let userid = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        let postRef = POST_REF.childByAutoId()
        let timestamp = NSDate(timeIntervalSinceNow: NSTimeInterval())
        let post = ["userid": userid, "timestamp": "\(timestamp)"]
        postRef.setValue(post) { (error, firebase) in
            self.createNewPhoto(photo, caption: caption, postid: firebase.key)
        }
    }

    func createNewPhoto(photo: String, caption: String, postid: String) {
        let photoRef = PHOTO_REF.childByAutoId()
        let photos = ["string": photo, "caption": caption, "postid": postid]
        photoRef.setValue(photos) { (error, firebase) in
            let uPostRef = Firebase(url: "\(BASE_URL)/posts/\(postid)")
            let updatePost = ["photoid": firebase.key]
            uPostRef.updateChildValues(updatePost)
        }
    }
}
