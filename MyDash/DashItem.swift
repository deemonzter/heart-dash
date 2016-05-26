//
//  DashItem.swift
//  MyDash
//
//  Created by Joseph Daryl Locsin on 25/05/2016.
//  Copyright © 2016 Joseph Daryl Locsin. All rights reserved.
//

import Foundation
import UIKit


class DashItem: NSObject {
    
    let title: String
    let minCount: Float
    let maxCount: Float
    let servingSizes: [String]
    
    var photo: UIImage?
    
    private var consumedCount: Float = 0
    
    // computed
    
    var consumedValue: Float {
        return consumedCount
    }
    
    var isIncomplete: Bool {
        return self.consumedCount < self.maxCount
    }
    
    var isMinComplete: Bool {
        return self.consumedCount >= self.minCount
    }
    
    var isMaxComplete: Bool {
        return self.consumedCount == self.maxCount
    }
    
    var prettyRemaining: NSAttributedString {
        
        let units = self.consumedCount <= 1 ? "unit" : "units"
        
        var text = "You have consumed \(self.consumedCount) \(units)."
        
        if self.consumedCount == 0 {
            text = "You have not consumed this."
        }
        
        if self.consumedCount >= self.minCount {
            
            if self.consumedCount == self.maxCount {
                // consumed max allowed
                text = "\(text)\nMax: Complete"
            } else {
                // consumed min allowed
                text = "\(text)\nMin: Complete, Max: \(self.maxCount)"
            }
        } else {
            // consumed some
            text = "\(text)\nMin: \(self.minCount), Max: \(self.maxCount)"
        }
        
        let range = (text as NSString).rangeOfString("You have not consumed this.")
        
        let attributedString = NSMutableAttributedString(string:text)
        attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor() , range: range)
        
        return attributedString
    }
    
    var prettyFormRemaining: String {
        
        var text = ""
        
        if self.consumedCount >= self.minCount {
            
            if self.consumedCount == self.maxCount {
                // consumed max allowed
               
            } else {
                // consumed min allowed
                
                let rem = self.maxCount - self.consumedCount
                let units = rem <= 1 ? "unit" : "units"
                
                text = "You have consumed the minimum allowed for today. You need \(rem) more \(units) to complete the maximum."
            }
        } else {
            // consumed some
            let rem = self.minCount - self.consumedCount
            let units = rem <= 1 ? "unit" : "units"
            
            text = "You need \(rem) more \(units) to complete the minimum."
        }
        
        return text
    }
    
    func addConsumption(amount: Float) -> NSError? {
        
        var error: NSError?
        
        if self.consumedCount < self.maxCount {
            
            if (self.consumedCount + amount) <= self.maxCount {
                self.consumedCount = self.consumedCount + amount
                
                DashRepo().synchronize()
                
            } else {
                error = NSError(domain: "Dash", code: 300, userInfo: ["message":"Consuming this much exceeds daily allowed."])
            }
        } else {
            error = NSError(domain: "Dash", code: 300, userInfo: ["message":"You have consumed enough of this item."])
        }
        
        return error
    }
    
    init(title: String, minCount: Float, maxCount: Float, servingSizes: [String]) {
        self.title = title
        self.minCount = minCount
        self.maxCount = maxCount
        self.servingSizes = servingSizes
        
        super.init()
    }
}