//
//  HTTPUrlResponse.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/10/21.
//

import Foundation

extension HTTPURLResponse {
    var isGoodStatusCode: Bool {
        return statusCode >= 200 && statusCode < 300
    }
}
