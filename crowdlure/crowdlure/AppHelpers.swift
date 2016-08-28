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

public extension UIViewController {
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

public extension UIFont {
    class func navigationTitleStyle() -> UIFont {
        return UIFont(name: cairoBold, size: 14)!
    }

    class func scrollTabStyle() -> UIFont {
        return UIFont(name: cairoRegular, size: 10)!
    }

    class func cairoRegularFont(size: CGFloat) -> UIFont {
        return UIFont(name: cairoRegular, size: size)!
    }

    class func cairoBoldFont(size: CGFloat) -> UIFont {
        return UIFont(name: cairoBold, size: size)!
    }

    class func quattroRegularFont(size: CGFloat) -> UIFont {
        return UIFont(name: quattrocentoSansRegular, size: size)!
    }

    class func quattroBoldFont(size: CGFloat) -> UIFont {
        return UIFont(name: quattrocentoSansBold, size: size)!
    }
}