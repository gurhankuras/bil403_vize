//
//  DummyProductService.swift
//  bil403Tests
//
//  Created by Gürhan Kuraş on 12/24/21.
//

@testable import bil403

import Foundation
import Combine

struct MockError: Error {
    
}

/// http://xunitpatterns.com/Dummy%20Object.html
/// 
final class DummyProductService: ProductServiceProtocol {
    private let errorMessage = "Should not call method. message from Dummy"
    
    func fetch(by: ProdCategory) -> AnyPublisher<[Product], Error> {
        fatalError(errorMessage)
    }
    
    func search(matching query: String) -> AnyPublisher<[Product], Error> {
        fatalError(errorMessage)
    }
    
    func reduceStock(for productId: Product.ID) -> AnyPublisher<ApiMessage, Error> {
        fatalError(errorMessage)
    }
}

