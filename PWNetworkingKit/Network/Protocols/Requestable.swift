//
//  Requestable.swift
//  PWNetworkingKit
//
//  Created by jinwoong Kim on 10/11/23.
//

import Foundation

public protocol Requestable {
    var baseURL: String { get }
    var path: String { get }
    var method: HttpMethod { get }
    var headers: [HttpHeader]? { get }
    var body: Data? { get }
}

extension Requestable {
    private func url() throws -> URL {
        guard let url = URL(string: baseURL) else {
            throw URLError(.badURL)
        }
        
        return url.appending(path: path)
    }
    
    func buildRequest() throws -> URLRequest {
        let url = try url()
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        
        return request
    }
}
