//
//  DWConnection.swift
//  DetectedWifi
//
//  Created by Dang Thanh Than on 3/8/16.
//  Copyright © 2016 Than Dang. All rights reserved.
//

import Foundation

let API = ServerRequest._instance

final class ServerRequest: NSObject {
    static let _instance = ServerRequest()
    
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
                
            }
        }
    }
    
    let cfg = NSURLSessionConfiguration.defaultSessionConfiguration()
    let cooks = NSHTTPCookieStorage.sharedHTTPCookieStorage()
}
