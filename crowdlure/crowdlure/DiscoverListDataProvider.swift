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
    
    var lures: [JSON]
    var polls: [JSON]
    
    override init() {
        self.lures = [JSON]()
        self.polls = [JSON]()
        super.init()
    }
    
    func removePollAtIndex(idx: Int) {
        if idx < self.polls.count {
            self.polls.removeAtIndex(idx)
            self.delegate?.dataUpdated()
        }
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