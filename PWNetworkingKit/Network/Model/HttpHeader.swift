//
//  HttpHeader.swift
//  PWNetworkingKit
//
//  Created by jinwoong Kim on 10/8/23.
//

import Foundation

public enum HttpHeader {
    case accept(MediaType)
    case acceptVersion(String)
    case authorization(AuthorizationType)
    case contentType(MediaType)
    
    var key: String {
        switch self {
            case .accept, .acceptVersion:
                return "Accept"
            case .authorization:
                return "Authorization"
            case .contentType:
                return "Content-Type"
        }
    }
    
    var value: String {
        switch self {
            case .accept(let mediaType):
                return mediaType.headerValue
            case .acceptVersion(let value):
                return value
            case .authorization(let authType):
                switch authType {
                    case .basic(let encryptedCredentials):
                        return "Basic \(encryptedCredentials)"
                    case .bearer(let token):
                        return "Bearer \(token)"
                }
            case .contentType(let mediaType):
                return mediaType.headerValue
        }
    }
}
