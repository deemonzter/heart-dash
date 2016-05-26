//
//  DashRepository.swift
//  MyDash
//
//  Created by Joseph Daryl Locsin on 25/05/2016.
//  Copyright © 2016 Joseph Daryl Locsin. All rights reserved.
//

import Foundation


func DashRepo() -> DashRepository {
    return DashRepository.sharedInstance
}

class DashRepository: NSObject {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    let key = "saved-dash-items"
    
    static var sharedInstance = DashRepository()
    
    var myItems: [DashItem] = [DashItem]()
    
    var incompleteItems: [DashItem] {
        return self.myItems.filter({ $0.isIncomplete })
    }
    
    func initializeOrRestoreDashItems() {
        
        DashPopulator.populate()
        
        // restore previous items
        if let itemsDict = self.defaults.objectForKey(self.key) {
            
            for item in self.myItems {
                let value = itemsDict[item.title]
                
                if let _value = value as? Float {
                    item.addConsumption(_value)
                }
            }
        }
    }
    
    func synchronize() {
        
        var items = [String:Float]()
        
        for item in self.myItems {
            items[item.title] = item.consumedValue
        }
        
        self.defaults.setObject(items, forKey: self.key)
        self.defaults.synchronize()
    }
}