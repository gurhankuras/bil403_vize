//
//  Order.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/17/21.
//

import Foundation

struct Order: Encodable {
    let userId: Int
    let addressId: Int
    let paymentMethodId: Int
    let purchasedItems: [ProductBundle]
}
