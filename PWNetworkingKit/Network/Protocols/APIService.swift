//
//  APIService.swift
//  PWNetworkingKit
//
//  Created by jinwoong Kim on 10/8/23.
//

import Foundation

public protocol APIService {
    var session: URLSession { get }
}

public extension APIService {
    func request<R: Decodable, E: Requestable & Responsable>(
        with endpoint: E
    ) async throws -> R where E.Response == R {
        let request = try endpoint.buildRequest()
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw HttpError.badResponse
        }
        
        let result: R = try decode(data: data)
        
        return result
    }
    
    private func decode<T: Decodable>(data: Data) throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
