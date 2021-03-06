//
//  PurchaseListDataProvider.swift
//  crowdlure
//
//  Created by Wenqi on 8/28/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import Alamofire
import SwiftyJSON
import Foundation

class PurchaseListDataProvider: DataProvider {
    
    var lures: [JSON]
    
    override init() {
        self.lures = [JSON]()
        super.init()
    }
    
    override func loadServerData(loadMore loadMore: Bool = false) {
        let lureRequest = request(Endpoint.getLures)
        lureRequest.responseJSON(
            successHandler: { rawResp in
                let resp = JSON(rawResp)
                for lure in resp["lures"].arrayValue {
                    if lure["is_purchased"] {
                        self.lures.append(lure)
                    }
                }
                //self.lures = resp["lures"].arrayValue
                self.delegate?.dataUpdated()
                self.delegate?.dataProviderStatusUpdated()
            },
            failureHandler: { error in
                print(error)
        })
    }
}