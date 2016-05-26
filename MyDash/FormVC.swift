//
//  FormVC.swift
//  MyDash
//
//  Created by Joseph Daryl Locsin on 25/05/2016.
//  Copyright © 2016 Joseph Daryl Locsin. All rights reserved.
//

import Foundation
import UIKit


class FormVC: UIViewController {
    
    var selectedItem: DashItem?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func tappedCancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        self.navigationController?.navigationBar.tintColor = UIColor.redColor()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: self, action: Selector())
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showDetail" {
            if let _detailVC = segue.destinationViewController as? DetailVC {
                _detailVC.selectedItem = self.selectedItem
            }
        }
    }
}

extension FormVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DashRepo().incompleteItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellId = "FormCell"
        
        var cell = UITableViewCell()
        
        if DashRepo().incompleteItems.indices.contains(indexPath.row) {
            
            cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath)
            
            let item = DashRepo().incompleteItems[indexPath.row]
            
            if let _cell = cell as? FormCell {
                
                _cell.photo.image = item.photo
                _cell.title.text = item.title
                _cell.desc.text = item.prettyFormRemaining
                
                _cell.addHandler = { ()->Void in
                    
                    let alertController = UIAlertController(title: item.title, message: "Please add your consumption below.", preferredStyle: .Alert)
                    
                    alertController.addTextFieldWithConfigurationHandler({ (textField) in
                        textField.placeholder = "example 0.5 or 1"
                        textField.keyboardType = .NumbersAndPunctuation
                    })
                    
                    alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action) in
                        
                        if let _field = alertController.textFields?.first {
                            _field.resignFirstResponder()
                        }
                    }))
                    
                    alertController.addAction(UIAlertAction(title: "Save", style: .Default, handler: { (action) in
                        
                        if let _field = alertController.textFields?.first {
                            
                            guard let _text = _field.text else {
                                return
                            }
                            
                            if (_text as NSString).floatValue > 0 {
                                let error = item.addConsumption((_text as NSString).floatValue)
                                
                                if let _error = error {
                                    print("[ERROR] \(_error.description)")
                                } else {
                                    if item.isIncomplete {
                                        self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Left)
                                    } else {
                                        self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Left)
                                        
                                        // prevents wrong indexing
                                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                                            NSThread.sleepForTimeInterval(0.7)
                                            
                                            dispatch_async(dispatch_get_main_queue(), {
                                                self.tableView.reloadData()
                                            })
                                        })
                                    }
                                }
                            }
                        }
                    }))
                    
                    self.presentViewController(alertController, animated: true) {
                        
                    }
                }
                
                cell = _cell
            }
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if DashRepo().incompleteItems.indices.contains(indexPath.row) {
            
            self.selectedItem = DashRepo().incompleteItems[indexPath.row]
            
            self.performSegueWithIdentifier("showDetail", sender: self)
            
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 88
    }
}