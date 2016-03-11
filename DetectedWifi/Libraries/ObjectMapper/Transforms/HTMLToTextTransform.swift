//
//  HTMLToTextTransform.swift
//  CSMobile
//
//  Created by Quang Ha on 11/8/15.
//  Copyright © 2015 cs. All rights reserved.
//

import Foundation


public class HTMLToTextTransform: TransformType {
    public typealias Object = String
    public typealias JSON = String
    
    public init() {}
    
    public func transformFromJSON(value: AnyObject?) -> String? {
        if let html = value as? String {
            return html.decodedHTML()
        }
        return nil
    }
    
    public func transformToJSON(value: String?) -> String? {
        if let text = value {
            return text
        }
        return nil
    }
}