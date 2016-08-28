//
//  DiscoverListDataProvider.swift
//  crowdlure
//
//  Created by Wenqi on 8/27/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import Alamofire
import SwiftyJSON
import Foundation

class DiscoverListDataProvider: DataProvider {
    
    let pollData = [
        ["Philz Coffee", "What flavour of coffee would you like to see?", 5, 12],
        ["BMW", "What would be a good incentive to get a BMW?", 3, 6],
        ["Coca Cola", "Would a visit to our factory appeal to you?", 3, 12],
        ["Waka Waka", "What lure should we have next for you?", 4, 24]
    ]
    
    var lures: [JSON]
    var polls: [JSON]
    
    override init() {
        self.lures = [JSON]()
        self.polls = [JSON]()
        super.init()
    }
    
    override func loadServerData(loadMore loadMore: Bool = false) {
        let lureRequest = request(Endpoint.getLures)
        lureRequest.responseJSON(
            successHandler: { rawResp in
                let resp = JSON(rawResp)
                self.lures = resp["lures"].arrayValue
                self.delegate?.dataUpdated()
            },
            failureHandler: { error in
                print(error)
            })
        
        let pollRequest = request(Endpoint.getPolls)
        pollRequest.responseJSON(
            successHandler: { rawResp in
                let resp = JSON(rawResp)
                self.polls = resp["polls"].arrayValue
                self.delegate?.dataUpdated()
            },
            failureHandler: { error in
                print(error)
            })
    }
}