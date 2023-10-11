//
//  APIServiceMock.swift
//  PWNetworkingKitTests
//
//  Created by jinwoong Kim on 10/11/23.
//

import Foundation
@testable import PWNetworkingKit

final class APIServiceMock: APIService {
    var session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
}
