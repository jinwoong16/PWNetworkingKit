//
//  MediaType.swift
//  PWNetworkingKit
//
//  Created by jinwoong Kim on 10/8/23.
//

import Foundation


public enum MediaType {
    case json
    case html
    case plainText
    case multipartForm(boundary: String)
    
    var headerValue: String {
        switch self {
            case .json:
                return "application/json"
            case .html:
                return "text/html"
            case .plainText:
                return "text/plainText"
            case let .multipartForm(boundary):
                return "multipart/form-data; \(boundary)"
        }
    }
}
