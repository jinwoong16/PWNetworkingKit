//
//  MockApiService.swift
//  PWNetworkingKitTests
//
//  Created by jinwoong Kim on 10/9/23.
//

import Foundation
@testable import PWNetworkingKit

final class MockApiService: APIService {
    var baseURL: URL
    var session: URLSession
    
    init(baseURL: URL, session: URLSession) {
        self.baseURL = baseURL
        self.session = session
    }
}
