//
//  PWNetworkingKitTests.swift
//  PWNetworkingKitTests
//
//  Created by jinwoong Kim on 10/8/23.
//

import XCTest
@testable import PWNetworkingKit

final class PWNetworkingKitTests: XCTestCase {
    var apiService: APIService!
    var url: URL!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLSessionProtocol.self]
        let urlSession = URLSession(configuration: configuration)
        
        url = URL(string: "https://reqres.in/")!
        apiService = MockApiService(baseURL: url, session: urlSession)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        url = nil
        apiService = nil
    }

    func test_call_withSuccessResponse_shouldReturnData() async throws {
        guard let path = Bundle(for: PWNetworkingKitTests.self).url(forResource: "static", withExtension: "json"),
              let data = try? Data(contentsOf: path) else {
            XCTFail("Failed to get the static file.")
            return
        }
        
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(
                url: self.apiService.baseURL,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )
            
            return (response!, data)
        }
        
        let response = try await apiService.call(
            url: url,
            method: .POST,
            headers: [
                .accept(.json),
                .contentType(.form),
                .authorization(.basic(""))
            ]
        )
        
        XCTAssertEqual(response, data)
    }
}
