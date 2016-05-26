//
//  DetailVC.swift
//  MyDash
//
//  Created by Joseph Daryl Locsin on 25/05/2016.
//  Copyright © 2016 Joseph Daryl Locsin. All rights reserved.
//

import Foundation
import UIKit


class DetailVC: UIViewController {
    
    var selectedItem: DashItem?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        if let _title = self.selectedItem?.title {
            self.title = _title
        }
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.tableView.separatorStyle = .None
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.translucent = false
    }
}

extension DetailVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let _item = self.selectedItem {
            return _item.servingSizes.count + 1 // for the photo
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell = UITableViewCell()
        
        guard let _item = self.selectedItem else {
            return cell
        }
        
        if indexPath.row == 0 {
            if let _cell = tableView.dequeueReusableCellWithIdentifier("DetailImageCell", forIndexPath: indexPath) as? DetailImageCell {
                
                _cell.photo.image = _item.photo
                
                cell = _cell
            }
        } else {
            
            let trueIndex = indexPath.row - 1
            
            if _item.servingSizes.indices.contains(trueIndex) {
               
                let desc = _item.servingSizes[trueIndex]
                
                if let _cell = tableView.dequeueReusableCellWithIdentifier("DetailTextCell", forIndexPath: indexPath) as? DetailTextCell {
                    
                    _cell.photo.image = UIImage(named: "dash_arrow")
                    _cell.desc.text = desc
                
                    cell = _cell
                }
            }
        }
        
        cell.selectionStyle = .None
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 160
        } else {
            return 44
        }
    }
}