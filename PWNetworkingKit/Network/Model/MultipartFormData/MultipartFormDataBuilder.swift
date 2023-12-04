//
//  MultipartFormDataBuilder.swift
//  PWNetworkingKit
//
//  Created by jinwoong Kim on 11/22/23.
//

import Foundation

@resultBuilder
public struct MultipartFormDataBuilder {
    public typealias Component = MultipartFormDataComponent
    
    public static func buildBlock(_ components: Component...) -> [Component] {
        components
    }
}
