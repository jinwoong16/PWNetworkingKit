//
//  HttpError.swift
//  PWNetworkingKit
//
//  Created by jinwoong Kim on 10/8/23.
//

import Foundation

public enum HttpError: Error {
    case invalidRequest
    case unexpectedBody
    case badResponse
    case invalidUrl
}
