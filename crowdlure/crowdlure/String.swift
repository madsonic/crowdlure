//
//  String.swift
//  crowdlure
//
//  Created by Ian Ngiaw on 8/28/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import Foundation

extension String {
    func simplifyDate() -> String {
        let dateParser = NSDateFormatter()
        dateParser.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateParser.dateFromString(self)
        
        let dateConverter = NSDateFormatter()
        dateConverter.dateFormat = "MMM d"
        return dateConverter.stringFromDate(date!)
    }
}