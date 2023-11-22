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
    
    public init(
        baseURL: String,
        path: String,
        method: HttpMethod,
        headers: [HttpHeader]? = nil,
        body: Data? = nil
    ) {
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.headers = headers
        self.body = body
    }
    
    public init(
        baseURL: String,
        path: String,
        method: HttpMethod,
        headers: [HttpHeader],
        boundary: String,
        @MultipartFormDataBuilder body: () -> [MultipartFormDataComponent]
    ) {
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.headers = headers
        self.body = composeBody(with: body(), boundary: boundary)
    }
    
    public init(
        baseURL: String,
        path: String,
        method: HttpMethod,
        headers: [HttpHeader],
        body: [String: String]
    ) {
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.headers = headers
        self.body = composeBody(with: body)
    }
}

private extension Endpoint {
    func composeBody(with components: [MultipartFormDataComponent], boundary: String) -> Data {
        var formData = Data()
        
        for component in components {
            formData.append("--\(boundary)\r\n".toData())
            formData.append(component.disposition)
        }
        formData.append("--\(boundary)--\r\n".toData())
        
        return formData
    }
    
    func composeBody(with keyValue: [String: String]) -> Data {
        keyValue
            .map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
            .toData()
    }
}
