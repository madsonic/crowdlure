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

class DiscoverListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ACTabScrollViewDelegate, ACTabScrollViewDataSource {

    let pollData = [
        ["Philz Coffee", "What flavour of coffee would you like to see?", 5, 12],
        ["BMW", "What would be a good incentive to get a BMW?", 3, 6],
        ["Coca Cola", "Would a visit to our factory appeal to you?", 3, 12],
        ["Waka Waka", "What lure should we have next for you?", 4, 24]
    ]

    private let discoverTabScrollView = ACTabScrollView()
    private let discoverTableView = UITableView()

    private let numberOfPages = 5

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Discover"

        let view = UIView.init(frame: UIScreen.mainScreen().bounds)
        view.backgroundColor = UIColor.whiteColor()
        self.view = view

        self.discoverTabScrollView.translatesAutoresizingMaskIntoConstraints = false
        self.discoverTabScrollView.defaultPage = 1
        self.discoverTabScrollView.tabSectionHeight = 40
        self.discoverTabScrollView.pagingEnabled = true
        self.discoverTabScrollView.cachedPageLimit = 3
        self.discoverTabScrollView.delegate = self
        self.discoverTabScrollView.dataSource = self

        self.view.addSubview(self.discoverTabScrollView)

        self.setupLayoutConstraints()

        print("init")
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        delegate.hashToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInR5cGUiOiJVc2VyIn0.LvykZ9svrudRAGBFYZxfrxY3f7hSBxh3MRUE_ZeVEo8"


        //        let foo = request(Endpoint.authUser(fbAccessToken: "EAAZAOSWC8L9kBACZCOBSf4cM1ibVHhmE6ROZC2Wy82tRxC6yOVMdtaoTjuPOhRcYEHrfVSv12fKoyy2QaYf8ToYjSYyIjd3A8YR1aiZBfeZAWmX4KgKbMbE8DSdafuuUy3JVagJOj5XqTo2NZCoTBKt8ZAZBY8QQLabgJBi8aLJ8kAZDZD"))
        //        let foo = request(Endpoint.getBusinesses)
        //        let foo = request(Endpoint.getBusiness(id: 3))
        //        let foo = request(Endpoint.searchBusiness(query: ""))
        //        let foo = request(Endpoint.searchLure(query: "a"))
        //        let foo = request(Endpoint.getBusinessPoll(bizID: 1, pollID: 2))
        //        let foo = request(Endpoint.submitChoiceForPoll(bizID: 1, pollID: 2, choiceID: 4))
        //        foo.responseJSON(successHandler: { rawResp in
        //            let resp = JSON(rawResp)
        //            print(resp)
        //            }, failureHandler: { error in
        //                print(error)
        //        })
        //        print(foo.debugDescription)
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

    // MARK: ACTabScrollViewDelegate
    func tabScrollView(tabScrollView: ACTabScrollView, didChangePageTo index: Int) {

    }

    func tabScrollView(tabScrollView: ACTabScrollView, didScrollPageTo index: Int) {

    }

    // MARK: ACTabScrollViewDataSource
    func numberOfPagesInTabScrollView(tabScrollView: ACTabScrollView) -> Int {
        return numberOfPages
    }

    func tabScrollView(tabScrollView: ACTabScrollView, tabViewForPageAtIndex index: Int) -> UIView {
        // create a label
        let label = UILabel()
        switch index {
        case 0:
            label.text = DiscoverCategory.Polls.rawValue
        case 1:
            label.text = DiscoverCategory.Popular.rawValue
        case 2:
            label.text = DiscoverCategory.Nearby.rawValue
        case 3:
            label.text = DiscoverCategory.Favorites.rawValue
        case 4:
            label.text = DiscoverCategory.Campaign.rawValue
        default:
            assertionFailure("U missed out a case")
        }
        label.font = UIFont.systemFontOfSize(16, weight: UIFontWeightThin)
        label.textColor = UIColor(red: 77.0 / 255, green: 79.0 / 255, blue: 84.0 / 255, alpha: 1)
        label.textAlignment = .Center

        // if the size of your tab is not fixed, you can adjust the size by the following way.
        label.sizeToFit() // resize the label to the size of content
        label.frame.size = CGSize(width: label.frame.size.width + 28, height: label.frame.size.height + 22) // add some paddings
        return label
    }

    func tabScrollView(tabScrollView: ACTabScrollView, contentViewForPageAtIndex index: Int) -> UIView {
        var discoverTableView: DiscoverTableView!

        switch (index) {
        case 0:
            discoverTableView = DiscoverTableView(category: .Polls)
        case 1:
            discoverTableView = DiscoverTableView(category: .Popular)
        case 2:
            discoverTableView = DiscoverTableView(category: .Nearby)
        case 3:
            discoverTableView = DiscoverTableView(category: .Favorites)
        case 4:
            discoverTableView = DiscoverTableView(category: .Campaign)
        default:
            break
        }

        discoverTableView.delegate = self
        discoverTableView.dataSource = self
        discoverTableView.registerClass(DiscoverCell.self, forCellReuseIdentifier: "DiscoverCell")
        discoverTableView.registerClass(PollCell.self, forCellReuseIdentifier: "PollCell")
        return discoverTableView
    }


    // MARK: TableView
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8.0
    }

    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8.0
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let discoverTableView = tableView as? DiscoverTableView {
            switch (discoverTableView.category) {
            case .Nearby:
                return 1
            case .Popular:
                return 2
            case .Favorites:
                return 3
            case .Polls:
                return self.pollData.count
            case .Campaign:
                return 1
            }
        }
        return 0
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if let discoverTableView = tableView as? DiscoverTableView where discoverTableView.category == .Polls {
            return 160
        }
        return 240
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let discoverTableView = tableView as! DiscoverTableView
        if discoverTableView.category == .Polls {
            let poll = self.pollData[indexPath.section]
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
            case .Campaign:
                break
            }
            return DiscoverCell()
        }
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        if let discoverTableView = tableView as? DiscoverTableView {
            switch (discoverTableView.category) {
            case .Nearby:
                break
            case .Popular:
                break
            case .Favorites:
                break
            case .Polls:
                break
            case .Campaign:
                break
            }
            let vc = LureDetailViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
