//
//  DiscoverListViewController.swift
//  crowdlure
//
//  Created by Gerald on 27/8/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DiscoverListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ACTabScrollViewDelegate, ACTabScrollViewDataSource, DataProviderDelegate, PollCellDelegate {
    
    var dataProvider: DiscoverListDataProvider
    var tabViews: [UITableView]

    private let discoverTabScrollView = ACTabScrollView()
    private let discoverTableView = UITableView()
    
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
    
    let categories: [DiscoverCategory] = [.Polls, .Nearby, .Popular, .Favorites]

    init() {
        self.dataProvider = DiscoverListDataProvider()
        self.tabViews = [UITableView]()
        super.init(nibName: nil, bundle: nil)
        self.dataProvider.delegate = self
        
        for cat in self.categories {
            let discoverTableView = DiscoverTableView(category: cat)
            discoverTableView.delegate = self
            discoverTableView.dataSource = self
            discoverTableView.registerClass(DiscoverCell.self, forCellReuseIdentifier: "DiscoverCell")
            discoverTableView.registerClass(PollCell.self, forCellReuseIdentifier: "PollCell")
            self.tabViews.append(discoverTableView)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "DISCOVER"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Search, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
        let view = UIView.init(frame: UIScreen.mainScreen().bounds)
        view.backgroundColor = UIColor.whiteColor()
        self.view = view

        setupTabScrollView()
        setupLayoutConstraints()
        
        spinner.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        spinner.center = self.view.center
        UIApplication.sharedApplication().keyWindow?.addSubview(spinner)
        spinner.startAnimating()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.dataProvider.viewDidLoad()
    }
    
    func setupTabScrollView() {
        self.discoverTabScrollView.translatesAutoresizingMaskIntoConstraints = false
        self.discoverTabScrollView.defaultPage = 1
        self.discoverTabScrollView.tabSectionHeight = 40
        self.discoverTabScrollView.pagingEnabled = true
        self.discoverTabScrollView.cachedPageLimit = 3
        self.discoverTabScrollView.delegate = self
        self.discoverTabScrollView.dataSource = self
        self.view.addSubview(self.discoverTabScrollView)
    }

    func setupLayoutConstraints() {
        let views = [
            "discoverTabScrollView": self.discoverTabScrollView
        ]

        var allConstraints = [NSLayoutConstraint]()

        let discoverToolbarXConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|[discoverTabScrollView]|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += discoverToolbarXConstraints

        let discoverListYConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-65-[discoverTabScrollView]-49-|",
            options: [],
            metrics: nil,
            views: views)
        allConstraints += discoverListYConstraints

        NSLayoutConstraint.activateConstraints(allConstraints)
    }

    func dataUpdated() {
        for tableView in self.tabViews {
            tableView.reloadData()
        }
    }
    
    func dataProviderStatusUpdated() {
        if self.spinner.isAnimating() {
            self.spinner.stopAnimating()
            self.spinner.removeFromSuperview()
        }
    }
    
    // MARK: ACTabScrollViewDelegate
    func tabScrollView(tabScrollView: ACTabScrollView, didChangePageTo index: Int) {

    }

    func tabScrollView(tabScrollView: ACTabScrollView, didScrollPageTo index: Int) {

    }

    // MARK: ACTabScrollViewDataSource
    func numberOfPagesInTabScrollView(tabScrollView: ACTabScrollView) -> Int {
        return self.categories.count
    }

    func tabScrollView(tabScrollView: ACTabScrollView, tabViewForPageAtIndex index: Int) -> UIView {
        // create a label
        let label = UILabel()
        label.text = self.categories[index].rawValue
        label.font = UIFont.cairoRegularFont(16)
        label.textColor = .wordColor()
        label.textAlignment = .Center

        // if the size of your tab is not fixed, you can adjust the size by the following way.
        label.sizeToFit() // resize the label to the size of content
        label.frame.size = CGSize(width: label.frame.size.width + 28, height: label.frame.size.height + 13) // add some paddings
        return label
    }

    func tabScrollView(tabScrollView: ACTabScrollView, contentViewForPageAtIndex index: Int) -> UIView {
        return tabViews[index]
    }

    // MARK: PollCellDelegate
    func dismissCell(cell: UITableViewCell) {
        let pollTableView = self.tabViews[0]
        if let idx = pollTableView.indexPathForCell(cell)?.section {
            self.dataProvider.removePollAtIndex(idx)
        }
    }

    // MARK: TableView
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let discoverTableView = tableView as? DiscoverTableView {
            if discoverTableView.category != .Polls {
                let name = self.dataProvider.lures[section]["business"]["name"].string ?? ""
                let location = self.dataProvider.lures[section]["location"].string ?? ""
                return CampaignHeaderView(merchantName: name , merchantLocation: location)
            } else {
                let name = self.dataProvider.polls[section]["business"]["name"].string ?? ""
                return CampaignHeaderView(merchantName: name , merchantLocation: "")
            }
        }
        return nil
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let discoverTableView = tableView as? DiscoverTableView {
            switch (discoverTableView.category) {
            case .Nearby:
                return self.dataProvider.lures.count
            case .Popular:
                return self.dataProvider.lures.count
            case .Favorites:
                return self.dataProvider.lures.count
            case .Polls:
                return self.dataProvider.polls.count
            }
        }
        return 0
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if let discoverTableView = tableView as? DiscoverTableView where discoverTableView.category == .Polls {
            return 200
        }
        return 430
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let discoverTableView = tableView as! DiscoverTableView
        if discoverTableView.category == .Polls {
            let poll = self.dataProvider.polls[indexPath.section]
            let cell = PollCell(poll: poll)
            cell.delegate = self
            return cell
        } else {
            let lureInfo = self.dataProvider.lures[indexPath.section]
            return DiscoverCell(lure: lureInfo)
        }
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        if let discoverTableView = tableView as? DiscoverTableView {
            if discoverTableView.category == .Polls {
                //let vc = LureDetailViewController()
                //vc.hidesBottomBarWhenPushed = true
                //self.navigationController?.pushViewController(vc, animated: true)
            } else {
                let lureInfo = self.dataProvider.lures[indexPath.section]
                let vc = LureDetailViewController(lure: lureInfo)
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
