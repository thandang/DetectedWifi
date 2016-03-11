//
//  IntegerTransform.swift
//  CSMobile
//
//  Created by Phan Quang ha on 10/22/15.
//  Copyright © 2015 cs. All rights reserved.
//

import Foundation

public class IntTransform: TransformType {
    public typealias Object = Int
    public typealias JSON = String
    
    public init() {}
    
    public func transformFromJSON(value: AnyObject?) -> Int? {
        if let timeInt = value as? String {
            return Int(timeInt)
        }
        return nil
    }
    
    public func transformToJSON(value: Int?) -> String? {
        if let number = value {
            return String(number)
        }
        return nil
    }
}