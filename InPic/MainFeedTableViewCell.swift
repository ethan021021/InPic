//
//  MainFeedTableViewCell.swift
//  InPic
//
//  Created by Jerry on 2/4/16.
//  Copyright © 2016 Ethan Thomas. All rights reserved.
//

import UIKit

protocol MainFeedTableViewCellDelegate {
    func deletePost(cell: UITableViewCell)
}

class MainFeedTableViewCell: UITableViewCell {

    var delegate: MainFeedTableViewCellDelegate!

    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var buttonLabel: UIButton!
    @IBOutlet weak var likesLabel: UIButton!
    @IBOutlet var deleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.buttonLabel.contentHorizontalAlignment = .Left
        self.likesLabel.contentHorizontalAlignment = .Left
        self.deleteButton.contentHorizontalAlignment = .Right
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func removePhoto() {
        delegate.deletePost(self)
    }
    
}
