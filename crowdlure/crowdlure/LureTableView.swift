//
//  LureTableView.swift
//  crowdlure
//
//  Created by Gerald on 27/8/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import UIKit

class LureTableView: UITableView {

    init() {
        super.init(frame: CGRectZero, style: .Grouped)
        self.separatorColor = UIColor.clearColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}