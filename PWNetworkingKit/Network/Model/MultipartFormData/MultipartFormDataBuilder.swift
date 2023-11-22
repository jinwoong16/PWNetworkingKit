//
//  MultipartFormDataBuilder.swift
//  PWNetworkingKit
//
//  Created by jinwoong Kim on 11/22/23.
//

import Foundation

@resultBuilder
struct MultipartFormDataBuilder {
    typealias Component = MultipartFormDataComponent
    
    static func buildBlock(_ components: Component...) -> [Component] {
        components
    }
}
