//
//  ProductServiceProtocol.swift
//  bil403
//
//  Created by Gürhan Kuraş on 12/20/21.
//

import Foundation
import Combine

protocol ProductServiceProtocol {
    //func getProductsBy(category: String) -> AnyPublisher<[Product], Error>
    func fetch(by: ProdCategory) -> AnyPublisher<[Product], Error>
    func search(matching query: String) -> AnyPublisher<[Product], Error>
    func reduceStock(for productId: Product.ID) -> AnyPublisher<ApiMessage, Error>
}
