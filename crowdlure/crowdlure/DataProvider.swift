//
//  DataProvider.swift
//  crowdlure
//
//  Created by Wenqi on 8/27/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import Foundation

protocol DataProviderDelegate: NSObjectProtocol {
    func dataUpdated()
    func dataProviderStatusUpdated()
    func updateItems(additions additions:[Int], deletions:[Int], inSection section: Int, key: String?)
}

extension DataProviderDelegate {
    func updateItems(additions additions:[Int], deletions:[Int], inSection section: Int, key: String?) {
        self.dataUpdated()
    }
    
    func dataProviderStatusUpdated() {
        
    }
}

class DataProvider: NSObject {
    var notificationType: String?
    
    weak var delegate:DataProviderDelegate? {
        didSet {
            BroadcastCenter.sharedInstance.removeObserver(self)
            if self.delegate != nil {
                if let notifications = self.registeredNotifications() {
                    for notifID in notifications {
                        BroadcastCenter.sharedInstance.addObserver(self, selector: #selector(DataProvider.processNotification(_:)), notification: notifID)
                    }
                }
            }
        }
    }
    
    override init() {
    
    }
    
    func processNotification(notif: NSNotification) {
        var data = [BCNotificationKey: AnyObject]()
        if let info = notif.userInfo {
            for (key, value) in info {
                if let k = key as? String {
                    if let bcKey = BCNotificationKey(rawValue: k) {
                        data[bcKey] = value
                    }
                }
            }
        }
        
        if self.shouldProcessNotification(data, type: notif.name) {
            dispatch_async(dispatch_get_main_queue(), {
                self.notificationType = notif.name
                self.loadData(notification: data)
                if self.shouldLoadDataAsync() == false {
                    self.delegate?.dataUpdated()
                    self.postUpdateData()
                }
            })
        }
    }
    
    // Call this in viewDidLoad method of view controller
    func viewDidLoad() {
        self.initialLoadData()
        if (!self.shouldLoadDataAsync()) {
            self.delegate?.dataUpdated()
        }
    }
    
    func shouldProcessNotification(data: [BCNotificationKey: AnyObject], type: String) -> Bool {
        return true
    }
    
    func shouldLoadDataAsync() -> Bool {
        return false
    }
    
    // Don't override
    func initialLoadData() {
        self.loadServerData()
        self.loadData()
    }
    
    // Override
    func loadData(notification notif:[BCNotificationKey: AnyObject]? = nil) {
    }
    
    // Override
    func loadServerData(loadMore loadMore: Bool = false) {
    }
    
    // After delegate updated the data
    func postUpdateData() {
    }
    
    // Override
    func registeredNotifications() -> [BCNotification]? {
        return nil
    }
    
    deinit {
        if let notifications = self.registeredNotifications() {
            for notifID in notifications {
                BroadcastCenter.sharedInstance.removeObserver(self, notification: notifID)
            }
        }
    }
}

