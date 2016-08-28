//
//  PurchaseListViewController.swift
//  crowdlure
//
//  Created by Gerald on 27/8/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import UIKit

class PurchaseListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ACTabScrollViewDelegate, ACTabScrollViewDataSource, DataProviderDelegate {

    private let purchaseTabScrollView = ACTabScrollView()
    private let redeemedTableView = UITableView()
    private let unredeemedTableView = UITableView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.redeemedTableView.separatorStyle = .None
        self.redeemedTableView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        self.redeemedTableView.delegate = self
        self.redeemedTableView.dataSource = self
        self.redeemedTableView.registerClass(PurchaseCell.self, forCellReuseIdentifier: "PurchaseCell")

        self.unredeemedTableView.separatorStyle = .None
        self.unredeemedTableView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        self.unredeemedTableView.delegate = self
        self.unredeemedTableView.dataSource = self
        self.unredeemedTableView.registerClass(PurchaseCell.self, forCellReuseIdentifier: "PurchaseCell")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "PURCHASES"
        let view = UIView.init(frame: UIScreen.mainScreen().bounds)
        view.backgroundColor = UIColor.whiteColor()
        self.view = view
        
        setupTabScrollView()
        setupLayoutConstraints()
    }
    
    func setupTabScrollView() {
        self.purchaseTabScrollView.translatesAutoresizingMaskIntoConstraints = false
        self.purchaseTabScrollView.defaultPage = 1
        self.purchaseTabScrollView.tabSectionHeight = 40
        self.purchaseTabScrollView.pagingEnabled = true
        self.purchaseTabScrollView.cachedPageLimit = 3
        self.purchaseTabScrollView.delegate = self
        self.purchaseTabScrollView.dataSource = self
        self.view.addSubview(self.purchaseTabScrollView)
    }
    
    func setupLayoutConstraints() {
        let views = [
            "purchaseTabScrollView": self.purchaseTabScrollView
        ]
        
        var allConstraints = [NSLayoutConstraint]()
        allConstraints += getConstraintFromFormat("H:|[purchaseTabScrollView]|", views: views)
        allConstraints += getConstraintFromFormat("V:|-65-[purchaseTabScrollView]-49-|", views: views)
        NSLayoutConstraint.activateConstraints(allConstraints)
    }
    
    func dataUpdated() {
       
    }
    
    // MARK: ACTabScrollViewDelegate
    func tabScrollView(tabScrollView: ACTabScrollView, didChangePageTo index: Int) {
        
    }
    
    func tabScrollView(tabScrollView: ACTabScrollView, didScrollPageTo index: Int) {
        
    }
    
    // MARK: ACTabScrollViewDataSource
    func numberOfPagesInTabScrollView(tabScrollView: ACTabScrollView) -> Int {
        return 2
    }
    
    func tabScrollView(tabScrollView: ACTabScrollView, tabViewForPageAtIndex index: Int) -> UIView {
        let label = UILabel()
        if index == 0 {
            label.text = "UNREDEEMED"
        } else {
            label.text = "REDEEMED"
        }
        label.font = UIFont.cairoRegularFont(16)
        label.textColor = .wordColor()
        label.textAlignment = .Center
        
        // if the size of your tab is not fixed, you can adjust the size by the following way.
        label.sizeToFit() // resize the label to the size of content
        label.frame.size = CGSize(width: label.frame.size.width + 28, height: label.frame.size.height + 13) // add some paddings
        return label
    }
    
    func tabScrollView(tabScrollView: ACTabScrollView, contentViewForPageAtIndex index: Int) -> UIView {
        if index == 0 {
            return self.unredeemedTableView
        } else {
            return self.redeemedTableView
        }
    }

    // MARK: TableView
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 16.0
        }
        return 8.0
    }

    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8.0
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 130
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: PurchaseCell
        if indexPath.row > 2 {
            cell = PurchaseCell(expired: true)
        } else {
            cell = PurchaseCell()
        }
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        let vc = PurchaseDetailViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}