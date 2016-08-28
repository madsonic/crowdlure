//
//  DiscoverCellDataProvider.swift
//  crowdlure
//
//  Created by Gerald on 27/8/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import Foundation
import SwiftyJSON

class PollCellDataProvider: DataProvider {
    
    var poll: JSON
    var question: String {
        return poll["title"].stringValue
    }

    var pollID: Int {
        return poll["id"].intValue
    }

    var bizName: String {
        let bizName = poll["business"]["name"].stringValue
        return bizName
    }

    var choices: [JSON] {
        return poll["choices"].arrayValue
    }

    var choicesTexts: [String] {
        return choices.map {
            $0["title"].stringValue
        }
    }

    var choicesVotes: [Int] {
        return choices.map {
            $0["count"].intValue
        }
    }

    var choiceID: [Int] {
        return choices.map {
            $0["id"].intValue
        }
    }

    var endDate: String {
        return poll["end_date"].string?.simplifyDate() ?? ""
    }

    var pollImgData: NSData?
    
    init(poll: JSON) {
        self.poll = poll
    }
    
    override func loadServerData(loadMore loadMore: Bool) {
        getDataFromUrl(NSURL(string: self.poll["image_url"].string ?? "")!) { (data, response, error)  in
            guard let data = data where error == nil else { return }
            dispatch_async(dispatch_get_main_queue(), {
                self.pollImgData = data
                self.delegate?.dataUpdated()
            })
        }
    }
}
