//
//  DiscoverNavigationController.swift
//  crowdlure
//
//  Created by Gerald on 27/8/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import UIKit

class DiscoverNavigationController: AppNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        let vc = DiscoverListViewController()
        self.pushViewController(vc, animated: false)
    }

    func setupUI() {

    }

}