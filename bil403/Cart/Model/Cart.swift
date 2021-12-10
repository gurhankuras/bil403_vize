//
//  Cart.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/10/21.
//

import Foundation
import CloudKit


struct CartItem: Identifiable {
    let id: UUID = UUID()
    let product: Product
    
    init(product: Product, count: Int) {
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
    
    /*
    class Point {
      private var _x: Int = 0             // _x -> backingX
      var x: Int {
        set { _x = 2 * newValue }
        get { return _x / 2 }
      }
    }
     */
}

class Cart: ObservableObject {
    enum CartError: Error {
        case keyNotFound
    }
    
    @Published var items = [String: CartItem]()
    @Published var loading = false
    @Published var totalAmount = 0.0
    
    init(data: [String: CartItem] = [:]) {
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
    
    
}
