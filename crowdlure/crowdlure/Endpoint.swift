//
//  Endpoint.swift
//  crowdlure
//
//  Created by Gerald on 27/8/16.
//  Copyright © 2016 com.gerald. All rights reserved.
//

import Alamofire
import SwiftyJSON

/**
 Wrapper class for all server side APIs.

 ````
 // use case
 request(Endpoint.service(args...))
 ````
 */
enum Endpoint: URLRequestConvertible {
    // update with your end point
    static let baseURL = "https://sheltered-bayou-29760.herokuapp.com"

    // MARK: Endpoints

    // MARK:- Auth
    case authUser(fbAccessToken: String)

    // MARK:- Biz
    case getBusinesses
    case getBusiness(id: Int)
    case searchBusiness(query: String)

    // MARK:- Lures
    case getLures
    case getLure(id: Int)
    case getBusinessLures(bizID: Int)
    case searchLure(query: String)

    // MARK:- Choice for Poll
    // pass nil to choice to clear previous selections
    // this is for customers to use
    case submitChoiceForPoll(bizID: Int, pollID: Int, choiceID: Int?)

    // MARK:- Polls
    case getBusinessPoll(bizID: Int, pollID: Int)
    case getBusinessPolls(bizID: Int)

    // MARK: - Endpoints params
    var URLRequest: NSMutableURLRequest {
        let url = NSURL(string: Endpoint.baseURL)!
        let mutableURLRequest = NSMutableURLRequest(URL: url.URLByAppendingPathComponent(path))
        if let delegate = UIApplication.sharedApplication().delegate as? AppDelegate, token = delegate.hashToken {
            mutableURLRequest.setValue(token, forHTTPHeaderField: "Authorization")
        }
        mutableURLRequest.HTTPMethod = method.rawValue

        var param = [String: AnyObject]()

        switch self {
        case let .authUser(accessToken):
            param = ["facebook_access_token": accessToken]

        case .getBusinesses, .getBusiness:
            break

        case .searchBusiness(let query):
            param = ["query": query]

        case .getLures, getLure, .getBusinessLures:
            break

        case .searchLure(let query):
            param = ["query": query]

        case let .submitChoiceForPoll(_, _, choice):
            if let choice = choice {
                param = ["choice": choice]
            } else {
                break
            }

        case .getBusinessPoll, getBusinessPolls:
            break

        }

        if method == .POST {
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: param).0
        } else {
            return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: param).0
        }
    }

    // MARK:- Request Methods
    var method: Alamofire.Method {
        switch self {
        case .authUser,
             .submitChoiceForPoll:

            return .POST

        case .getBusinesses,
             .getBusiness,
             .searchBusiness,
             .getLure,
             .getBusinessLures,
             .getLures,
             .searchLure,
             .getBusinessPoll,
             .getBusinessPolls:

            return .GET
        }
    }

    // MARK:- Endpoints
    var path: String {
        switch self {
        case .authUser: return "/auth/user"
        case .getBusinesses: return "/businesses"
        case .getBusiness(let id): return "/businesses/\(id)"
        case .searchBusiness: return "/businesses/search"

        case .getLure(let id): return "/lures/\(id)"
        case .getLures: return "/lures"
        case .getBusinessLures(let bizID): return "/businesses/\(bizID)/lures"
        case .searchLure: return "/lures/search"

        case let .submitChoiceForPoll(bizID, pollID, _): return "/businesses/\(bizID)/polls/\(pollID)/choice"

        case let .getBusinessPoll(bizID, pollID): return "/businesses/\(bizID)/polls/\(pollID)"
        case let .getBusinessPolls(bizID): return "/businesses/\(bizID)/polls"
        }
    }
}

// MARK: - Alamofire
extension Request {
    typealias ResponseData = AnyObject
    typealias SuccessHandler = (ResponseData) -> ()
    typealias FailureHandler = (NSError) -> ()
    func responseJSON(successHandler successHandler: SuccessHandler?, failureHandler: FailureHandler?) {

        responseJSON { response in
            switch response.result {
            case .Success(let data):
                guard let successHandler = successHandler else {
                    return
                }
                successHandler(data)
                
            case .Failure(let error):
                guard let failureHandler = failureHandler else {
                    return
                }
                failureHandler(error)
            }
        }
    }
}