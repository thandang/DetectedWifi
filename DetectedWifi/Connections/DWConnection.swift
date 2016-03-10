//
//  DWConnection.swift
//  DetectedWifi
//
//  Created by Dang Thanh Than on 3/8/16.
//  Copyright © 2016 Than Dang. All rights reserved.
//

import Foundation

let API = ServerRequest._instance
let MAIN_URL = "https://come-stay.vn/real_estate/json"
let Secret_Key = "cf3ff988aba465848ada655509f6ca53ae216ba14a42dfd7dd5d77185b40e8a2962a6f477e2a7f1d668b8104fa73fafa"
let Cookie_Key = "csrf_cookie_comestay"


enum CSPath: String {
    case    Highlight = "/best_properties",
            Lastest = "/properties",
            Detail = "/property",
            PushTracking = "/tracking_push_property",
            RequestList = "/request_listing",
            FavouritedList = "/my_favorite",
            FavouriteRE = "/favorite_property",
            RemoveFavourite = "/unfavorite_property",
            CommentProperty = "/comment_property",
            CommentList = "/comment_property_list",
            MessageToAgent = "/message_agent",
            AgentProperty = "/agent",
            FollowAgent = "/follow_agent",
            UnfollowAgent = "/unfollow_agent",
            NewsList = "/posts",
            NewsDetail = "/post",
            Login = "/login",
            Logout = "/logout",
            Cities = "/cities",
            Districts = "/districts",
            PushDevice = "/user_device",
            FirstRequest = "/index"
}


final class ServerRequest: NSObject {
    static let _instance = ServerRequest()
    private var cookieString = ""
    private var retryTime = 0
    
    var authToken: String? {
        didSet {
            if let _ = authToken {
                var header = cfg.HTTPAdditionalHeaders
                if let _ = header {
                    header!["auth_token"] = authToken!
                } else {
                    header = [NSObject : AnyObject]()
                }
                self.cfg.HTTPAdditionalHeaders = header
                self.manager = Manager(configuration: cfg)
            } else {
                self.cfg.HTTPAdditionalHeaders?.removeValueForKey("auth_token")
                self.manager = Manager(configuration: cfg)
            }
        }
    }
    
    let cfg = NSURLSessionConfiguration.defaultSessionConfiguration()
    let cooks = NSHTTPCookieStorage.sharedHTTPCookieStorage()
    var manager : Manager
    
    let lockKey = "something"
    
    override init() {
        cfg.HTTPCookieStorage = cooks
        cfg.HTTPCookieAcceptPolicy = NSHTTPCookieAcceptPolicy.Always
        cfg.HTTPAdditionalHeaders = ["access_token": Secret_Key]
        
        manager = Manager(configuration: cfg)

        super.init()
    }
    
    //MARK: initial request
    func createCookie () {
        manager.request(.GET, MAIN_URL + CSPath.FirstRequest.rawValue).response {[unowned self]response in
            print("response: \(response)")
            self .updateCookie()
        }
    }
    
    func updateCookie () {
        let csCookie = cooks.cookies
        let currentCookie = csCookie?.filter{(cookie) in
            cookie.name == Cookie_Key
        }
        if currentCookie?.count > 0 {
            cookieString = currentCookie![0].value //unwrap
        } else {
            cookieString = ""
        }
    }
}
