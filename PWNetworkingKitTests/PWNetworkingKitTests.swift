//
//  PWNetworkingKitTests.swift
//  PWNetworkingKitTests
//
//  Created by jinwoong Kim on 10/11/23.
//

import XCTest
@testable import PWNetworkingKit

final class PWNetworkingKitTests: XCTestCase {
    var apiService: APIService!
    
    override func setUpWithError() throws {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLSessionProtocol.self]
        let urlSession = URLSession(configuration: configuration)
        
        apiService = APIServiceMock(session: urlSession)
    }
    
    override func tearDownWithError() throws {
        apiService = nil
    }
    
    func test_request_withValidRequest_shouldReturnData() async throws {
        guard let path = Bundle(for: PWNetworkingKitTests.self).url(forResource: "static", withExtension: "json"),
              let data = try? Data(contentsOf: path) else {
            XCTFail("Failed to get the static file.")
            return
        }
        
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(
                url: URL(string: "https://reqres.in/")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )
            
            return (response!, data)
        }
        
        let result = try await apiService.request(
            with: endpointMock
        )
        
        XCTAssertEqual(result.id, "769b76e8bcad0a9b5aef27751a705d98")
    }
    
}
