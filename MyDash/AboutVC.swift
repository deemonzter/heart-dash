//
//  AboutVC.swift
//  MyDash
//
//  Created by Joseph Daryl Locsin on 26/05/2016.
//  Copyright © 2016 Joseph Daryl Locsin. All rights reserved.
//

import Foundation
import UIKit

class AboutVC: UIViewController {
    
    @IBAction func tappedExit(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.redColor()
    }
    
    @IBAction func tappedDeemonzter(sender: AnyObject) {
    
        let email = "daryl.locsin@gmail.com"
        
        if let _url = NSURL(string: "mailto:\(email)") {
            UIApplication.sharedApplication().openURL(_url)
        }
    }
}