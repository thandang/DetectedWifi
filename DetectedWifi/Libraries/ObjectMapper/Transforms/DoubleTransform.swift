//
//  DoubleTransform.swift
//  CSMobile
//
//  Created by Phan Quang ha on 10/22/15.
//  Copyright © 2015 cs. All rights reserved.
//

import Foundation

public class DoubleTransform: TransformType {
    public typealias Object = Double
    public typealias JSON = String
    
    public init() {}
    
    public func transformFromJSON(value: AnyObject?) -> Double? {
        if let timeInt = value as? String {
            return Double(timeInt)
        }
        return nil
    }
    
    public func transformToJSON(value: Double?) -> String? {
        if let number = value {
            return String(number)
        }
        return nil
    }
}