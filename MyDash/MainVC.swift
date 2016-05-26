//
//  MainVC.swift
//  MyDash
//
//  Created by Joseph Daryl Locsin on 25/05/2016.
//  Copyright © 2016 Joseph Daryl Locsin. All rights reserved.
//

import Foundation
import UIKit


class MainVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var selectedItem: DashItem?
    
    @IBAction func tappedAdd(sender: AnyObject) {
    
        self.performSegueWithIdentifier("modalForm", sender: self)
    }
    
    @IBAction func tappedAbout(sender: AnyObject) {
        
        self.performSegueWithIdentifier("modalAbout", sender: self)
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
        
        self.navigationController?.navigationBar.translucent = true
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DashRepo().myItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = "MainCell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath)
        
        if DashRepo().myItems.indices.contains(indexPath.row) {
            
            let item = DashRepo().myItems[indexPath.row]
            
            if let _cell = cell as? MainCell {
                _cell.title.text = item.title
                _cell.thumbnail.image = item.photo
                _cell.content.attributedText = item.prettyRemaining
                
                if item.isMaxComplete {
                    _cell.disclosurePhoto.image = UIImage(named: "dash_maxcheck")
                } else if item.isMinComplete {
                    _cell.disclosurePhoto.image = UIImage(named: "dash_mincheck")
                } else {
                    _cell.disclosurePhoto.image = nil
                }
                
                cell = _cell
            }
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if DashRepo().myItems.indices.contains(indexPath.row) {
            
            self.selectedItem = DashRepo().myItems[indexPath.row]
            
            self.performSegueWithIdentifier("showDetail", sender: self)
            
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
}