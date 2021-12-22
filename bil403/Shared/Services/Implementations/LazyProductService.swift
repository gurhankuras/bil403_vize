//
//  LazyProductService.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/22/21.
//

import Foundation
import Combine

// Virtual Proxy
class LazyProductService: ProductServiceProtocol {
    let networkService: NetworkServiceProtocol
    
    lazy private var productService: ProductServiceProtocol = {
       return ProductService(networkService: networkService)
    }()
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetch(by: ProdCategory) -> AnyPublisher<[Product], Error> {
        return productService.fetch(by: by)
    }
    
    func search(matching query: String) -> AnyPublisher<[Product], Error> {
        return productService.search(matching: query)
    }
    
    func reduceStock(for productId: Product.ID) -> AnyPublisher<ApiMessage, Error> {
        return productService.reduceStock(for: productId)
    }
}
