//
//  DashPopulator.swift
//  MyDash
//
//  Created by Joseph Daryl Locsin on 25/05/2016.
//  Copyright © 2016 Joseph Daryl Locsin. All rights reserved.
//

import Foundation
import UIKit

class DashPopulator: NSObject {

    class func populate() {
        
        let filename = "DashList"
        
        var dashList: [AnyObject]?
        
        if let path = NSBundle.mainBundle().pathForResource(filename, ofType: "plist") {
            
            let dict = NSDictionary(contentsOfFile:path)
            
            if let _list = dict?["items"] as? [AnyObject] {
                dashList = _list
            }
        }
        
        if let _dashList = dashList {
            
            // enumerate the items
            
            for _dashItem in _dashList {
                
                // each item is a dict
                guard let   title = _dashItem["title"] as? String,
                            minCount = _dashItem["minCount"] as? Float,
                            maxCount = _dashItem["maxCount"] as? Float,
                            servingSizes = _dashItem["servingSizes"] as? [String] else
                {
                    print("[ERROR] incomplete dash item! cannot proceed!")
                    return
                }
                
                let item = DashItem(title: title, minCount: minCount, maxCount: maxCount, servingSizes: servingSizes)
                
                if let _imageName = _dashItem["image"] as? String {
                    if let _image = UIImage(named: _imageName) {
                        item.photo = _image
                    }
                }
                
                DashRepo().myItems.append(item)
            }
        }
    }
}