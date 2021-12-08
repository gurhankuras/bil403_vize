//
//  Product.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/7/21.
//

import Foundation


struct Product: Identifiable, Codable {
    let id: String
    let name: String
    let cost: Double
    let additionalInfo: String
}
