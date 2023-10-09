//
//  MediaType.swift
//  PWNetworkingKit
//
//  Created by jinwoong Kim on 10/8/23.
//

import Foundation

public struct MediaType: OptionSet {
    public let rawValue: Int
    
    static let json = MediaType(rawValue: 1 << 0)
    static let html = MediaType(rawValue: 1 << 1)
    static let plainText = MediaType(rawValue: 1 << 2)
    static let form = MediaType(rawValue: 1 << 3)
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    var headerValue: String {
        var values = [String]()
        
        if self.contains(.json) {
            values.append("application/json")
        }
        if self.contains(.html) {
            values.append("text/html")
        }
        if self.contains(.plainText) {
            values.append("text/plainText")
        }
        if self.contains(.form) {
            values.append("application/x-www-form-urlencoded")
        }
        
        return values.joined(separator: "; ")
    }
}
