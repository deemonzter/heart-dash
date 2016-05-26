//
//  DetailImageCell.swift
//  MyDash
//
//  Created by Joseph Daryl Locsin on 25/05/2016.
//  Copyright © 2016 Joseph Daryl Locsin. All rights reserved.
//

import Foundation
import UIKit


class DetailImageCell: UITableViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    
    override func willMoveToWindow(newWindow: UIWindow?) {
        super.willMoveToWindow(newWindow)
        
        self.photo.layer.cornerRadius = self.photo.bounds.size.height/2
        self.photo.clipsToBounds = true
    }
}