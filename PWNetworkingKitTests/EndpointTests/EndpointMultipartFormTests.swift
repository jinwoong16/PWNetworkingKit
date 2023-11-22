//
//  EndpointMultipartFormTests.swift
//  PWNetworkingKitTests
//
//  Created by jinwoong Kim on 11/22/23.
//

import XCTest
@testable import PWNetworkingKit

final class EndpointMultipartFormTests: XCTestCase {
    private var endpoint: Endpoint<ResponseMock>!
    private var boundary: String!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        boundary = UUID().uuidString
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        boundary = nil
        endpoint = nil
    }

    /**
     ```
     --{BOUNDARY}
     Content-Disposition: form-data; name="config";
     
     {SOME_DATA}
     --{Boundary}--
     ```
     */
    func test_composeBody_withTextCase() throws {
        endpoint = Endpoint(
            baseURL: "baseURL",
            path: "path",
            method: .POST,
            headers: [.contentType(.multipartForm(boundary: boundary))],
            boundary: boundary
        ) {
            MultipartFormDataComponent.text(name: "config", value: "{ }")
        }
        
        let request = try endpoint.buildRequest()
        guard let body = request.httpBody else {
            XCTFail("‼️ http request body is empty.")
            return
        }
        let expectation = "--\(boundary!)\r\nContent-Disposition: form-data; name=\"config\"\r\n\r\n{ }\r\n--\(boundary!)--\r\n"
        let result = String(data: body, encoding: .utf8)!
        
        XCTAssertEqual(expectation, result)
    }
    
    /**
     ```
     --{BOUNDARY}
     Content-Disposition: form-data; name="file"; filename="audio.m4a"
     Content-Type: application/octet-stream
     
     {SOME_AUDIO_DATA}
     --{Boundary}--
     ```
     */
    func test_composeBody_withFileCase() throws {
        let fakeAudioData = "some_audio_data".toData()
        
        endpoint = Endpoint(
            baseURL: "baseURL",
            path: "path",
            method: .POST,
            headers: [.contentType(.multipartForm(boundary: boundary))],
            boundary: boundary
        ) {
            MultipartFormDataComponent.file(name: "file", filename: "audio.m4a", data: fakeAudioData)
        }
        let request = try endpoint.buildRequest()
        guard let body = request.httpBody else {
            XCTFail("‼️ http request body is empty.")
            return
        }
        
        let expectation = "--\(boundary!)\r\nContent-Disposition: form-data; name=\"file\"; filename=\"audio.m4a\"\r\nContent-Type: application/octet-stream\r\n\r\nsome_audio_data\r\n--\(boundary!)--\r\n"
        let result = String(data: body, encoding: .utf8)!
        
        XCTAssertEqual(expectation, result)
    }

}
