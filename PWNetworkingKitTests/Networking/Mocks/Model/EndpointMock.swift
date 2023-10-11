//
//  EndpointMock.swift
//  PWNetworkingKitTests
//
//  Created by jinwoong Kim on 10/11/23.
//

import Foundation
@testable import PWNetworkingKit

let endpointMock = Endpoint<ModelMock>(
    baseURL: "https://reqres.in/",
    path: "",
    method: .GET
)
