//
//  Advertisement.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/12/21.
//

import Foundation


struct Advertisement: Decodable {
    let id: Int
    let image: String
    
    private enum CodingKeys : String, CodingKey {
        case id="Id", image
    }
}
