//
//  MockProductService.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/21/21.
//

struct MockError: Error {
    
}

import Foundation
import Combine

final class MockProductService: ProductServiceProtocol {
    let products: [Product]?
    let error: Error?
    let message: ApiMessage?
    
    init(products: [Product]? = nil, error: Error? = nil, message: ApiMessage? = nil) {
        self.products = products
        self.error = error
        self.message = message
    }
    
    func fetch(by: ProdCategory) -> AnyPublisher<[Product], Error> {
        guard let products = self.products else {
            assert(error != nil)
            return Fail(error: error!)
                .eraseToAnyPublisher()
        }
        
        return Just(products)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    // TODO: implement
    func search(matching query: String) -> AnyPublisher<[Product], Error> {
        return Just(products!)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func reduceStock(for productId: Product.ID) -> AnyPublisher<ApiMessage, Error> {
        guard let apiMessage = self.message else {
            assert(error != nil)
            return Fail(error: error!)
                .eraseToAnyPublisher()
        }
        
        return Just(apiMessage)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

extension MockProductService {
    static func failingService() -> MockProductService {
        return .init(products: nil, error: MockError(), message: nil)
    }
    
    static func succedingService(products: [Product]?, message: ApiMessage? = nil) -> MockProductService {
        return .init(products: products, error: nil, message: message)
    }
}
