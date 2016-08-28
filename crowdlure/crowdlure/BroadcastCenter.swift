//
//  BroadcastCenter.swift
//  crowdlure
//
//  Created by Wenqi on 8/27/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import Foundation

enum BCNotificationKey: String {
    case HasMore = "hasMore",
    HasNew = "hasNew"
}

enum BCNotification: String
{
    case PaymentSuccessful = "PaymentSuccessful",
    PaymentFailure = "PaymentFailure"
}

class BroadcastCenter {
    static let sharedInstance = BroadcastCenter()
    
    func addObserver(observer: AnyObject, selector aSelector: Selector, notification type: BCNotification) {
        NSNotificationCenter.defaultCenter().addObserver(observer, selector: aSelector, name: type.rawValue, object: nil)
    }
    
    func removeObserver(observer: AnyObject, notification type: BCNotification) {
        NSNotificationCenter.defaultCenter().removeObserver(observer, name: type.rawValue, object: nil)
    }
    
    func postNotification(type: BCNotification, information: [BCNotificationKey: AnyObject] = [BCNotificationKey: AnyObject]()) {
        var info = [String: AnyObject]()
        for (key, value) in information {
            info[key.rawValue] = value
        }
        NSNotificationCenter.defaultCenter().postNotificationName(type.rawValue, object: nil, userInfo: info)
    }
    
    func removeObserver(observer: AnyObject) {
        NSNotificationCenter.defaultCenter().removeObserver(observer)
    }
    
    class func postNotificationAsync(type: BCNotification, information: [BCNotificationKey: AnyObject] = [BCNotificationKey: AnyObject]()) {
        var info = [String:AnyObject]()
        for (key, value) in information {
            info[key.rawValue] = value
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            NSNotificationCenter.defaultCenter().postNotificationName(type.rawValue, object: nil, userInfo: info)
        })
    }
    
    class func postNotificationAsync(type: BCNotification) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            BroadcastCenter.sharedInstance.postNotification(type)
        })
    }
}
