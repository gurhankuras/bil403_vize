//
//  ProductServiceResponderStub.swift
//  bil403Tests
//
//  Created by Gürhan Kuraş on 12/24/21.
//

import Foundation
import Combine

@testable import bil403

/// http://xunitpatterns.com/Test%20Stub.html
/// 
final class ProductServiceResponserStub: ProductServiceProtocol {
    let products: [Product]
    let message: ApiMessage?
    
    init(products: [Product] = [], message: ApiMessage? = nil) {
        self.products = products
        self.message = message
    }
    
    func fetch(by: ProdCategory) -> AnyPublisher<[Product], Error> {
        return Just(products)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func search(matching query: String) -> AnyPublisher<[Product], Error> {
        return Just(products)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func reduceStock(for productId: Product.ID) -> AnyPublisher<ApiMessage, Error> {
        return Just(message!)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    
}
