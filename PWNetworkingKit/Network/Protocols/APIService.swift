//
//  APIService.swift
//  PWNetworkingKit
//
//  Created by jinwoong Kim on 10/8/23.
//

import Foundation

public protocol APIService {
    var baseURL: URL { get }
    var session: URLSession { get }
}

extension APIService {
    func call(
        url: URL,
        method: HttpMethod = .GET,
        headers: [HttpHeader]? = nil,
        body: Data? = nil
    ) async throws -> Data {
        let request = buildRequest(with: url, method: method, headers: headers, body: body)
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw HttpError.badResponse
        }
        
        return data
    }
    
    private func buildRequest(
        with url: URL,
        method: HttpMethod,
        headers: [HttpHeader]? = nil,
        body: Data? = nil
    ) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        
        return request
    }
}

class VITOApiService: APIService {
    var baseURL: URL
    var session: URLSession
    
    init(baseURL: URL, session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
    }
    
    func trasncribe() {
        /// check access
        /// if granted
        /// call api and return data
        
    }
}
