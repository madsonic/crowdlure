//
//  LureDetailViewController.swift
//  crowdlure
//
//  Created by Gerald on 27/8/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import UIKit
import MapKit

class LureDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: UI elements
    let lureTableView = LureTableView()
    let purchaseButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        let view = UIView.init(frame: UIScreen.mainScreen().bounds)
        view.backgroundColor = UIColor.whiteColor()
        self.view = view

        self.lureTableView.translatesAutoresizingMaskIntoConstraints = false
        self.lureTableView.delegate = self
        self.lureTableView.dataSource = self
        self.lureTableView.estimatedRowHeight = 280
        self.lureTableView.rowHeight = UITableViewAutomaticDimension

        self.purchaseButton.setTitle("Purchase for $70", forState: .Normal)
        self.purchaseButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.purchaseButton.backgroundColor = self.view.tintColor
        self.purchaseButton.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(self.lureTableView)
        self.view.addSubview(self.purchaseButton)

        setupLayoutConstraints()
    }

    func setupLayoutConstraints() {
        let views = [
            "lureTableView": self.lureTableView,
            "purchaseButton": self.purchaseButton
        ]

        var allConstraints = [NSLayoutConstraint]()

        let mainYConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|[lureTableView][purchaseButton(50)]|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += mainYConstraints

        let purchaseButtonXConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|[purchaseButton]|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += purchaseButtonXConstraints

        let lureTableViewXConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|[lureTableView]|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += lureTableViewXConstraints

        NSLayoutConstraint.activateConstraints(allConstraints)
    }

    // MARK: TableView

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5.0
    }

    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5.0
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if indexPath.section == 0 {
            cell = LureDetailCell()
        } else {
            cell = LureLocationCell()
        }
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }

}
