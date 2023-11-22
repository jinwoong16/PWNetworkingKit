//
//  String+.swift
//  PWNetworkingKit
//
//  Created by jinwoong Kim on 11/22/23.
//

import Foundation

extension String {
    func toData() -> Data {
        Data(self.utf8)
    }
}
