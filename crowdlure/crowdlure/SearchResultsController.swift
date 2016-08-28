//
//  SearchResultsController.swift
//  crowdlure
//
//  Created by Gerald on 27/8/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import UIKit

class SearchResultsController: UITableViewController, UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {

    var parentVC: UIViewController?

    init() {
        super.init(style: .Grouped)
        self.tableView.separatorStyle = .None
        self.tableView.keyboardDismissMode = .OnDrag
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateSearchResultsForSearchController(searchController: UISearchController) {

    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Search Results"
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 110
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return SearchTableCell()
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        tableView.deselectRowAtIndexPath(indexPath, animated: false)
//        let vc = LureDetailViewController()
//        vc.hidesBottomBarWhenPushed = true
//        self.parentVC?.navigationController?.pushViewController(vc, animated: true)
    }

}
