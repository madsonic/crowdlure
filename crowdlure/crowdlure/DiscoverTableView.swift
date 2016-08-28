//
//  DiscoverTableView.swift
//  crowdlure
//
//  Created by Gerald on 27/8/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import UIKit

enum DiscoverCategory: String {
    case Nearby = "NEARBY",
    Favorites = "FAVORITES",
    Popular = "POPULAR",
    Polls = "POLLS"
}

class DiscoverTableView: UITableView {

    var category: DiscoverCategory

    init(category: DiscoverCategory) {
        self.category = category
        super.init(frame: CGRectZero, style: .Plain)
        self.separatorColor = UIColor.clearColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}