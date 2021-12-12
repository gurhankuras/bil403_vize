//
//  Product.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/7/21.
//

import Foundation


struct Product: Identifiable, Codable {
    let id: Int
    let name: String
    let image: String
    let cost: Double
    let additionalInfo: String
    var category: String?
    
    /*
    private enum CodingKeys : String, CodingKey {
        case id="Id", image="Image", cost="Price", additionalInfo="Description"
    }
     */
}
