//
//  LureTableViewController.swift
//  crowdlure
//
//  Created by Wenqi on 8/27/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import UIKit
import SwiftyJSON

class LureTableViewController: UITableViewController {
    
    var dataProvider: LureDataProvider
    
    init(lure: JSON) {
        self.dataProvider = LureDataProvider(lure: lure)
        super.init(style: UITableViewStyle.Plain)
        self.tableView.separatorStyle = .None
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.tableView.separatorStyle = .None
        self.tableView.allowsSelection = false
    }
    
    // MARK: TableView
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .deepGrayColor()
        return view
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 36
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 || indexPath.row == 3 {
            return LureAttributeCell(key: nil, val: nil)
        } else {
            switch (indexPath.row) {
            case 1:
                return LureAttributeCell(key: "Started", val: self.dataProvider.getStartDate())
            case 2:
                return LureAttributeCell(key: "Ends", val: self.dataProvider.getValidTill())
            case 4:
                return LureAttributeCell(key: "Address", val: self.dataProvider.getLocation())
            case 5:
                return LureAttributeCell(key: "Phone", val: self.dataProvider.getPhoneNumber())
            default:
                return LureAttributeCell(key: nil, val: nil)
            }
        }
    }
    
}