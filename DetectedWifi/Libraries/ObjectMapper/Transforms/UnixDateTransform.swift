//
//  UnixDateTransform.swift
//  CSMobile
//
//  Created by Phan Quang ha on 10/22/15.
//  Copyright © 2015 cs. All rights reserved.
//

import Foundation

public class UnixDateTransform: TransformType {
    public typealias Object = NSDate
    public typealias JSON = String
    
    public init() {}
    
    public func transformFromJSON(value: AnyObject?) -> NSDate? {
        if let valueString = value as? String{
            if let timeInt = Double(valueString) {
                return NSDate(timeIntervalSince1970: NSTimeInterval(timeInt))
            }
        }
        
        return nil
    }
    
    public func transformToJSON(value: NSDate?) -> String? {
        if let date = value {
            return String(date.timeIntervalSince1970)
        }
        return nil
    }
}