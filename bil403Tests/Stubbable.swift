//
//  Stubbable.swift
//  bil403Tests
//
//  Created by Gürhan Kuraş on 12/18/21.
//

import Foundation
@testable import bil403

/// https://www.swiftbysundell.com/articles/defining-testing-data-in-swift/#stubbing-values
///
/// TODO: look at JSON stubs
protocol Stubbable: Identifiable {
    static func stub(withID id: Self.ID) -> Self
}


extension CartItem: Stubbable {
    static func stub(withID id: UUID) -> CartItem {
        return CartItem(id: id, product: Product.stub(withID: 1), count: 3)
    }
}

extension Product: Stubbable {
    static func stub(withID id: Int) -> Product {
        return Product(id: id, name: "", image: "", cost: 100.0, additionalInfo: "", category: ProdCategory.meyveSebze.rawValue)
    }
}

extension Stubbable {
    func setting<T>(_ keyPath: WritableKeyPath<Self, T>,
                    to value: T) -> Self {
        var stub = self
        stub[keyPath: keyPath] = value
        return stub
    }
}
