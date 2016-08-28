//
//  LureTableViewController.swift
//  crowdlure
//
//  Created by Wenqi on 8/27/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import UIKit

class LureTableViewController: UITableViewController {
    
    let purchaseDate = "12 August 2016"
    let validTill = "2 September 2016"
    let address = "Happy Tree Street CA 123201"
    let contact = "650 653 1033"
    
    init() {
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
        return 10
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 36
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return LureAttributeCell()
    }
    
}