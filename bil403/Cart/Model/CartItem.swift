//
//  CartItem.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/17/21.
//

import Foundation

struct CartItem: Identifiable {
    let id: UUID
    let product: Product
    
    init(id: UUID = UUID(), product: Product, count: Int) {
        self.id = id
        self.product = product
        self._count = count
    }
    
    private var _count: Int
    var count: Int {
        set {
            if newValue >= 0 {
                _count = newValue
            }
        }
        get { return _count }
    }
}


struct ProductBundle: Codable {
    let productId: Int
    let count: Int
}
