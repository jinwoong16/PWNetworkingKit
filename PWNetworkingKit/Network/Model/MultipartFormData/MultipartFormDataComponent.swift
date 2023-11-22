//
//  MultipartFormDataComponent.swift
//  PWNetworkingKit
//
//  Created by jinwoong Kim on 11/22/23.
//

import Foundation

public enum MultipartFormDataComponent {
    case text(name: String, value: String)
    case file(name: String, filename: String, data: Data)
    
    var disposition: Data {
        var formData = Data()
        switch self {
            case let .text(name, value):
                formData.append("Content-Disposition: form-data; name=\"\(name)\"\r\n\r\n".toData())
                formData.append("\(value)\r\n".toData())
                
                return formData
            case let .file(name, filename, data):
                formData.append("Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(filename)\"\r\n".toData())
                // TODO: application/octet-stream, audio/mp4, image/jpeg, image/png ...
                formData.append("Content-Type: application/octet-stream\r\n\r\n".toData())
                formData.append(data)
                formData.append("\r\n".toData())
                
                return formData
        }
    }
}
