//
//  LureDetailDataProvider.swift
//  crowdlure
//
//  Created by Wenqi on 8/27/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import Foundation
import SwiftyJSON

class LureDetailDataProvider: DataProvider {
    
    var lure: JSON
    
    init(lure: JSON) {
        self.lure = lure
        super.init()
    }
    
}