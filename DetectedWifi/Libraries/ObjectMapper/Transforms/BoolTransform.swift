//
//  BoolTransform.swift
//  CSMobile
//
//  Created by Phan Quang ha on 10/22/15.
//  Copyright © 2015 cs. All rights reserved.
//

import Foundation

public class BoolTransform: TransformType {
    public typealias Object = Bool
    public typealias JSON = String
    
    public init() {}
    
    public func transformFromJSON(value: AnyObject?) -> Bool? {
        if let string = value as? String {
            return string.toBool()
        }
        return nil
    }
    
    public func transformToJSON(value: Bool?) -> String? {
        if let bool = value {
            return String(bool)
        }
        return nil
    }
}

extension String {
    func toBool() -> Bool? {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }
}