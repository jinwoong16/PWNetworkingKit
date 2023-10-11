//
//  Endpoint.swift
//  PWNetworkingKit
//
//  Created by jinwoong Kim on 10/11/23.
//

import Foundation

struct Endpoint<R: Decodable>: Requestable, Responsable {
    typealias Response = R

    var baseURL: String
    var path: String
    var method: HttpMethod
    var headers: [HttpHeader]?
    var body: Data?
}
