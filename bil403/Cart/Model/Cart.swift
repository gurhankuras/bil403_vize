//
//  Cart.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/10/21.
//

import Foundation

final class Cart: ObservableObject {
    enum CartError: Error {
        case keyNotFound
    }
    
    @Published var items = [Int: CartItem]()
    @Published var loading = false
    @Published var totalAmount = 0.0
    
    init(data: [Int: CartItem] = [:]) {
        self.items = data
    }
    
    var isEmpty: Bool {
        return items.isEmpty
    }
    
    func toList() -> [CartItem] {
        return items.map { (_, value) in
            return value
        }
    }
    func add(product: Product) {
        objectWillChange.send()
        guard let existingItem = items[product.id] else {
            let item = CartItem(product: product, count: 1)
            items.updateValue(item, forKey: product.id)
            totalAmount = calculateTotalAmount()
            return
        }
        
        let updatedItem = CartItem(product: existingItem.product, count: existingItem.count + 1)
        items.updateValue(updatedItem, forKey: product.id)
        totalAmount = calculateTotalAmount()
    }
    
    // TODO: TEST
    func remove(product: Product) throws {
        guard let existingItem = items[product.id] else {
            throw CartError.keyNotFound
        }
        objectWillChange.send()
        
        if existingItem.count == 1 {
            items.removeValue(forKey: existingItem.product.id)
        }
        else {
            let updatedItem = CartItem(product: existingItem.product, count: existingItem.count - 1)
            items.updateValue(updatedItem, forKey: product.id)
        }
        totalAmount = calculateTotalAmount()
    }

    
    func clear() {
        if items.isEmpty {
            return
        }
        items.removeAll()
        totalAmount = calculateTotalAmount()
    }
    
    func calculateTotalAmount() -> Double {
        var totalAmount = 0.0
        items.forEach { (id, item) in
            totalAmount += (item.product.cost * Double(item.count))
        }
        return totalAmount
    }
    
    // TEST
    func toOrder(addressId: Int, paymentMethod: Int) -> Order {
        let items = toList()
        let bundles: [ProductBundle] = items.map { cartItem in
            let bundle = ProductBundle(productId: cartItem.product.id, count: cartItem.count)
            return bundle
        }
        
        return Order(userId: 1, addressId: 1, paymentMethodId: paymentMethod, purchasedItems: bundles)
    }
}
