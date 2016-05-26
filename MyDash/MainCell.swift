//
//  MainCell.swift
//  MyDash
//
//  Created by Joseph Daryl Locsin on 25/05/2016.
//  Copyright © 2016 Joseph Daryl Locsin. All rights reserved.
//

import Foundation
import UIKit


class MainCell: UITableViewCell {

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var disclosurePhoto: UIImageView!

    override func willMoveToWindow(newWindow: UIWindow?) {
        super.willMoveToWindow(newWindow)
        
        self.thumbnail.layer.cornerRadius = self.thumbnail.bounds.size.height/2
        self.thumbnail.clipsToBounds = true
    }
}