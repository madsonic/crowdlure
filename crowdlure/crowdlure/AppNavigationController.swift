//
//  AppNavigationController.swift
//  crowdlure
//
//  Created by Gerald on 27/8/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import UIKit

class AppNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        UINavigationBar.appearance().titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.wordColor(),
             NSFontAttributeName: UIFont.cairoBoldFont(19)]
        UINavigationBar.appearance().tintColor = .deepGrayColor()
    }
}