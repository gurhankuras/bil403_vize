//
//  Product.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/7/21.
//

import Foundation


struct Product: Identifiable, Codable {
    var id: Int
    var name: String
    var image: String
    var cost: Double
    var additionalInfo: String
    var category: String?
}
