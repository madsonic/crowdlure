//
//  DiscoverCellDataProvider.swift
//  crowdlure
//
//  Created by Gerald on 27/8/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import Foundation
import SwiftyJSON

class LureDataProvider {

    var lure: JSON
    
    init(lure: JSON) {
        self.lure = lure
    }
    
    func getTitle() -> String {
        return self.lure["title"].string ?? ""
    }
    
    func getBoostCount() -> Int {
        let transactions = self.lure["transactions"].array ?? []
        var n = 0
        for t in transactions {
            n += t["amount"].int ?? 0
        }
        return n
    }
    
    func getTargetCount() -> Int {
        return self.lure["targets"][0]["amount"].int ?? 0
    }
    
    func getStartDate() -> String {
        return self.lure["start_date"].string ?? ""
    }
    
    func getValidTill() -> String {
        return self.lure["end_date"].string ?? ""
    }
    
    func getBoostPercent() -> Double {
        return Double(getBoostCount()) / Double(getTargetCount())
    }
    
    func getPrice() -> Float {
        return self.lure["price"].float ?? 0.0
    }
    
    func getTargetDescriptions() -> [String] {
        var n = 3
        if self.lure["targets"].count < 3 {
            n = self.lure["targets"].count
        }
        var descriptions = [String]()
        for i in 0..<n {
            descriptions.append(self.lure["targets"][i]["description"].string ?? "")
        }
        return descriptions
    }
    
    func getLureTitle() -> String {
        return self.lure["title"].string ?? ""
    }
    
    func getBusinessName() -> String {
        return self.lure["business"]["name"].string ?? ""
    }
    
    func getLocation() -> String {
        return self.lure["location"].string ?? ""
    }
    
    func getPhoneNumber() -> String {
        return "650 123 4567"
    }
}
