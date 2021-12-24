//
//  ProductServiceSabouterStub.swift
//  bil403Tests
//
//  Created by Gürhan Kuraş on 12/24/21.
//

@testable import bil403

import Foundation
import Combine

final class ProductServiceSaboteurStub: ProductServiceProtocol {
    let error: Error
    
    init(error: Error) {
        self.error = error
    }
    
    func fetch(by: ProdCategory) -> AnyPublisher<[Product], Error> {
        return Fail(error: error)
            .eraseToAnyPublisher()
    }
    
    func search(matching query: String) -> AnyPublisher<[Product], Error> {
        return Just([])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func reduceStock(for productId: Product.ID) -> AnyPublisher<ApiMessage, Error> {
        return Fail(error: error)
            .eraseToAnyPublisher()
    }
}
