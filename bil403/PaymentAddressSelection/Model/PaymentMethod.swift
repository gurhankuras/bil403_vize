//
//  PaymentMethod.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/12/21.
//

import Foundation

struct PaymentMethod: Identifiable, Codable {
    let id: Int
    let name: String
    //let firstSixDigits: String
    let lastThreeDigits: String
    
    var maskedCardNumber: String {
        return "\(String.init(repeating: "*", count: 14))\(lastThreeDigits)"
    }
}
