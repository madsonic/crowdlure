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

extension UIViewController {
    func presentModalView(vc:UIViewController, animated: Bool = true) {
        let nav = UINavigationController(rootViewController: vc)
        self.presentViewController(nav, animated: animated) {
            vc.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(UIViewController.dismissModalViewAnimated))
        }
    }

    func dismissModalViewAnimated() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

class DiscoverListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ACTabScrollViewDelegate, ACTabScrollViewDataSource, DataProviderDelegate {
    
    let pollData = [
        ["Philz Coffee", "What flavour of coffee would you like to see?", 5, 12],
        ["BMW", "What would be a good incentive to get a BMW?", 3, 6],
        ["Coca Cola", "Would a visit to our factory appeal to you?", 3, 12],
        ["Waka Waka", "What lure should we have next for you?", 4, 24]
    ]
    
    var dataProvider: DiscoverListDataProvider
    var tabViews: [UITableView]

    private let discoverTabScrollView = ACTabScrollView()
    private let discoverTableView = UITableView()
    
    let categories: [DiscoverCategory] = [.Polls, .Nearby, .Popular, .Favorites]

    private let numberOfPages = 5

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
        let view = UIView.init(frame: UIScreen.mainScreen().bounds)
        view.backgroundColor = UIColor.whiteColor()
        self.view = view

        setupTabScrollView()
        setupLayoutConstraints()
        
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


    // MARK: TableView
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let discoverTableView = tableView as? DiscoverTableView {
            if discoverTableView.category == .Favorites {
                return CampaignHeaderView(merchantName: "Artistry", merchantLocation: "420 S Wolfe Road, Sunnyvale")
            } else if discoverTableView.category == .Polls {
                return CampaignHeaderView(merchantName: "Philz Coffee", merchantLocation: "Some Location")
            }
        }

        return nil
    }

    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8.0
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
                return self.pollData.count
            }
        }
        return 0
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if let discoverTableView = tableView as? DiscoverTableView where discoverTableView.category == .Polls {
            return 250
        }
//        if let discoverTableView = tableView as? DiscoverTableView {
//            if discoverTableView.category == .Polls {
//                return 160
//            } else if discoverTableView.category == .Campaign {
//                return 500
//            }

        return 240
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let discoverTableView = tableView as! DiscoverTableView
        if discoverTableView.category == .Polls {
            let poll = self.pollData[0]
            return PollCell(bizName: poll[0] as! String, question: poll[1] as! String, choiceCount: poll[2] as! Int, answerCount: poll[3] as! Int)
        } else {
            switch (discoverTableView.category) {
            case .Nearby:
                break
            case .Popular:
                break
            case .Favorites:
                break
            case .Polls:
                break
            }
            return DiscoverCell()
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
                let lureInfo = self.dataProvider.lures[indexPath.row]
                let vc = LureDetailViewController(lure: lureInfo)
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
