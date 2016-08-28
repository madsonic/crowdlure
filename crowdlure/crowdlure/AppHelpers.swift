//
//  AppHelpers.swift
//  crowdlure
//
//  Created by Wenqi on 8/27/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import Foundation

func getFBToken() -> String? {
    return (UIApplication.sharedApplication().delegate as! AppDelegate).fbToken
}

public extension UIFont {
    class func navigationTitleStyle() -> UIFont {
        return UIFont.systemFontOfSize(14)
    }
}