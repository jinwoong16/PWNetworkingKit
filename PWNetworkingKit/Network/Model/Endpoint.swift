//
//  Endpoint.swift
//  PWNetworkingKit
//
//  Created by jinwoong Kim on 10/11/23.
//

import Foundation

public struct Endpoint<R: Decodable>: Requestable, Responsable {
    public typealias Response = R

    public var baseURL: String
    public var path: String
    public var method: HttpMethod
    public var headers: [HttpHeader]?
    public var body: Data?
}
